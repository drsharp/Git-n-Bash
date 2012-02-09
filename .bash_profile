# Source some extra definitions
if [ -f ~/.bash_colors ]; then . ~/.bash_colors; fi
if [ -f ~/.bash_functions ]; then . ~/.bash_functions; fi
if [ -f ~/.bash_aliases ]; then . ~/.bash_aliases; fi
# NOTE: include functions before aliases, as some aliases refer to functions


export PATH="~/bin:/opt/local/bin:/opt/local/sbin:/usr/local/bin:/usr/local/sbin:/usr/local/mysql/bin:/usr/local/git/bin:/Library/PostgreSQL8/bin:$PATH"
export COPY_EXTENDED_ATTRIBUTES_DISABLE=true # prevents the ._file problem (Tiger)
export COPYFILE_DISABLE=true # prevents the ._file problem (Leopard)

# Some unused prompt versions
# PS1="\h:\W \u\[\033[0;32m\]\$(parse_git_branch_and_add_brackets) \[\033[0m\]\$ "
# PS1="\w \[\033[0;32m\]\$(parse_git_branch_and_add_brackets) \[\033[0m\]\$ "
# PS1="[\w\[\033[0;32m\]\$(parse_git_branch_and_add_brackets)\[\033[0m\]]\$ "
# PS1="\[$Red\]foo\[$Blue\] bar\[$BCyan\] baz : "

PS1="[\w\[\033[$Green\]\$(parse_git_branch_and_add_brackets)\[\033[$None\]]\$ "

# This is for git tab-complete
if [ -f /opt/local/etc/bash_completion ]; then
  . /opt/local/etc/bash_completion
fi

##
export EDITOR="$HOME/bin/mate2 -w" # yes, TextMate 2 is my default editor!
export MANPATH=/opt/local/share/man:$MANPATH

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# This PROMPT command makes sure that when I SSH the terminal title is set, and when I return from SSH, it's reset.
PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/~}"; echo -ne "\007"'
