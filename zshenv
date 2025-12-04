HISTFILE=~/.histfile
HISTSIZE=30000
SAVEHIST="$HISTSIZE"

NEXINIT=":set cedit='^F'" # nvi : esc fix

PATH="\
/sbin:\
/bin:\
/usr/sbin:\
/usr/bin:\
/usr/local/sbin:\
/usr/local/bin:\
$HOME/.local/bin:\
$HOME/bin:\
"

export EDITOR="$(
  command -v /usr/bin/nvim ||
  command -v /usr/local/bin/nvim ||
  command -pv nvim ||
  command -pv vi
  )"

export VISUAL="$EDITOR"

export SYSTEMD_LESS=iRXMK
