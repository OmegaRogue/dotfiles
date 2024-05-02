function magic-enter-cmd {
	if command git rev-parse --is-inside-work-tree &>/dev/null; then
		printf '%s' ' git status -u .'
	else
		printf '%s' ' [[ $(ls . | wc -l) -le 200 ]] && ([[ $(ls . |wc -l) -le 30 ]] && ls -lh . || ls .)'
	fi
}
auto-ls-ls () {
	count=$(ls . | wc -l)
	if [[ $count -le 200 ]]; then
		if [[ $count -le 30 ]]; then
			ls -lh .
		else
			ls .
		fi
	fi
	[[ $AUTO_LS_NEWLINE != false ]] && echo ""
}
lfcd () {
    tmp="$(mktemp)"
    fid="$(mktemp)"
    lfrun -command '$printf $id > '"$fid"'' -last-dir-path="$tmp" "$@"
    id="$(cat "$fid")"
    archivemount_dir="/tmp/__lf_archivemount_$id"
    if [ -f "$archivemount_dir" ]; then
        cat "$archivemount_dir" | \
            while read -r line; do
                sudo umount "$line"
                rmdir "$line"
            done
        rm -f "$archivemount_dir"
    fi
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        if [ -d "$dir" ]; then
            if [ "$dir" != "$(pwd)" ]; then
                cd "$dir"
            fi
        fi
    fi
}
_zlf() {
    emulate -L zsh
    local d=$(mktemp -d) || return 1
    {
        mkfifo -m 600 $d/fifo || return 1
		if (( ${+TMUX} )); then
			tmux split -bf zsh -c "exec {ZLE_FIFO}>$d/fifo; export ZLE_FIFO; exec lf" || return 1
		else
			(wezterm cli split-pane -- zsh -c "exec {ZLE_FIFO}>$d/fifo; export ZLE_FIFO; exec lf")>/dev/null || return 1
		fi
        local fd
        exec {fd}<$d/fifo
        zle -Fw $fd _zlf_handler
    } always {
        rm -rf $d
    }
}

_zlf_handler() {
    emulate -L zsh
    local line
    if ! read -r line <&$1; then
        zle -F $1
        exec {1}<&-
        return 1
    fi
    eval $line
    zle -R
}

function zvm_after_lazy_keybindings() {
  # Here we define the custom widget
  zvm_define_widget _zlf
  zvm_define_widget _zlf_handler
  zvm_define_widget lfcd

  # In normal mode, press Ctrl-E to invoke this widget
  zvm_bindkey vicmd '^E' _zlf

  zvm_bindkey vicmd '^O' lfcd

}

function unarchive() {
	set -f
    local extract_dir
    if [[ ! -f "$1" ]]; then
        echo "extract: '$1' is not a valid file" >&2
        return 1
    fi
    extract_dir="${1:t:r}"
    case "${1:l}" in
		(*.tar.gz|*.tgz)
			if (( $+commands[pigz] )); then
				pigz -dc "$1" | tar xv
			else
				tar zxvf "$1"
			fi;;
        (*.tar.bz2|*.tbz|*.tbz2) tar xvjf "$1" ;;
        (*.tar.xz|*.txz)
			if tar --xz --help &> /dev/null; then
				tar --xz -xvf "$1"
			else
				xzcat "$1" | tar xvf -
			fi;;
        (*.tar.zma|*.tar.lz|*.tlz)
			if tar --lzma --help &> /dev/null; then
				tar --lzma -xvf "$1"
			else
				lzcat "$1" | tar xvf -
			fi;;
        (*.tar.zst|*.tzst)
			if tar --zstd --help &> /dev/null; then
				tar --zstd -xvf "$1"
			else
				zstdcat "$1" | tar xvf -
			fi;;
        (*.tar) tar xvf "$1" ;;
        (*.gz)
			if (( $+commands[pigz] )); then
				pigz -dk "$1"
			else
				gunzip -k "$1"
			fi;;
        (*.bz2) bunzip2 "$1" ;;
        (*.xz) unxz "$1" ;;
        (*.lzma) unlzma "$1" ;;
        (*.z) uncompress "$1" ;;
        (*.zip|*.war|*.jar|*.sublime-package|*.ipsw|*.xpi|*.apk|*.aar|*.whl) unzip "$1" -d $extract_dir ;;
        (*.rar) unrar x -ad "$1" ;;
        (*.rpm) 
			mkdir "$extract_dir"
			cd "$extract_dir"
			rpm2cpio "../$1"
			cpio --quiet -id 
			cd .. ;;
        (*.7z) 7za x "$1" ;;
        (*.deb)
            mkdir -p "$extract_dir/control"
            mkdir -p "$extract_dir/data"
            cd "$extract_dir"; ar vx "../${1}" > /dev/null
            cd control; tar xzvf ../control.tar.gz
            cd ../data; extract ../data.tar.*
            cd ..; rm *.tar.* debian-binary
            cd ..;;
        (*.zst) unzstd "$1" ;;
        (*)
            echo "extract: '$1' cannot be extracted" >&2
            return 1;;
    esac
	#nfiles=($extract_dir/*(DN))
	#if [ "${#nfiles[@]}" -eq 1 ]; then
	#  mv $nfiles[1] .
	#fi
	return 0
}

function uriencode() {
    setopt localoptions extendedglob
    input=( ${(s::)1} )
    print ${(j::)input/(#b)([^A-Za-z0-9_.\!~*\'\(\)-])/%${(l:2::0:)$(([##16]#match))}}
}
function uridecode() {
  setopt localoptions extendedglob multibyte
  print ${${1//+/ }//(#b)%([[:xdigit:]](#c2))/${(#):-0x$match[1]}}
}
function nostderr() {
	exec 7>&2           # "save" stderr
	exec 2>/dev/null    # redirect
}
function yesstderr() {
	exec 2>&7           # restore
	exec 7>&-           # close descriptor which is no longer needed
}
function nostdout() {
	exec 7>&1           # "save" stdout
	exec 1>/dev/null    # redirect
}
function yesstdout() {
	exec 1>&7           # restore
	exec 7>&-           # close descriptor which is no longer needed
}
yt-list()
{
  youtube-dl -j --flat-playlist "$1" | sed 's/.*\"url\": \"\([^\"]*\)\".*/https:\/\/www.youtube.com\/watch?v=\1/'
}
rga-fzf() {
	RG_PREFIX="rga --files-with-matches"
	local file
	file="$(
		FZF_DEFAULT_COMMAND="$RG_PREFIX '$1'" \
			fzf --sort --preview="[[ ! -z {} ]] && rga --pretty --context 5 {q} {}" \
				--phony -q "$1" \
				--bind "change:reload:$RG_PREFIX {q}" \
				--preview-window="70%:wrap"
	)" &&
	echo "opening $file" &&
	xdg-open "$file"
}

function audio_combine() {
	if [ $# -lt 2 ]
	then
		echo "Usage: audio_combine <source track 1> <source track 2> <out file> [track 1 name] [track 2 name]"
		return
	fi
	if [ $# -eq 2 ]
	then
		ffmpeg -i $1 -i $2 -map 0 -map 1 -c copy $3
		echo "Usage: audio_combine <source track 1> <source track 2> <out file> [track 1 name] [track 2 name]"
		return
	fi
	ffmpeg -i $1 -i $2 -map 0 -map 1 -c copy -metadata:s:a:0 language=$4 -metadata:s:a:0 title="$4" -metadata:s:a:1 language=$5 -metadata:s:a:1 title="$5" $3

}
function anime_dub_sub() {
	if [ $# -lt 2 ]
	then
		echo "Usage: anime_dub_sub <title> <episode> <out>"
		return
	fi
	dub=$(mktemp -d)
	sub=$(mktemp -d)
	pushd $dub
	ani-cli --dub --download --episode $2 $1
	popd
	pushd $sub
	ani-cli --download --episode $2 $1
	popd
	ffmpeg -i $sub/* -i $dub/* -map 0 -map 1 -c copy -metadata:s:a:0 language=jpn -metadata:s:a:0 title="Japanese" -metadata:s:a:1 language=eng -metadata:s:a:1 title="English" $3
	command rm -rf $dub
	command rm -rf $sub
}
