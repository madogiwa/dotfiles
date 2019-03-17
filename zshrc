
## ============================================================================
## zplug
## ============================================================================

## ----------------------------------------------------------------------------
## enhancd
## ----------------------------------------------------------------------------

## don't use interactive filter when specifing a double dot (..)
ENHANCD_DISABLE_DOT=1

## change command name of enhancd from default
ENHANCD_COMMAND=j


## ----------------------------------------------------------------------------
## zplug load
## ----------------------------------------------------------------------------

if [ -d ~/.zplug/ ]; then
    source ~/.zplug/init.zsh

    zplug "zsh-users/zsh-syntax-highlighting", defer:2

    zplug "zsh-users/zsh-autosuggestions", defer:2

    zplug "zsh-users/zsh-history-substring-search", defer:3

    ## Additional completion definitions for Zsh
    zplug "zsh-users/zsh-completions"

    zplug "docker/cli", use:contrib/completion/zsh
    zplug "docker/compose", use:contrib/completion/zsh

    ## fuzzy matcher
    zplug "junegunn/fzf-bin", as:command, from:gh-r, rename-to:fzf

    ## enhanced cd command 
    zplug "b4b4r07/enhancd", use:init.sh, on:"junegunn/fzf-bin"

    ## peco/percol/fzf wrapper
    zplug "mollifier/anyframe"

    ## ssh-gent
    zplug "plugins/ssh-agent", from:oh-my-zsh, ignore:oh-my-zsh.sh

    ## pure theme
    zplug mafredri/zsh-async, from:github
    zplug sindresorhus/pure, use:pure.zsh, from:github, as:theme

    ## kubectl-prompt
    zplug "superbrothers/zsh-kubectl-prompt"

    ## kubectl-completion
    zplug "nnao45/zsh-kubectl-completion"

    ## Install plugins if there are plugins that have not been installed
    if ! zplug check --verbose; then
        printf "Install? [y/N]: "
        if read -q; then
            echo; zplug install
        fi
    fi

    ## Then, source plugins and add commands to $PATH
    zplug load
fi


## ============================================================================
## general
## ============================================================================

## emacs keybind
bindkey -e

## append cd command if pathname only
setopt auto_cd

## execute pushd every cd command
setopt auto_pushd

## output return code if error occured
setopt print_exit_value

## passthrough 8bit
setopt print_eight_bit

## enable function into $PROMPT
setopt prompt_subst

## hide rprompt after command execution
setopt transient_rprompt

## ignore Ctrl+d
setopt ignoreeof

export IGNOREEOF=3

# https://superuser.com/questions/1243138/why-does-ignoreeof-not-work-in-zsh
# Emulate Bash $IGNOREEOF behavior
bash-ctrl-d() {
    if [[ $CURSOR == 0 && -z $BUFFER ]]
    then
        [[ -z $IGNOREEOF || $IGNOREEOF == 0 ]] && exit
        if [[ $LASTWIDGET == bash-ctrl-d ]]
        then
            (( --__BASH_IGNORE_EOF <= 0 )) && exit
        else
            (( __BASH_IGNORE_EOF = IGNOREEOF-1 ))
        fi
        echo -n Use \"exit\" to leave the shell.
        zle send-break
    else
        zle delete-char-or-list
    fi
}

zle -N bash-ctrl-d
bindkey '^D' bash-ctrl-d


## ============================================================================
## alias
## ============================================================================

## for Mac
case $OSTYPE in
darwin*)
    ## enable colors, append / for directory
    alias ls='ls -GwF'

    # do not include resource fork in tarball
    export COPYFILE_DISABLE=true
    ;;
esac

## detail print
alias ll='ls -la'

## prompt before file destroy operation
alias rm='rm -i'
alias cp='cp -ip'
alias mv='mv -i'

## as Linux @@
if [ ! -x /usr/bin/tac ]; then
    alias tac='tail -r'
fi


## ============================================================================
## completion
## ============================================================================

export ZLS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'

## disable beep sound if completion failed
#setopt nolistbeep

## display mark of file type
setopt list_types

## disable select next item by tabkey
unsetopt auto_menu

## enable completion cache
if [ ! -f ~/.zsh/cache ]; then
    mkdir -p ~/.zsh/cache
fi
zstyle ':completion:*' use-cache yes
zstyle ':completion:*' cache-path ~/.zsh/cache

## ignore capital
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

## select from completion list
## 候補が2つ以上の場合は一覧を表示
zstyle ':completion:*:default' menu select=2

## colored completion list
zstyle ':completion:*:default' list-colors ${(s.:.)ZLS_COLORS} 

## enable sudo completion
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin \
    /usr/local/bin /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin

### 詳細出力を有効にする
zstyle ':completion:*' verbose yes
zstyle ':completion:*' format '%B%d%b'

### 補完候補がない場合にエラーを表示する
zstyle ':completion:*:warnings' format 'No matches for: %d'

### 補完候補をマッチ種別ごとに表示する
zstyle ':completion:*' group-name ''

setopt complete_in_word

## ============================================================================
## application
## ============================================================================

## default editor is vim
export EDITOR=vim

## default pager is less
export PAGER=less

## set tabstop=4, print percentage, don't erase screen on exit, ANSI color
export LESS='--tabs=4 --LONG-PROMPT -X -R'

## enable colors
export GREP_OPTIONS='--color=auto'


## ============================================================================
## history
## ============================================================================

## history file
HISTFILE=${HOME}/.zsh_history

## history size on memory (100,000)
HISTSIZE=100000

## history size on disk (100,000,000)
SAVEHIST=100000000

## command execution time is greater than this value have timing statistics printed for them
REPORTTIME=3

## ignore repeated command
setopt hist_ignore_dups

## don't save duplicate command into history file
setopt hist_save_no_dups

## share history list
#setopt share_history

## save history file at every command execution
setopt inc_append_history

## save history with timestamp
setopt extended_history

## don't save history command self
setopt hist_no_store

## don't save command if command line begin with white space
setopt hist_ignore_space

## recude blanks
setopt hist_reduce_blanks

## customize history-substring-search
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND="bg=green,fg=white,bold"
bindkey '^P' history-substring-search-up
bindkey '^N' history-substring-search-down


## ============================================================================
## prompt 
## ============================================================================

update_window_title() {
    if [ -n "$TMUX" ]; then
        `tmux set-window-option allow-rename on`
        echo -n "\ek${1}\e\\"
        `tmux set-window-option allow-rename off`
    else
        echo -n "\ek${1}\e\\"
    fi
}

## set screen window title to last command
preexec_title() {
    title="${1%% *}*"
    update_window_title "$title"
}
add-zsh-hook preexec preexec_title

## set screen window title to currenty directory
precmd_title() {
    dir="${PWD/#$HOME/~}"
    if [ ! "~" = "$dir" ]; then
        dir=`basename "${dir}"`
    fi 
    title="${dir}"
    update_window_title "$title"
}
add-zsh-hook precmd precmd_title

## show AWS_PROFILE in prompt
function aws_prof {
  local profile="${AWS_PROFILE:=default}"
  if [ "${profile}" != "default" ]; then
    echo "%{$fg_bold[blue]%}awsp:(%{$fg[yellow]%}${profile}%{$fg_bold[blue]%})%{$reset_color%} "
  fi
}
PROMPT='$(aws_prof)'$PROMPT

## awsp (AWS Profile Switcher)
function awsp() {
  if [ $# -ge 1 ]; then
    if [ "$1" != "clear" ]; then
      export AWS_PROFILE="$1"
      echo "export AWS_PROFILE=$AWS_PROFILE"
    else
      unset AWS_PROFILE
      echo "unset AWS_PROFILE"
    fi
  else
    source _awsp
  fi
}

## kubectl-prompt
RPROMPT='%{$fg[yellow]%}($ZSH_KUBECTL_PROMPT)%{$reset_color%}'$RPROMPT


## ============================================================================
## assume-role
## ============================================================================

source $(which assume-role)
export AWS_ROLE_SESSION_TIMEOUT=3600

function assume-role-clear() {
    if [ "$AWS_ACCOUNT_NAME" ] && [ "$AWS_ACCOUNT_ROLE" ]; then
        unset AWS_REGION
        unset AWS_DEFAULT_REGION
        unset AWS_ACCESS_KEY_ID
        unset AWS_SECRET_ACCESS_KEY
        unset AWS_SESSION_TOKEN
        unset AWS_ACCOUNT_ID
        unset AWS_ACCOUNT_NAME
        unset AWS_ACCOUNT_ROLE
        unset AWS_SESSION_ACCESS_KEY_ID
        unset AWS_SESSION_SECRET_ACCESS_KEY
        unset AWS_SESSION_SESSION_TOKEN
        unset AWS_SESSION_SECURITY_TOKEN
        unset AWS_SESSION_START
        unset GEO_ENV
        unset AWS_SECURITY_TOKEN

        echo "AWS session cleared."
    else
        echo "nothing cleared."
    fi
}

## check session timeout
function precmd_aws_session_expire_check() {
    if [ "${ROLE_SESSION_START}" ]; then
        diff=$((`date +%s` - ${ROLE_SESSION_START}))
        [ $diff -ge $AWS_ROLE_SESSION_TIMEOUT ] && assume-role-clear
    fi
}
add-zsh-hook precmd precmd_aws_session_expire_check

function aws_account_info {
    if [ "$AWS_ACCOUNT_NAME" ] && [ "$AWS_ACCOUNT_ROLE" ]; then
        least=$(($ROLE_SESSION_START + $AWS_ROLE_SESSION_TIMEOUT - `date +%s`))
        [ $least -ge 600 ] && least="" || least=" $least"

        echo "%{$fg_bold[blue]%}aws:(%{$fg[yellow]%}${AWS_ACCOUNT_NAME}:${AWS_ACCOUNT_ROLE}%{$fg[red]%}${least}%{$fg_bold[blue]%})%{$reset_color%} "
    fi
}
PROMPT='$(aws_account_info)'$PROMPT


## ============================================================================
## gcloud
## ============================================================================

function gcp_info() {
    if [ -f "$HOME/.config/gcloud/active_config" ]; then
        profile=$(cat $HOME/.config/gcloud/active_config)
        project=$(awk '/project/{print $3}' $HOME/.config/gcloud/configurations/config_$profile)
        account=$(awk '/account/{print $3}' $HOME/.config/gcloud/configurations/config_$profile)
        if [ ! -z ${project} ] && [ ! -z ${account} ]; then
            echo "%{$fg_bold[blue]%}gcp:(%{$fg[yellow]%}${account}:${project}%{$fg[red]%}${least}%{$fg_bold[blue]%})%{$reset_color%} "
        fi
    fi
}
PROMPT='$(gcp_info)'$PROMPT


function gcredential_info() {
    if [ "$GOOGLE_APPLICATION_CREDENTIALS" ] && [ -f "$GOOGLE_APPLICATION_CREDENTIALS" ]; then
        project=$(jq -r .project_id $GOOGLE_APPLICATION_CREDENTIALS)
        account=$(jq -r .client_email $GOOGLE_APPLICATION_CREDENTIALS | cut -d'@' -f1)
        if [ ! -z ${project} ] && [ ! -z ${account} ]; then
            echo "%{$fg_bold[blue]%}gcpc:(%{$fg[yellow]%}${account}:${project}%{$fg[red]%}${least}%{$fg_bold[blue]%})%{$reset_color%} "
        fi
    fi
}
PROMPT='$(gcredential_info)'$PROMPT


## ============================================================================
## anyenv
## ============================================================================

## zshenvの読み込みが遅くならないようにzshrcでinitを実施
if [ -d "${ANYENV_ROOT}" ]; then
    #eval "$(anyenv init - --no-rehash)"
    eval "$(anyenv lazyload)"
fi

## goenvを利用する場合にIDE等にGOROOTを認識させるためのアドホックな対応
if [ -n "`go env GOROOT 2>/dev/null`" ]; then
    export GOROOT=`go env GOROOT`
fi


## ============================================================================
## pipenv
## ============================================================================

if [ -f `which pipenv` ]; then
    PIPENV_COMPLETION_CACHE="$HOME/.zsh/cache/pipenv-completion"
    if [ ! -f "${PIPENV_COMPLETION_CACHE}" ]; then
        pipenv --completion > "${PIPENV_COMPLETION_CACHE}"
    fi
    eval "$(cat ${PIPENV_COMPLETION_CACHE})"
    #eval "$(pipenv --completion)"
fi


## ============================================================================
## anyframe
## ============================================================================

function anyframe-widget-docker-container-id() {
    docker container list | tail -n +2 \
        | anyframe-selector-auto \
        | cut -d ' ' -f 1
}

function anyframe-widget-docker-image-id() {
    docker image list | tail -n +2 \
        | anyframe-selector-auto \
        | awk '{ print $3 }'
}

function anyframe-widget-docker-image-name() {
    docker image list | tail -n +2 \
        | anyframe-selector-auto \
        | awk '{ printf "%s:%s", $1, $2 }'
}

function anyframe-widget-docker-shell() {
    docker exec -it `anyframe-widget-docker-container-id` sh
}


## ============================================================================
## include local zshrc
## ============================================================================

[ -f ~/.zshrc.local ] && source ~/.zshrc.local


# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[[ -f ~/.config/yarn/global/node_modules/tabtab/.completions/serverless.zsh ]] && . ~/.config/yarn/global/node_modules/tabtab/.completions/serverless.zsh

# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[[ -f ~/.config/yarn/global/node_modules/tabtab/.completions/sls.zsh ]] && . ~/.config/yarn/global/node_modules/tabtab/.completions/sls.zsh

# tabtab source for slss package
# uninstall by removing these lines or running `tabtab uninstall slss`
[[ -f /Users/mdgw/.anyenv/envs/nodenv/versions/10.15.1/lib/node_modules/serverless/node_modules/tabtab/.completions/slss.zsh ]] && . /Users/mdgw/.anyenv/envs/nodenv/versions/10.15.1/lib/node_modules/serverless/node_modules/tabtab/.completions/slss.zsh
