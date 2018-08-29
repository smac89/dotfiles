# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

DEV_DIR="${HOME}/Development"
USER_LIB="${HOME}/lib"
BREW_HOME="${HOME}/.linuxbrew"
HOMEBREW_BIN="${BREW_HOME}/bin"

export VISUAL='subl -w'
export EDITOR="$VISUAL"

# Fix path
_temp_path="$PATH"
PATH='/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/usr/lib/jvm/java-8-oracle/bin:/usr/lib/jvm/java-8-oracle/db/bin:/usr/lib/jvm/java-8-oracle/jre/bin'
add_to_path 'PATH' "$_temp_path"
unset _temp_path


add_to_path 'PKG_CONFIG_PATH' '/usr/lib/x86_64-linux-gnu/pkgconfig'
add_to_path 'PKG_CONFIG_PATH' '/usr/share/pkgconfig'
add_to_path 'PKG_CONFIG_PATH' '/usr/lib/pkgconfig'
add_to_path 'PKG_CONFIG_PATH' '/usr/local/lib/pkgconfig'

# Android sdk and ndk
export ANDROID_SDK="${USER_LIB}/android/sdk"
export ANDROID_HOME="${ANDROID_SDK}"
export ANDROID_NDK_HOME="${ANDROID_SDK}/ndk-bundle"

add_to_path 'PATH' "$(printf %s: ${ANDROID_SDK}/{tools,platform-tools})"
add_to_path 'PATH' "${ANDROID_NDK_HOME}"

# Groovy
export GROOVY_HOME="$BREW_HOME/opt/groovy/libexec/"

# Swift
add_to_path 'PATH' "${USER_LIB}/swift/usr/bin"

# Linux brew stuff
add_to_path 'PATH' "$(printf %s: ${BREW_HOME}/{bin,sbin})"
add_to_path 'MANPATH' "${BREW_HOME}/share/man" # hack to make manpath work
add_to_path 'INFOPATH' "${BREW_HOME}/share/info"
add_to_path 'XDG_DATA_DIRS' "${BREW_HOME}/share"

# Jython
add_to_path 'PATH' "${USER_LIB}/jython/bin"

# openFrameworks project generator
export PG_OF_PATH="${USER_LIB}/openFrameworks/of_v0.9.8"

# git stuff
export GIT_PS1_SHOWDIRTYSTATE="1"
export GIT_PS1_SHOWSTASHSTATE="1"
export GIT_PS1_SHOWUNTRACKEDFILES="1"
export GIT_PS1_SHOWUPSTREAM="verbose name git svn"

# Flutter and Dart
if [ -d "${USER_LIB}/flutter/bin" ]; then
    add_to_path 'PATH' "${USER_LIB}/flutter/bin"
    add_to_path 'PATH' "${USER_LIB}/flutter/bin/cache/dart-sdk/bin"
fi

# Includes user's private bin if it exists
[ -d "${HOME}/bin" ] && add_to_path 'PATH' "${HOME}/bin"
[ -d "${HOME}/.local/bin" ] && add_to_path 'PATH' "${HOME}/.local/bin"

# Ruby Stuffs
# https://gorails.com/setup/ubuntu/16.04
export RBENV_ROOT="${HOME}/.rbenv"
add_to_path 'PATH' "${RBENV_ROOT}/bin"
add_to_path 'PATH' "${RBENV_ROOT}/shims"
add_to_path 'PATH' "${RBENV_ROOT}/plugins/ruby-build/bin"

# virtualenvwrapper config
export WORKON_HOME="${DEV_DIR}/virtualenvs"

# Golang
add_to_path 'PATH' "${BREW_HOME}/opt/go/libexec/bin"

# tns-completion
[ -f "$HOME/.tnsrc" ] && source "$HOME/.tnsrc"
