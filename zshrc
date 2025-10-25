setopt incappendhistory
autoload -Uz compinit promptinit
compinit
promptinit

# completion.... stuff
setopt menu_complete
zstyle ':completion:*' menu select
__comp_options+=(globdots)

__menu_accept_line(){
	zle .menu-complete
	zle accept-line
}
zle -N __menu_accept_line

zmodload -i zsh/complist
bindkey -M menuselect '^M' __menu_accept_line

#zstyle ':completion:*' file-sort modification

#source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh

#ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=gray'
#ZSH_AUTOSUGGEST_STRATEGY=(history)

# FreeBSD's sh-like history bindings 
autoload -Uz history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^[[A" history-beginning-search-backward-end
bindkey "^[[B" history-beginning-search-forward-end

# edit in EDITOR
autoload edit-command-line; zle -N edit-command-line
bindkey "^[e" edit-command-line

# prompt settings and functions
autoload -Uz vcs_info
precmd() {vcs_info}
zstyle ':vcs_info:git:*' formats ' (%b)'
setopt PROMPT_SUBST
git_branch_prompt=

#PS1='%n@%m %~%(?.. %F{red}[%?]%f)${vcs_info_msg_0_} %# '
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

#precmd_functions=( shrinkpath )
#PS1='%1v%# '


#PS1='%n@%m %2~${vcs_info_msg_0_} %# '
PS1='%n@%m %40<'...'<%~%<<${vcs_info_msg_0_} %# '

# vi mode
#KEYTIMEOUT=1
#
#toggle_vi_mode(){
#if [[ $KEYMAP == vicmd || $KEYMAP == viins ]]; then
	#bindkey -e
    #else
        #bindkey -v 
#fi
#}
#
#zle -N toggle_vi_mode
#bindkey "^E" toggle_vi_mode
#bindkey -M viins '^[ ' vi-cmd-mode
#bindkey -M viins

# cd magic 
setopt AUTO_PUSHD                  # pushes the old directory onto the stack
setopt PUSHD_MINUS                 # exchange the meanings of '+' and '-'
unsetopt CDABLE_VARS                 # expand the expression (allows 'cd -2/tmp')
zstyle ':completion:*:directory-stack' list-colors '=(#b) #([0-9]#)*( *)==95=38;5;12' 
