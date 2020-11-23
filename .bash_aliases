source ~/.bash_other

set -o vi

alias tunnel='sshuttle --pidfile=/tmp/sshuttle.pid -r nduma7100548@c02sr0uvh03m.local --dns  10.0.0.0/8 -D'
alias tunnelx='[[ -f /tmp/sshuttle.pid ]] && kill $(cat /tmp/sshuttle.pid) && echo "Disconnected."'

# Disable software flow conntrol (XON/XOFF), it's annoying in vim
stty -ixon

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias ide='vim --servername IDE'

SVN_EDITOR=vim
export SVN_EDITOR
export EDITOR=vim
export CSCOPE_EDITOR=/usr/bin/vim

# Perform arithmetic easily in bash
=() {
    answer="$(($@))"
    printf '%s' "$answer"
    bc -l <<< "obase=16;ans=$answer;print \" (0x\",ans,\")\\n\""
}

# Build aliases
alias build="build.sh"
alias setup_environment="source ./setup_environment.sh"
alias setup="source ./setup.sh"

# Aliases for git
alias gs='git status'
alias gd='git diff'
alias gdm='git diff master'
alias gsdm='git svn-diff master'
alias gca='git commit -am '
alias gp='git push'
alias gpg='git push gitlab'
alias gpb='git push bitbucket'
alias gss='git svn-update-all svn'

alias gitVimDiff='vim -p $(git diff --name-only) -c "tabdo :Gvdiff"'
alias gitVimPreviousDiff='vim -p $(git diff --name-only HEAD~1 HEAD) -c "tabdo :Gvdiff HEAD~1"'
alias gitGVimDiff='gvim -p $(git diff --name-only) -c "tabdo :Gvdiff"'
alias gitGVimPreviousDiff='gvim -p $(git diff --name-only HEAD~1 HEAD) -c "tabdo :Gvdiff HEAD~1"'

gitVimDiffBranch() {
    vim -p $(git diff --name-only $1 HEAD) -c "tabdo :Gvdiff $1"
}
gitGVimDiffBranch() {
    gvim -p $(git diff --name-only $1 HEAD) -c "tabdo :Gvdiff $1"
}
alias gitVimDiffBranch=gitVimDiffBranch
alias gitGVimDiffBranch=gitGVimDiffBranch

# better search and replace
sr() {
    ag -l $1 | xargs sed -i -e "s|$1|$2|g"
}

# terminal prompt git statuses
COLOR_RED="\033[01;31m"
COLOR_YELLOW="\033[01;33m"
COLOR_GREEN="\033[01;32m"
COLOR_OCHRE="\033[38;5;95m"
COLOR_BLUE="\033[01;34m"
COLOR_WHITE="\033[01;37m"
COLOR_PURPLE="\033[01;35m"
COLOR_RESET="\033[0m"

function git_color {
  local git_status="$(git status 2> /dev/null)"

  if [[ $git_status =~ "diverged" ]]; then
    echo -e $COLOR_RED
  elif [[ $git_status =~ "Your branch is ahead of" ]]; then
    echo -e $COLOR_YELLOW
  elif [[ $git_status =~ "Your branch is behind" ]]; then
    echo -e $COLOR_BLUE
  elif [[ $git_status =~ "Your branch is up-to-date" ]]; then
    echo -e $COLOR_PURPLE
  elif [[ $git_status =~ "On branch" ]]; then
    echo -e $COLOR_PURPLE   # This is probably a git-svn clone, it tracks branches differently
  else
    echo -e $COLOR_OCHRE
  fi
}

function git_branch {
  local git_status="$(git status 2> /dev/null)"
  local on_branch="On branch ([^${IFS}]*)"
  local operating_branch="currently ([^${IFS}]*) branch '([^${IFS}]*)' on"
  local on_commit="HEAD detached at ([^${IFS}]*)"

  if [[ $git_status =~ $on_branch ]]; then
    local branch=${BASH_REMATCH[1]}
    echo "($branch)"
  elif [[ $git_status =~ $on_commit ]]; then
    local commit=${BASH_REMATCH[1]}
    echo "($commit)"
  elif [[ $git_status =~ $operating_branch ]]; then
    local branch=${BASH_REMATCH[2]}
    local operation=${BASH_REMATCH[1]}
    echo "($branch | $operation)"
  fi
}

function git_changes {
  local git_status="$(git status 2> /dev/null)"

  local git_added="$(git diff --cached --numstat 2> /dev/null | wc -l)"
  local git_dirty="$(git diff-files --diff-filter=M 2> /dev/null | wc -l)"
  local git_untracked="$(git ls-files --exclude-standard --others 2> /dev/null | wc -l)"

  status=""
  if [[ $git_added > 0 ]]; then
      status+=" $git_added staged"
  fi
  if [[ $git_dirty > 0 ]]; then
      status+=" $git_dirty dirty"
  fi
  if [[ $git_untracked > 0 ]]; then
      status+=" $git_untracked untracked"
  fi

  echo "$status"
}

PS1='$\[\033[01;32m\]\u@\w\[\033[00m\]: \[\033[01;35m\]'
PS1+="\[\$(git_color)\]"
PS1+="\$(git_branch)"
PS1+="\$(git_changes)"
PS1+='\[\033[00m\]\n\$ '
export PS1
