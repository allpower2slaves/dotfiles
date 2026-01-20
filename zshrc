zmodload zsh/zprof

bindkey -v

#REPORTTIME=10
#TIMEFMT='%J spent %Uu %Ss (%P CPU) with a max RSS of %MKB'

setopt EXTENDED_HISTORY
setopt INC_APPEND_HISTORY_TIME
setopt HIST_IGNORE_DUPS
setopt HIST_REDUCE_BLANKS

unsetopt AUTO_CD
hash -r

#autoload -U select-word-style
#select-word-style shell

# completion.... stuff
setopt menu_complete
zstyle ':completion:*' menu select
__comp_options+=(globdots)
zmodload -i zsh/complist
zstyle ':completion:*' tag-order 'commands' 'builtins' 'functions' 'aliases'

bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect '^[' send-break 
# Allow Tab to cycle forward even in the menu
bindkey -M menuselect '^i' menu-complete
bindkey -M vicmd '^i' expand-or-complete

# Invert colors for the currently selected item in the menu
zstyle ':completion:*' list-colors ''
zstyle ':completion:*:*:*:*:at-rules' list-colors 'ma=7' # ma=7 is 'standout'

#zle_highlight=(region:bg=#444444)
if [[ "$TERM" == "linux" ]]; then # whats up with freebsd tho
    # TTY Mode: Use standard ANSI colors (0-7)
    # 'standout' is the TTY's best effort, or use 'bg=8' if supported
    zle_highlight=(region:standout)
else
    # Foot/Graphical Mode: Use the beautiful neutral gray
    zle_highlight=(region:bg=#444444)
fi

zstyle ':completion:*' file-sort modification

#source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh

#ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=gray'
#ZSH_AUTOSUGGEST_STRATEGY=(history)

# FreeBSD's sh-like history bindings 
autoload -Uz history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^[[A" history-beginning-search-backward-end
bindkey "^[[B" history-beginning-search-forward-end
bindkey -M viins "^[[A" history-beginning-search-backward-end
bindkey -M viins "^[[B" history-beginning-search-forward-end
#bindkey -M vicmd "k" history-beginning-search-backward-end
#bindkey -M vicmd "j" history-beginning-search-forward-end
bindkey -M vicmd 'j' down-line
bindkey -M vicmd 'k' up-line
bindkey -M vicmd 'J' history-beginning-search-forward
bindkey -M vicmd 'K' history-beginning-search-backward

# edit in EDITOR
autoload edit-command-line; zle -N edit-command-line
bindkey "^E" edit-command-line
bindkey "^F" edit-command-line
bindkey -M vicmd '^E' edit-command-line

# other niceties
bindkey -M vicmd 'v' visual-mode
bindkey -M visual 'v' visual-mode # Pressing v again exits/toggles
bindkey -v '^?' backward-delete-char   # Modern Backspace
bindkey -M vicmd 'u' undo
bindkey -M vicmd '^r' redo
# This ensures ; and , work to repeat f/t/F/T movements
bindkey -M vicmd ';' vi-find-next-char
bindkey -M vicmd ',' vi-find-prev-char
bindkey -M vicmd '%' vi-match-bracket
bindkey -M vicmd 'x' vi-delete-char
bindkey -M vicmd 'D' vi-kill-eol
bindkey -M vicmd 'C' vi-change-eol
bindkey -M vicmd 'W' vi-forward-blank-word
bindkey -M vicmd 'B' vi-backward-blank-word
#bindkey -M vicmd 'E' vi-end-of-blank-word # doesnt work

autoload -Uz select-quoted select-bracketed
zle -N select-quoted
zle -N select-bracketed

for km in viopp vicmd visual; do
  # Quotes
  foreach q ( '"' "'" '`' )
    bindkey -M $km "i$q" select-quoted
    bindkey -M $km "a$q" select-quoted
  end
  # Brackets
  foreach opener closure ( '[' ']' '(' ')' '{' '}' '<' '>' )
    bindkey -M $km "i$opener" select-bracketed
    bindkey -M $km "a$opener" select-bracketed
    bindkey -M $km "i$closure" select-bracketed
    bindkey -M $km "a$closure" select-bracketed
  end
done

function vi-select-inner-word() {
  read -k 1 # Consume the 'i' or 'a' from the sequence
  zle select-in-shell-word
}
zle -N vi-select-inner-word

# Function to select "around word" (aw)
function vi-select-around-word() {
  read -k 1
  zle select-around-shell-word
}
zle -N vi-select-around-word

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' formats ' (%b)'
autoload -Uz vcs_info
autoload -Uz add-zsh-hook

# git prompt end

shrinkpath () { # currently unused
  local split dir=${PWD/#~\//\~/}
  case $dir in
    ~) dir='~' ;;
    *) split=( "${(@s:/:)dir}" )
       dir=${(j:/:M)split#?}${split[-1]:1} ;;
  esac
  psvar[1]=$dir
}

# PS1 setting BEGIN

export KEYTIMEOUT=1
setopt PROMPT_SUBST
bindkey -v

_CURSOR_BLOCK=$'%{\e[2 q%}'

_update_git_status() {
    local git_info
    git_info=$(command git --no-optional-locks rev-parse --abbrev-ref HEAD 2>/dev/null)
    
    if [[ -n "$git_info" ]]; then
        # If 'HEAD' is returned, we are in a detached state. Get the hash.
        [[ "$git_info" == "HEAD" ]] && git_info=$(command git rev-parse --short HEAD 2>/dev/null)
        GIT_STATUS="%F{242} ($git_info)%f"
    else
        GIT_STATUS=""
    fi
}

autoload -Uz add-zsh-hook
add-zsh-hook precmd _update_git_status

_initialize_completions() {
    local zcdump="${ZDOTDIR:-$HOME}/.zcompdump"
    autoload -Uz compinit
    if [[ -f "$zcdump" && -n "$zcdump"(#qN.m-1) ]]; then
        compinit -C -i -d "$zcdump"
    else
        compinit -i -d "$zcdump"
        zcompile "$zcdump"
    fi
}
_initialize_completions

PS1="${_CURSOR_BLOCK}%n@%m %40<…<%~%<<\${GIT_STATUS} %# "
# PS1 setting END

# PS1 setting END

# cd magic 
setopt AUTO_PUSHD                  # pushes the old directory onto the stack
setopt PUSHD_MINUS                 # exchange the meanings of '+' and '-'
unsetopt CDABLE_VARS                 # expand the expression (allows 'cd -2/tmp')
zstyle ':completion:*:directory-stack' list-colors '=(#b) #([0-9]#)*( *)==95=38;5;12' 

# ssh background magic
ssh () {
	local ssh_bg_colors=("#002b36" "#053d48") # honorable mentions: #3d1e2e
	local ssh_bg=$ssh_bg_colors[$(( RANDOM % ${#ssh_bg_colors[@]} + 1 ))]
	printf "\e]11;%s\a" "$ssh_bg"
    { command ssh "$@" } always {printf "\e]111\a"}
}
