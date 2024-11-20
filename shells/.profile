# $HOME/.profile

# If a distro has a default .profile with actual important commands in
# it rename it to this:
if [ -f $HOME/.distro_profile ]; then
    source $HOME/.distro_profile
fi

PATH="$PATH:$HOME/.local/bin"
PATH="$PATH:$HOME/.cargo/bin"
PATH="$PATH:/usr/local/go/bin"
PATH="$PATH:$HOME/.luarocks/bin"
export PATH

export PAGER=/usr/bin/less
export LESS=-R

if [ $(command -v nvim) ]; then
    export VISUAL=/usr/bin/nvim
    export EDITOR=/usr/bin/nvim
elif [ $(command -v vim) ]; then
    export VISUAL=/usr/bin/vim
    export EDITOR=/usr/bin/vim
else
    export VISUAL=/usr/bin/vi
    export EDITOR=/usr/bin/vi
fi

if [ $(command -v ssh-agent) ]; then
    eval $(ssh-agent -t 15m)
fi

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
