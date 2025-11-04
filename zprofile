if [! -S "$SSH_AUTH_SOCK" ]; then
    eval "$(ssh-agent -s)" >/dev/null
fi

if ! gpgconf --list-dirs agent-socket >/dev/null 2>&1; then
    gpgconf --launch gpg-agent
fi

export GPG_TTY=$(tty)
