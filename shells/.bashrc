# ~/.bashrc

# Enable vi mode.
set -o vi
# Update the values of LINES and COLUMNS each time a command is
# executed.
shopt -s checkwinsize
# "If you use bash, you may want to ensure that the huponexit option
# is set to make sure that child processes exit when you leave a
# shell. Without this setting, background processes you have spawned
# over the course of your shell session will stick around in the
# shpool daemon's process tree and eat up memory."
shopt -s huponexit

# https://wiki.archlinux.org/index.php/Bash/Prompt_customization
FRED="\[$(tput setaf 1)\]"
FGREEN="\[$(tput setaf 2)\]"
FYELLOW="\[$(tput setaf 3)\]"
FBLUE="\[$(tput setaf 4)\]"
FMAGENTA="\[$(tput setaf 5)\]"
FCYAN="\[$(tput setaf 6)\]"
FWHITE="\[$(tput setaf 7)\]"
BRED="\[$(tput setab 1)\]"
BGREEN="\[$(tput setab 2)\]"
BYELLOW="\[$(tput setab 3)\]"
BBLUE="\[$(tput setab 4)\]"
BMAGENTA="\[$(tput setab 5)\]"
BCYAN="\[$(tput setab 6)\]"
BWHITE="\[$(tput setab 7)\]"
BGFLIP="\[$(tput rev)\]"
UNDERLINE="\[$(tput smul)\]"
BOLD="\[$(tput bold)\]"
RESET="\[$(tput sgr0)\]"

# Truncates long paths.
export PROMPT_DIRTRIM=3
export PS1="${BGFLIP}\u@\H \w \$${RESET} "

unset FRED FGREEN FYELLOW FBLUE FMAGENTA FCYAN FWHITE BRED BGREEN BYELLOW \
    BBLUE BCYAN BWHITE BGFLIP UNDERLINE BOLD RESET

if [ -f "${HOME}/.shared.sh" ]; then
    . "${HOME}/.shared.sh"
fi

if [ $(command -v fzf) ]; then
    # Set up fzf key bindings and fuzzy completion
    eval "$(fzf --bash)"
fi

if [ $(command -v zoxide) ]; then
    eval "$(zoxide init bash)"
fi
