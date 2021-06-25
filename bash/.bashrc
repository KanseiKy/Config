#!/usr/bin/env bash

USER="Kansei"
HOSTNAME="Ky"

RESET="\[\033[0m\]"
RED="\[\033[0;31m\]"
GREEN="\[\033[01;32m\]"
BLUE="\[\033[01;34m\]"
YELLOW="\[\033[0;33m\]"

function parse_git_branch()
{
    PS_BRANCH=''

    if [ -d .svn ] ; then
        PS_BRANCH="(svn r$(svn info | awk '/Revision/{print $2}'))"
        return

    elif [ -f _FOSSIL_ -o -f .fslckout ] ; then
        PS_BRANCH="(fossil $(fossil status | awk '/tags/{print $2}')) "
        return

    elif [ -d .hg ] ; then
        PS_BRANCH="(hg $(hg branch))"
        return
    
    fi

    ref=$(git symbolic-ref HEAD 2> /dev/null) || return
    PS_BRANCH="(git ${ref#refs/heads/}) "
}

PROMPT_COMMAND=parse_git_branch

PS_INFO="$GREEN${USER}$RESET@$GREEN${HOSTNAME}$RESET:$BLUE\w"
PS_VCS="$YELLOW\$PS_BRANCH"
PS_TIME="$RED[\t]"

export PS1="${PS_INFO} ${PS_VCS}${PS_TIME}\n${RESET}> "
