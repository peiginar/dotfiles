[ -z "$PS1" ] && return
PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\W\[\033[00m\]($SHLVL)\$ '
_findpath() {
  python -c 'import sys; a, b = sys.argv[1:3]
sys.exit(b not in a.split(":") and 1 or 0)' ${1:?} ${2:?}
}
addpath() {
  local key=${1:?}; shift;
  local val=$(eval echo "$"${key}) path= opath=
  for opath in $@; do
    path="$(echo ${opath//:/}| sed 's!/*!/!; s!/*$!!;')"
    test -z "$path" && continue
    _findpath $val $path && continue
    if echo $opath| grep -q ":$" ; then
      val="$path${val:+:}$val"
    else
      val="$val${val:+:}$path"
    fi
  done
  eval export $key="$val"
}
appendpath() { addpath PATH $@; }
javacpls() {
  local d=${1:?}
  d="$(cd $d && pwd)"
  echo $(find $d -type f -name "*.jar") | sed 's/  */:/g'
}
HOME_APPS="${HOME}/Applications"
appendpath "/usr/local/bin:" "/usr/local/sbin:"

alias ll='ls -l'
export LESS='-x4 -r'
export PAGER=less
export EDITOR=vim
export PYTHONSTARTUP=${HOME}/.python_startup.py

ECLIPSE_HOME=$HOME_APPS/eclipse
ANT_HOME=${ECLIPSE_HOME}/plugins/org.apache.ant_1.8.4.v201303080030/bin
appendpath $ANT_HOME
export JAVA_HOME=$(/usr/libexec/java_home)
M2_HOME="$HOME_APPS/maven"
appendpath $M2_HOME/bin
GLASSFISH_HOME=$HOME_APPS/glassfish4/glassfish
appendpath $GLASSFISH_HOME/bin
#export DERBY_HOME=$JAVA_HOME/db
DERBY_HOME=$HOME_APPS/glassfish4/javadb
appendpath $DERBY_HOME/bin
POI_HOME="$HOME_APPS/poi-3.10.1"
appendpath $HOME_APPS/jython2.7b3/bin
GRADLE_HOME="$HOME_APPS/gradle-2.9"
appendpath $GRADLE_HOME/bin

export RBENV_ROOT="/usr/local/var/rbenv"
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# The next line updates PATH for the Google Cloud SDK.
source $HOME_APPS/google-cloud-sdk/path.bash.inc

# The next line enables shell command completion for gcloud.
source $HOME_APPS/google-cloud-sdk/completion.bash.inc

# vim: set ts=2 sw=2 et:
