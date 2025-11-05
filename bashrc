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

PS1="[\u@\h \W]\$ "

bind 'set show-all-if-ambiguous on'
bind 'set menu-complete-display-prefix on'
bind 'TAB:menu-complete'
bind '"\e[Z":menu-complete-backward'

bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

# https://superuser.com/a/1841931
_edit_wo_executing() {
    local editor="${EDITOR:-nvim}"
	tmpf="$(mktemp bashXXXXXX --suffix=.bash)" # wont work on FreeBSD btw
    printf '%s\n' "$READLINE_LINE" > "$tmpf"
    "$editor" "$tmpf"
    READLINE_LINE="$(cat "$tmpf")"
    READLINE_POINT="${#READLINE_LINE}"
    \rm -f "$tmpf"  # -f for those who have alias rm='rm -i'
}

bind -x '"\ee":_edit_wo_executing'
