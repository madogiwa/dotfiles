
## ============================================================================
## zinit
## ============================================================================

### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing DHARMA Initiative Plugin Manager (zdharma/zinit)…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zinit-zsh/z-a-rust \
    zinit-zsh/z-a-as-monitor \
    zinit-zsh/z-a-patch-dl \
    zinit-zsh/z-a-bin-gem-node

### End of Zinit's installer chunk


export ZSH_CACHE_DIR="${ZSH_CACHE_DIR:-$HOME/.zsh/cache}"

## ----------------------------------------------------------------------------
## enhancd
## ----------------------------------------------------------------------------

## don't use interactive filter when specifing a double dot (..)
ENHANCD_DISABLE_DOT=1

## change command name of enhancd from default
ENHANCD_COMMAND=j


## ----------------------------------------------------------------------------
## load plugins
## ----------------------------------------------------------------------------

zinit ice wait'!0'; zinit light zdharma/fast-syntax-highlighting

zinit ice wait'!0'; zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-history-substring-search

## pure theme
zinit ice pick"async.zsh" src"pure.zsh"; zinit light sindresorhus/pure

## completions
zinit ice wait'!0'; zinit light zsh-users/zsh-completions

zinit ice as"completion" wait'!0'; zinit snippet https://github.com/docker/cli/blob/master/contrib/completion/zsh/_docker
zinit ice as"completion" wait'!0'; zinit snippet https://github.com/docker/compose/blob/master/contrib/completion/zsh/_docker-compose

zinit ice wait'!0'; zinit snippet OMZ::plugins/kubectl/kubectl.plugin.zsh

zinit ice wait'!0'; zinit snippet https://github.com/gangleri/pipenv/blob/master/pipenv.plugin.zsh

zinit snippet OMZP::gcloud

## fuzzy matcher
zinit ice wait'!0'; zinit ice from"gh-r" as"program"; zinit light junegunn/fzf-bin

## enhanced cd command 
#zinit ice wait'!0'; zinit light b4b4r07/enhancd

## peco/percol/fzf wrapper
zinit ice wait'!0'; zinit light mollifier/anyframe

## ssh-gent
#zinit ice wait'!0'; zinit snippet OMZ::plugins/ssh-agent/ssh-agent.plugin.zsh
zinit snippet OMZ::plugins/ssh-agent/ssh-agent.plugin.zsh

## kubectl-prompt
zinit light superbrothers/zsh-kubectl-prompt

## direnv
zplugin ice from"gh-r" as"program" mv"direnv* -> direnv" './direnv hook zsh > zhook.zsh' atpull'%atclone' pick"direnv"
zinit light direnv/direnv

## asdf
zinit ice lucid as'program' src'asdf.sh'
zinit light asdf-vm/asdf

zpcompinit


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
# disable due to compatibility with zinit
#setopt print_exit_value

## passthrough 8bit
setopt print_eight_bit

## enable function into $PROMPT
setopt prompt_subst

## hide rprompt after command execution
setopt transient_rprompt

## ignore Ctrl+d
setopt ignoreeof

export IGNOREEOF=3

## enable completion after '='
setopt magic_equal_subst

setopt always_last_prompt

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

## enable colors
autoload -Uz colors && colors


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

## ディレクトリを先に表示する
zstyle ':completion:*' list-dirs-first true

## enable sudo completion
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin \
    /usr/local/bin /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin

### 詳細出力を有効にする
zstyle ':completion:*' verbose yes
zstyle ':completion:*' format '%f[%F{yellow}%B%d%b%k]'

### メッセージフォーマット
zstyle ':completion:*:messages' format '%F{YELLOW}%d'$DEFAULT
zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:corrections' format '%U%F{green}%d (errors: %e)%f%u'
zstyle ':completion:*:warnings' format '%F{202}%BNo matches for: %F{214}%d%b'

# Prettier completion for processes
zstyle ':completion:*:*:*:*:processes' force-list always
zstyle ':completion:*:*:*:*:processes' menu yes select
zstyle ':completion:*:*:*:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,args -w -w"

# Show message while waiting for completion
zstyle ':completion:*' show-completer true

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

## history size on memory (500,000)
HISTSIZE=500000

## history size on disk (100,000,000)
SAVEHIST=100000000

## command execution time is greater than this value have timing statistics printed for them
REPORTTIME=3

## ignore repeated command
setopt hist_ignore_dups

## delete duplicate command from history file
setopt hist_ignore_all_dups

## do not save duplicate command
setopt hist_save_no_dups

## share history list
#setopt share_history

## do not overwrite history file
setopt append_history

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

## expire duplicate command first when triming history
setopt hist_expire_dups_first

## don't show duplicate command
setopt hist_find_no_dups

## customize history-substring-search
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND="bg=green,fg=white,bold"
bindkey '^P' history-substring-search-up
bindkey '^N' history-substring-search-down

# インクリメンタル検索でglobを利用可能にする
bindkey '^R' history-incremental-pattern-search-backward
bindkey '^S' history-incremental-pattern-search-forward


## ============================================================================
## prompt 
## ============================================================================

update_window_title() {
    if [ -n "$TMUX" ]; then
        `tmux set-window-option allow-rename on`
        echo -n "\ek${1}\e\\"
        `tmux set-window-option allow-rename off`
    elif [ ! -n "$TERMINAL_EMULATOR" ]; then
        echo -n "\ek${1}\e\\"
    else
        # do not output for termianl in JetBrains IDE
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
        unset ROLE_SESSION_START

        echo "AWS session cleared."
    else
        echo "nothing cleared."
    fi
}

function assume-role-clear-role() {
    if [ "${ROLE_SESSION_START}" ]; then
        unset AWS_ACCESS_KEY_ID
        unset AWS_SECRET_ACCESS_KEY
        unset AWS_SESSION_TOKEN
        unset AWS_SECURITY_TOKEN
        unset AWS_ACCOUNT_ID
        unset AWS_ACCOUNT_NAME
        unset AWS_ACCOUNT_ROLE
        unset ROLE_SESSION_START
        unset GEO_ENV

        echo "AWS role session cleared."
    fi
}

## check session timeout
function precmd_aws_session_expire_check() {
    if [ "${ROLE_SESSION_START}" ] && [ "$ROLE_SESSION_TIMEOUT" ]; then
        diff=$((`date +%s` - ${ROLE_SESSION_START}))
        [ $diff -ge $ROLE_SESSION_TIMEOUT ] && assume-role-clear-role
    fi
}
add-zsh-hook precmd precmd_aws_session_expire_check

function aws_account_info {
    if [ "$AWS_ACCOUNT_NAME" ] && [ "$AWS_ACCOUNT_ROLE" ]; then
        if [ "$ROLE_SESSION_START" ] && [ "$ROLE_SESSION_TIMEOUT" ]; then
            least=$(($ROLE_SESSION_START + $ROLE_SESSION_TIMEOUT - `date +%s`))
            [ $least -ge 600 ] && least="" || least=" $least"
        fi

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
## ghq + fzf
## https://qiita.com/tomoyamachi/items/e51d2906a5bb24cf1684
## ============================================================================

function ghq-fzf() {
  local src=$(ghq list | fzf --preview "ls -laTp $(ghq root)/{} | tail -n+4 | awk '{print \$9\"/\"\$6\"/\"\$7 \" \" \$10}'")
  if [ -n "$src" ]; then
    BUFFER="cd $(ghq root)/$src"
    zle accept-line
  fi
  zle -R -c
}
zle -N ghq-fzf
bindkey '^]' ghq-fzf


## ============================================================================
## serverless framework
## ============================================================================

NODEJS_HOME=$(asdf where nodejs)

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[[ -f $NODEJS_HOME/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh ]] && . $NODEJS_HOME/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[[ -f $NODEJS_HOME/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh ]] && . $NODEJS_HOME/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh
# tabtab source for slss package
# uninstall by removing these lines or running `tabtab uninstall slss`
[[ -f $NODEJS_HOME/lib/node_modules/serverless/node_modules/tabtab/.completions/slss.zsh ]] && . $NODEJS_HOME/lib/node_modules/serverless/node_modules/tabtab/.completions/slss.zsh


## ============================================================================
## include local zshrc
## ============================================================================

[ -f ~/.zshrc.local ] && source ~/.zshrc.local

