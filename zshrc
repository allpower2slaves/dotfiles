setopt incappendhistory
autoload -Uz compinit promptinit
compinit
promptinit

# completion.... stuff
setopt menu_complete
zstyle ':completion:*' menu select
__comp_options+=(globdots)
zmodload -i zsh/complist

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
bindkey -M vicmd "k" history-beginning-search-backward-end
bindkey -M vicmd "j" history-beginning-search-forward-end

# edit in EDITOR
autoload edit-command-line; zle -N edit-command-line
bindkey "^E" edit-command-line
bindkey -M vicmd '^E' edit-command-line

# other niceties
bindkey -M vicmd 'v' visual-mode
bindkey -M visual 'v' visual-mode # Pressing v again exits/toggles

# prompt settings and functions
autoload -Uz vcs_info
precmd() {vcs_info}
zstyle ':vcs_info:git:*' formats ' (%b)'
setopt PROMPT_SUBST
git_branch_prompt=

PROMPT_DIRTRIM=3

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

# --- SSH RANDOM COLOR LOGIC ---
# Only runs once when the shell starts
if [ -n "$SSH_CONNECTION" ]; then
  __remote_colors=(18 55 105 161 112 208)
  __active_ssh_color="%F{${__remote_colors[$(( RANDOM % ${#__remote_colors[@]} + 1 ))]}}"
  __active_ssh_reset="%f"
else
  # No color for local sessions
  __active_ssh_color=""
  __active_ssh_reset=""
fi

# --- THE LOGIC (Cursor & Symbol) ---
function update_vi_prompt() {
  if [[ $KEYMAP == "vicmd" ]]; then
    PS1_SYMBOL="%#"
    echo -ne '\e[2 q' 
  else
    PS1_SYMBOL="%#"
    echo -ne '\e[2 q' # lol
  fi
  zle reset-prompt
}

zle -N zle-keymap-select update_vi_prompt
zle -N zle-line-init update_vi_prompt

# --- YOUR PS1 ---
# Color is surgically applied only to the user@host part, and only if SSH_CONNECTION exists.
PS1='${__active_ssh_color}%n@%m${__active_ssh_reset} %40<…<%~%<<${vcs_info_msg_0_} ${PS1_SYMBOL} '
# PS1 setting END

# PS1 setting END

# cd magic 
setopt AUTO_PUSHD                  # pushes the old directory onto the stack
setopt PUSHD_MINUS                 # exchange the meanings of '+' and '-'
unsetopt CDABLE_VARS                 # expand the expression (allows 'cd -2/tmp')
zstyle ':completion:*:directory-stack' list-colors '=(#b) #([0-9]#)*( *)==95=38;5;12' 

# doas alias
# command -pv doas 1>/dev/null || alias doas="sudo"
