local appmenu = {}

appmenu.Accessories = {
    { 'Archive Manager', 'file-roller', '/usr/share/icons/hicolor/scalable/apps/org.gnome.ArchiveManager.svg' },
    { 'Bitwarden', 'bitwarden-desktop', '/usr/share/icons/hicolor/128x128/apps/bitwarden.png' },
    { 'Books', 'gnome-books', '/usr/share/icons/hicolor/scalable/apps/org.gnome.Books.svg' },
    { 'Calculator', 'gnome-calculator', '/usr/share/icons/hicolor/scalable/apps/org.gnome.Calculator.svg' },
    { 'Characters', '/usr/bin/gnome-characters', '/usr/share/icons/hicolor/scalable/apps/org.gnome.Characters.svg' },
    { 'Clocks', 'gnome-clocks', '/usr/share/icons/hicolor/scalable/apps/org.gnome.clocks.svg' },
    { 'Connections', 'gnome-connections', '/usr/share/icons/hicolor/scalable/apps/org.gnome.Connections.svg' },
    { 'Disks', 'gnome-disks', '/usr/share/icons/hicolor/scalable/apps/org.gnome.DiskUtility.svg' },
    { 'Files', 'nautilus --new-window', '/usr/share/icons/hicolor/scalable/apps/org.gnome.Nautilus.svg' },
    { 'Fonts', 'gnome-font-viewer', '/usr/share/icons/hicolor/scalable/apps/org.gnome.font-viewer.svg' },
    { 'HydraPaper', '/usr/bin/hydrapaper', '/usr/share/icons/hicolor/scalable/apps/org.gabmus.hydrapaper.svg' },
    { 'Logs', 'gnome-logs', '/usr/share/icons/hicolor/scalable/apps/org.gnome.Logs.svg' },
    { 'Maps', 'gapplication launch org.gnome.Maps', '/usr/share/icons/hicolor/scalable/apps/org.gnome.Maps.svg' },
    { 'Neovim', 'xterm -e nvim', '/usr/share/icons/hicolor/128x128/apps/nvim.png' },
    { 'Network Tools', 'gnome-nettool', '/usr/share/icons/hicolor/16x16/apps/gnome-nettool.png' },
    { 'Nextcloud Desktop', 'nextcloud --quit', '/usr/share/icons/hicolor/128x128/apps/Nextcloud.png' },
    { 'NoiseTorch', 'noisetorch', '/usr/share/icons/hicolor/256x256/apps/noisetorch.png' },
    { 'Recipes', 'gnome-recipes', '/usr/share/icons/hicolor/16x16/apps/org.gnome.Recipes.png' },
    { 'Screenshot', 'gnome-screenshot --interactive', '/usr/share/icons/hicolor/scalable/apps/org.gnome.Screenshot.svg' },
    { 'Text Editor', 'gedit', '/usr/share/icons/hicolor/scalable/apps/org.gnome.gedit.svg' },
    { 'To Do', 'gnome-todo', '/usr/share/icons/hicolor/scalable/apps/org.gnome.Todo.svg' },
    { 'Visual Studio Code', '/opt/visual-studio-code/code --no-sandbox --unity-launch' },
    { 'Weather', 'gapplication launch org.gnome.Weather', '/usr/share/icons/hicolor/scalable/apps/org.gnome.Weather.svg' },
    { 'WezTerm', 'wezterm', '/usr/share/icons/hicolor/128x128/apps/org.wezfurlong.wezterm.png' },
    { 'YubiKey Personalization Tool', 'yubikey-personalization-gui', '/usr/share/icons/hicolor/128x128/apps/yubikey-personalization-gui.png' },
    { 'Yubico Authenticator', 'yubioath-desktop' },
    { 'ipython', 'xterm -e ipython' },
    { 'razerCommander', '/usr/bin/razercommander', '/usr/share/icons/hicolor/scalable/apps/org.gabmus.razercommander.svg' },
}

appmenu.Development = {
    { 'Accerciser', 'accerciser', '/usr/share/icons/hicolor/16x16/apps/accerciser.png' },
    { 'Boxes', 'gnome-boxes', '/usr/share/icons/hicolor/scalable/apps/org.gnome.Boxes.svg' },
    { 'Builder', 'gnome-builder', '/usr/share/icons/hicolor/scalable/apps/org.gnome.Builder.svg' },
    { 'CMake', 'cmake-gui', '/usr/share/icons/hicolor/128x128/apps/CMakeSetup.png' },
    { 'Devhelp', 'devhelp', '/usr/share/icons/hicolor/scalable/apps/org.gnome.Devhelp.svg' },
    { 'Electron 14', 'electron14' },
    { 'GHex', 'ghex', '/usr/share/icons/hicolor/scalable/apps/org.gnome.GHex.svg' },
    { 'Glade', 'glade', '/usr/share/icons/hicolor/scalable/apps/org.gnome.Glade.svg' },
    { 'JetBrains Toolbox', '/home/omegarogue/.local/share/JetBrains/Toolbox/bin/jetbrains-toolbox', '/home/omegarogue/.local/share/JetBrains/Toolbox/toolbox.svg' },
    { 'Qt Assistant', 'assistant', '/usr/share/icons/hicolor/128x128/apps/assistant.png' },
    { 'Qt Designer', 'designer', '/usr/share/icons/hicolor/128x128/apps/QtProject-designer.png' },
    { 'Qt Linguist', 'linguist', '/usr/share/icons/hicolor/128x128/apps/linguist.png' },
    { 'Qt QDBusViewer', 'qdbusviewer', '/usr/share/icons/hicolor/128x128/apps/qdbusviewer.png' },
    { 'Rider', '"/home/omegarogue/.local/share/JetBrains/Toolbox/apps/Rider/ch-0/213.6461.51/bin/rider.sh"', '/home/omegarogue/.local/share/JetBrains/Toolbox/apps/Rider/ch-0/.icon.svg' },
    { 'Sysprof', 'sysprof', '/usr/share/icons/hicolor/scalable/apps/org.gnome.Sysprof.svg' },
    { 'Visual Studio Code', '/opt/visual-studio-code/code --no-sandbox --unity-launch' },
    { 'ipython', 'xterm -e ipython' },
}

appmenu.Games = {
    { 'Chess', 'gnome-chess', '/usr/share/icons/hicolor/scalable/apps/org.gnome.Chess.svg' },
    { 'Five or More', 'five-or-more', '/usr/share/icons/hicolor/16x16/apps/org.gnome.five-or-more.png' },
    { 'Four-in-a-row', 'four-in-a-row', '/usr/share/icons/hicolor/16x16/apps/org.gnome.Four-in-a-row.png' },
    { 'Games', 'gnome-games', '/usr/share/icons/hicolor/scalable/apps/org.gnome.Games.svg' },
    { 'Hitori', 'hitori', '/usr/share/icons/hicolor/scalable/apps/org.gnome.Hitori.svg' },
    { 'Klotski', 'gnome-klotski', '/usr/share/icons/hicolor/16x16/apps/org.gnome.Klotski.png' },
    { 'Lights Off', 'lightsoff', '/usr/share/icons/hicolor/scalable/apps/org.gnome.LightsOff.svg' },
    { 'Mahjongg', 'gnome-mahjongg', '/usr/share/icons/hicolor/scalable/apps/org.gnome.Mahjongg.svg' },
    { 'Mines', 'gnome-mines', '/usr/share/icons/hicolor/scalable/apps/org.gnome.Mines.svg' },
    { 'Nibbles', 'gnome-nibbles', '/usr/share/icons/hicolor/scalable/apps/org.gnome.Nibbles.svg' },
    { 'Quadrapassel', 'quadrapassel', '/usr/share/icons/hicolor/scalable/apps/org.gnome.Quadrapassel.svg' },
    { 'Reversi', 'iagno', '/usr/share/icons/hicolor/scalable/apps/org.gnome.Reversi.svg' },
    { 'Robots', 'gnome-robots', '/usr/share/icons/hicolor/scalable/apps/org.gnome.Robots.svg' },
    { 'Sudoku', 'gnome-sudoku', '/usr/share/icons/hicolor/scalable/apps/org.gnome.Sudoku.svg' },
    { 'Swell Foop', 'swell-foop', '/usr/share/icons/hicolor/16x16/apps/org.gnome.SwellFoop.png' },
    { 'Tali', 'tali', '/usr/share/icons/hicolor/scalable/apps/org.gnome.Tali.svg' },
    { 'Taquin', 'gnome-taquin', '/usr/share/icons/hicolor/scalable/apps/org.gnome.Taquin.svg' },
    { 'Tetravex', 'gnome-tetravex', '/usr/share/icons/hicolor/scalable/apps/org.gnome.Tetravex.svg' },
}

appmenu.Graphics = {
    { 'Document Scanner', 'simple-scan', '/usr/share/icons/hicolor/scalable/apps/org.gnome.SimpleScan.svg' },
    { 'Document Viewer', 'evince', '/usr/share/icons/hicolor/scalable/apps/org.gnome.Evince.svg' },
    { 'FontForge', 'fontforge', '/usr/share/icons/hicolor/128x128/apps/org.fontforge.FontForge.png' },
    { 'FreeCAD', 'freecad', '/usr/share/icons/hicolor/16x16/apps/freecad.png' },
    { 'GNU Image Manipulation Program', 'gimp-2.10', '/usr/share/icons/hicolor/16x16/apps/gimp.png' },
    { 'Image Viewer', 'eog', '/usr/share/icons/hicolor/scalable/apps/org.gnome.eog.svg' },
    { 'Inkscape', 'inkscape', '/usr/share/icons/hicolor/16x16/apps/org.inkscape.Inkscape.png' },
    { 'KGraphViewer', 'kgraphviewer -qwindowtitle "KGraphViewer"', '/usr/share/icons/hicolor/16x16/apps/kgraphviewer.png' },
    { 'XDot', 'xdot' },
}

appmenu.Internet = {
    { 'Avahi SSH Server Browser', '/usr/bin/bssh' },
    { 'Avahi VNC Server Browser', '/usr/bin/bvnc' },
    { 'Connections', 'gnome-connections', '/usr/share/icons/hicolor/scalable/apps/org.gnome.Connections.svg' },
    { 'Discord', '/usr/bin/discord' },
    { 'Discord Canary', '/usr/bin/discord-canary' },
    { 'DiscordQt', 'AppRun' },
    { 'Firefox', '/usr/lib/firefox/firefox', '/usr/share/icons/hicolor/128x128/apps/firefox.png' },
    { 'Geary', 'geary', '/usr/share/icons/hicolor/scalable/apps/org.gnome.Geary.svg' },
    { 'Polari', 'gapplication launch org.gnome.Polari', '/usr/share/icons/hicolor/scalable/apps/org.gnome.Polari.svg' },
    { 'Telegram Desktop', 'telegram-desktop -quit', '/usr/share/icons/hicolor/128x128/apps/telegram.png' },
    { 'Web', 'epiphany', '/usr/share/icons/hicolor/scalable/apps/org.gnome.Epiphany.svg' },
}

appmenu.Office = {
    { 'Calendar', 'gnome-calendar', '/usr/share/icons/hicolor/scalable/apps/org.gnome.Calendar.svg' },
    { 'Contacts', 'gnome-contacts', '/usr/share/icons/hicolor/scalable/apps/org.gnome.Contacts.svg' },
    { 'Document Viewer', 'evince', '/usr/share/icons/hicolor/scalable/apps/org.gnome.Evince.svg' },
    { 'Evolution', 'evolution', '/usr/share/icons/hicolor/scalable/apps/evolution.svg' },
}

appmenu.MultiMedia = {
    { 'Cheese', 'cheese', '/usr/share/icons/hicolor/scalable/apps/org.gnome.Cheese.svg' },
    { 'Helvum', 'helvum', '/usr/share/icons/hicolor/scalable/apps/org.freedesktop.ryuukyu.Helvum.svg' },
    { 'Music', 'gnome-music', '/usr/share/icons/hicolor/scalable/apps/org.gnome.Music.svg' },
    { 'NoiseTorch', 'noisetorch', '/usr/share/icons/hicolor/256x256/apps/noisetorch.png' },
    { 'Qt V4L2 test Utility', 'qv4l2', '/usr/share/icons/hicolor/16x16/apps/qv4l2.png' },
    { 'Qt V4L2 video capture utility', 'qvidcap', '/usr/share/icons/hicolor/16x16/apps/qvidcap.png' },
    { 'Sound Recorder', 'gnome-sound-recorder', '/usr/share/icons/hicolor/scalable/apps/org.gnome.SoundRecorder.svg' },
    { 'Videos', 'totem', '/usr/share/icons/hicolor/scalable/apps/org.gnome.Totem.svg' },
}

appmenu.Settings = {
    { 'Advanced Network Configuration', 'nm-connection-editor' },
    { 'Helvum', 'helvum', '/usr/share/icons/hicolor/scalable/apps/org.freedesktop.ryuukyu.Helvum.svg' },
    { 'NVIDIA X Server Settings', '/usr/bin/nvidia-settings', '/usr/share/pixmaps/nvidia-settings.png' },
    { 'Print Settings', 'system-config-printer' },
    { 'Rygel Preferences', 'rygel-preferences', '/usr/share/icons/hicolor/128x128/apps/rygel.png' },
    { 'systemadm', 'systemadm' },
    { 'wdisplays', 'wdisplays', '/usr/share/icons/hicolor/scalable/apps/network.cycles.wdisplays.svg' },
}

appmenu.System = {
    { 'Avahi Zeroconf Browser', '/usr/bin/avahi-discover' },
    { 'Boxes', 'gnome-boxes', '/usr/share/icons/hicolor/scalable/apps/org.gnome.Boxes.svg' },
    { 'Color Profile Viewer', 'gcm-viewer', '/usr/share/icons/hicolor/16x16/apps/gnome-color-manager.png' },
    { 'Disk Usage Analyzer', 'baobab', '/usr/share/icons/hicolor/scalable/apps/org.gnome.baobab.svg' },
    { 'Hardware Locality lstopo', 'lstopo' },
    { 'Logs', 'gnome-logs', '/usr/share/icons/hicolor/scalable/apps/org.gnome.Logs.svg' },
    { 'Manage Printing', '/usr/bin/xdg-open http://localhost:631/', '/usr/share/icons/hicolor/128x128/apps/cups.png' },
    { 'MultiWriter', 'gnome-multi-writer', '/usr/share/icons/hicolor/16x16/apps/org.gnome.MultiWriter.png' },
    { 'Network Tools', 'gnome-nettool', '/usr/share/icons/hicolor/16x16/apps/gnome-nettool.png' },
    { 'Print Settings', 'system-config-printer' },
    { 'Razer Configuration', '/usr/bin/qrazercfg', '/usr/share/icons/hicolor/scalable/apps/razercfg.svg' },
    { 'Software', 'gnome-software', '/usr/share/icons/hicolor/scalable/apps/org.gnome.Software.svg' },
    { 'System Monitor', 'gnome-system-monitor', '/usr/share/icons/hicolor/scalable/apps/org.gnome.SystemMonitor.svg' },
    { 'SystemdGenie', 'systemdgenie' },
    { 'Terminal', 'gnome-terminal', '/usr/share/icons/hicolor/scalable/apps/org.gnome.Terminal.svg' },
    { 'Usage', 'gnome-usage', '/usr/share/icons/hicolor/scalable/apps/org.gnome.Usage.svg' },
    { 'Virtual Machine Manager', 'virt-manager', '/usr/share/icons/hicolor/16x16/apps/virt-manager.png' },
    { 'WezTerm', 'wezterm', '/usr/share/icons/hicolor/128x128/apps/org.wezfurlong.wezterm.png' },
    { 'dconf Editor', 'dconf-editor', '/usr/share/icons/hicolor/16x16/apps/ca.desrt.dconf-editor.png' },
    { 'systemadm', 'systemadm' },
}

appmenu.Miscellaneous = {
    { 'Anbox', 'anbox launch --package=org.anbox.appmgr --component=org.anbox.appmgr.AppViewActivity' },
    { 'Calculator', '/usr/bin/anbox launch --action=android.intent.action.MAIN --package=com.android.calculator2 --component=com.android.calculator2.Calculator', '/home/omegarogue/.local/share/applications/anbox/anbox-com-android-calculator2.png' },
    { 'Calendar', '/usr/bin/anbox launch --action=android.intent.action.MAIN --package=com.android.calendar --component=com.android.calendar.AllInOneActivity', '/home/omegarogue/.local/share/applications/anbox/anbox-com-android-calendar.png' },
    { 'Clock', '/usr/bin/anbox launch --action=android.intent.action.MAIN --package=com.android.deskclock --component=com.android.deskclock.DeskClock', '/home/omegarogue/.local/share/applications/anbox/anbox-com-android-deskclock.png' },
    { 'Contacts', '/usr/bin/anbox launch --action=android.intent.action.MAIN --package=com.android.contacts --component=com.android.contacts.activities.PeopleActivity', '/home/omegarogue/.local/share/applications/anbox/anbox-com-android-contacts.png' },
    { 'Email', '/usr/bin/anbox launch --action=android.intent.action.MAIN --package=com.android.email --component=com.android.email.activity.Welcome', '/home/omegarogue/.local/share/applications/anbox/anbox-com-android-email.png' },
    { 'Files', '/usr/bin/anbox launch --action=android.intent.action.MAIN --package=com.android.documentsui --component=com.android.documentsui.LauncherActivity', '/home/omegarogue/.local/share/applications/anbox/anbox-com-android-documentsui.png' },
    { 'Gallery', '/usr/bin/anbox launch --action=android.intent.action.MAIN --package=com.android.gallery3d --component=com.android.gallery3d.app.GalleryActivity', '/home/omegarogue/.local/share/applications/anbox/anbox-com-android-gallery3d.png' },
    { 'Google Play Store', '/usr/bin/anbox launch --action=android.intent.action.MAIN --package=com.android.vending --component=com.android.vending.AssetBrowserActivity', '/home/omegarogue/.local/share/applications/anbox/anbox-com-android-vending.png' },
    { 'KiCad', 'kicad', '/usr/share/icons/hicolor/128x128/apps/kicad.png' },
    { 'KiCad Gerber Viewer', 'gerbview', '/usr/share/icons/hicolor/128x128/apps/gerbview.png' },
    { 'KiCad Image Converter', 'bitmap2component', '/usr/share/icons/hicolor/128x128/apps/bitmap2component.png' },
    { 'KiCad PCB Calculator', 'pcb_calculator', '/usr/share/icons/hicolor/128x128/apps/pcbcalculator.png' },
    { 'KiCad PCB Editor (Standalone)', 'pcbnew', '/usr/share/icons/hicolor/128x128/apps/pcbnew.png' },
    { 'KiCad Schematic Editor (Standalone)', 'eeschema', '/usr/share/icons/hicolor/128x128/apps/eeschema.png' },
    { 'Music', '/usr/bin/anbox launch --action=android.intent.action.MAIN --package=com.android.music --component=com.android.music.MusicBrowserActivity', '/home/omegarogue/.local/share/applications/anbox/anbox-com-android-music.png' },
    { 'Settings', '/usr/bin/anbox launch --action=android.intent.action.MAIN --package=com.android.settings --component=com.android.settings.Settings', '/home/omegarogue/.local/share/applications/anbox/anbox-com-android-settings.png' },
    { 'SuperSU', '/usr/bin/anbox launch --action=android.intent.action.MAIN --package=eu.chainfire.supersu --component=eu.chainfire.supersu.MainActivity-Material', '/home/omegarogue/.local/share/applications/anbox/anbox-eu-chainfire-supersu.png' },
    { 'WebView Shell', '/usr/bin/anbox launch --action=android.intent.action.MAIN --package=org.chromium.webview_shell --component=org.chromium.webview_shell.WebViewBrowserActivity', '/home/omegarogue/.local/share/applications/anbox/anbox-org-chromium-webview_shell.png' },
}

appmenu.Appmenu = {
    { 'Accessories', appmenu.Accessories },
    { 'Development', appmenu.Development },
    { 'Games', appmenu.Games },
    { 'Graphics', appmenu.Graphics },
    { 'Internet', appmenu.Internet },
    { 'Office', appmenu.Office },
    { 'MultiMedia', appmenu.MultiMedia },
    { 'Settings', appmenu.Settings },
    { 'System', appmenu.System },
    { 'Miscellaneous', appmenu.Miscellaneous },
}

return appmenu