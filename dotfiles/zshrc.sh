################################################################################
################################### ZGEN #######################################
source "$HOME/.zgen/zgen.zsh"

if ! zgen saved; then
    zgen load zsh-users/zsh-completions

    # brew
    export HOMEBREW_BUILD_FROM_SOURCE=1
    zgen load smac89/linuxbrew

    zgen load zdharma/fast-syntax-highlighting
    zgen load zsh-users/zsh-autosuggestions

    # nvm
    export NVM_DIR="$HOME/.nvm"
    export NVM_LAZY_LOAD=true
    export NVM_AUTO_USE=true
    zgen load lukechilds/zsh-nvm

    # npm
    zgen load lukechilds/zsh-better-npm-completion

    # oh-my-zsh
    zgen oh-my-zsh

    # rbenv
    eval "$(rbenv init -)"
    zgen oh-my-zsh plugins/rbenv

    {%@@ if profile == 'home' @@%}
    # golang
    zgen oh-my-zsh plugins/golang
    {%@@ endif @@%}

    zgen oh-my-zsh plugins/virtualenvwrapper
    zgen oh-my-zsh plugins/git

    # Load the theme.
    zgen load denysdovhan/spaceship-prompt spaceship
    SPACESHIP_TIME_SHOW=true
    {%@@ if profile == 'home' @@%}
    SPACESHIP_PROMPT_ORDER=(
        time dir host git package node ruby swift golang rust haskell
        aws exec_time line_sep battery vi_mode jobs exit_code char
    )
    {%@@ elif profile == 'skip' @@%}
    SPACESHIP_PROMPT_ORDER=(
        time dir host git package node ruby
        aws exec_time line_sep battery jobs exit_code char
    )
    {%@@ endif @@%}

    # Save the configurations
    zgen save
fi

local function add_to_path() {
  for p in ${(s.:.)2}; do
    if [[ ! "${(P)1}" =~ "$p" ]]; then
      export "$1"="$p:${(P)1}"
    fi
  done
}

{%@@ if profile == 'skip' @@%}
################################################################################
########################### SKIP VARIABLES #####################################
export JSHINT="${NVM_BIN}/jshint"
export JASMINE="${NVM_BIN}/jasmine"
export PHANTOMJS="${NVM_BIN}/phantomjs"
export LESS_COMPILER="${NVM_BIN}/lessc"
export UGLIFYJS_COMPILER="${NVM_BIN}/uglifyjs"
export SCSS_LINT="${RBENV_ROOT}/shims/scss-lint"
export SASS_COMPILER="${RBENV_ROOT}/shims/sass"
export COMPASS_COMPILER="${RBENV_ROOT}/shims/compass"
export GOOGLE_APP_ENGINE_DIR="${USER_LIB}/google_appengine"

add_to_path 'PYTHONPATH' "${GOOGLE_APP_ENGINE_DIR}"
{%@@ endif @@%}

################################################################################
###################################### BEGIN ###################################
#################################### MY CONFIG #################################

DEV_DIR="${HOME}/Development"
USER_LIB="${HOME}/lib"
BREW_HOME="${HOME}/.linuxbrew"
HOMEBREW_BIN="${BREW_HOME}/bin"

export VISUAL='subl -w'
export EDITOR="$VISUAL"

add_to_path 'PKG_CONFIG_PATH' '/usr/lib/x86_64-linux-gnu/pkgconfig'
add_to_path 'PKG_CONFIG_PATH' '/usr/share/pkgconfig'
add_to_path 'PKG_CONFIG_PATH' '/usr/lib/pkgconfig'
add_to_path 'PKG_CONFIG_PATH' '/usr/local/lib/pkgconfig'

# virtualenvwrapper config
export WORKON_HOME="${DEV_DIR}/virtualenvs"

# pip-completions
eval "$(pip completion --zsh)"

# aliases
source ~/.aliases

{%@@ if profile == 'home' @@%}
# Android sdk and ndk
export ANDROID_SDK="${USER_LIB}/android/sdk"
export ANDROID_HOME="${ANDROID_SDK}"
export ANDROID_NDK_HOME="${ANDROID_SDK}/ndk-bundle"

add_to_path 'PATH' "$(printf %s: ${ANDROID_SDK}/{tools,platform-tools})"
add_to_path 'PATH' "${ANDROID_NDK_HOME}"

# Swift
add_to_path 'PATH' "${USER_LIB}/swift/usr/bin"

add_to_path 'PATH' "${USER_LIB}/jython/bin"

add_to_path 'PATH' "$HOME/.local/bin"

# openFrameworks project generator
export PG_OF_PATH="${USER_LIB}/openFrameworks/of_v0.9.8"
export GROOVY_HOME="$BREW_HOME/opt/groovy/libexec/"

# Activator for Scala
if [ -d "${USER_LIB}/scala-activator/bin" ]; then
    add_to_path 'PATH' "${USER_LIB}/scala-activator/bin"
fi

# Flutter and Dart
if [ -d "${USER_LIB}/flutter/bin" ]; then
    add_to_path 'PATH' "${USER_LIB}/flutter/bin"
    add_to_path 'PATH' "${USER_LIB}/flutter/bin/cache/dart-sdk/bin"
fi

# Nativescript
if [ -f "$HOME/.tnsrc" ]; then
    source $HOME/.tnsrc
fi
{%@@ endif @@%}

##########################################################
####################### DO LAST ##########################
unset -f add_to_path
##########################################################
