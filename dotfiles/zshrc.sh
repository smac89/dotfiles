################################################################################
################################### ZGEN #######################################
source "$HOME/.zgen/zgen.zsh"

DEV_DIR="${HOME}/Development"
USER_LIB="${HOME}/lib"

zgen load zsh-users/zsh-completions

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

{%@@ if profile == 'home' @@%}
# golang
zgen oh-my-zsh plugins/golang
{%@@ endif @@%}

# virtualenvwrapper config
export WORKON_HOME="$DEV_DIR/virtualenvs"
zgen oh-my-zsh plugins/virtualenvwrapper
export PYENV_VIRTUALENVWRAPPER_PREFER_PYVENV="true"
zgen oh-my-zsh plugins/git

# Load the theme.
zgen load denysdovhan/spaceship-prompt spaceship

##################################################################

# Theme options
SPACESHIP_TIME_SHOW=true
{%@@ if profile == 'home' @@%}
SPACESHIP_PROMPT_ORDER=(
    time dir host git package node ruby swift golang rust haskell
    aws venv exec_time line_sep battery vi_mode jobs exit_code char
)
{%@@ elif profile == 'skip' @@%}
SPACESHIP_PROMPT_ORDER=(
    time dir host git package node ruby
    aws venv exec_time line_sep battery jobs exit_code char
)
{%@@ endif @@%}

local function add_to_path() {
    for p in ${(s.:.)2}; do
        if [[ ! "${(P)1}" =~ "${p%/}" ]]; then
            new_path="$p:${(P)1#:}"
            export "$1"="${new_path%:}"
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
export GOOGLE_APP_ENGINE_DIR="${HOME}/lib/google_appengine"

add_to_path 'PYTHONPATH' "${GOOGLE_APP_ENGINE_DIR}"
{%@@ endif @@%}

################################################################################
###################################### BEGIN ###################################
#################################### MY CONFIG #################################

[ -f ~/.base_profile ] && source ~/.base_profile

# pip-completions
eval "$(pip completion --zsh)"

# pyenv
zgen oh-my-zsh plugins/pyenv

# rbenv
zgen oh-my-zsh plugins/rbenv

# OPAM configuration
[ -f "$HOME/.opam/opam-init/init.zsh" ] && source "$HOME/.opam/opam-init/init.zsh" > /dev/null 2> /dev/null || true

# aliases
source ~/.aliases

##########################################################
####################### DO LAST ##########################
unset -f add_to_path
# cleanup
unset DEV_DIR
unset USER_LIB
unset HOMEBREW_BIN
##########################################################
