sudo apt-get update
sudo apt-get install -y zsh

curl -L git.io/antigen > antigen/antigen.zsh

git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --all