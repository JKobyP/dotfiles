#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Source alias file
[[ -f ~/.bash_aliases ]] && . ~/.bash_aliases

# *** ENVIRONMENT VARIABLES ***
#             *** ***
# set default editor to vim
export EDITOR=vim
export VISUAL=vim

# add my scripts directory to the path
export PATH=$PATH:~/scripts
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
export PATH=$PATH:/home/koby/.gem/ruby/2.4.0/bin # Add ruby gem executables
export PATH=$PATH:~/.local/bin
export GOROOT=$HOME/go
export GOPATH=$HOME/dev/work
export PATH=$PATH:$GOPATH/bin:$GOROOT/bin

# *** BASH PROMPT ***
#      *** ***
# get current branch in git repo
function parse_git_branch() {
    BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
    if [ ! "${BRANCH}" == "" ]
    then
        STAT=`parse_git_dirty`
        echo "[${BRANCH}${STAT}]"
    else
        echo ""
    fi
}

# get current status of git repo
function parse_git_dirty {
    status=`git status 2>&1 | tee`
    dirty=`echo -n "${status}" 2> /dev/null | grep "modified:" &> /dev/null; echo "$?"`
    untracked=`echo -n "${status}" 2> /dev/null | grep "Untracked files" &> /dev/null; echo "$?"`
    ahead=`echo -n "${status}" 2> /dev/null | grep "Your branch is ahead of" &> /dev/null; echo "$?"`
    newfile=`echo -n "${status}" 2> /dev/null | grep "new file:" &> /dev/null; echo "$?"`
    renamed=`echo -n "${status}" 2> /dev/null | grep "renamed:" &> /dev/null; echo "$?"`
    deleted=`echo -n "${status}" 2> /dev/null | grep "deleted:" &> /dev/null; echo "$?"`
    bits=''
    if [ "${renamed}" == "0" ]; then
        bits=">${bits}"
    fi
    if [ "${ahead}" == "0" ]; then
        bits="*${bits}"
    fi
    if [ "${newfile}" == "0" ]; then
        bits="+${bits}"
    fi
    if [ "${untracked}" == "0" ]; then
        bits="?${bits}"
    fi
    if [ "${deleted}" == "0" ]; then
        bits="x${bits}"
    fi
    if [ "${dirty}" == "0" ]; then
        bits="!${bits}"
    fi
    if [ ! "${bits}" == "" ]; then
        echo " ${bits}"
    else
        echo ""
    fi
}

export PS1="\u \[\e[35m\]\w\[\e[m\] \[\e[32m\]\`parse_git_branch\`\[\e[m\] \n\$ "
# *** End custom prompt section

eval $(ssh-agent)
source ~/.git-completion.bash

# source untested stuff
[[ -f ~/.bash_experimental ]] && . ~/.bash_experimental
