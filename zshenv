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

export EDITOR="$(command -pv nvim || command -pv vi)"
export VISUAL="$EDITOR"

export SYSTEMD_LESS=iRXMK

# set EDITOR (deprecated)
#printf "nvim vi" | tr ' ' '\n' | while read __editor; do
    #if command -v "$__editor" >/dev/null 2>&1; then
        #EDITOR="$__editor"
        #VISUAL="$__editor"
        #break
    #fi
#done
