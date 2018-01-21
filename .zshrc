
## ============================================================================
## zplug
## ============================================================================
if [ ! -e ~/.zplug/ ]; then
    curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
fi

if [ -d ~/.zplug/ ]; then
    source ~/.zplug/init.zsh

    zplug "zsh-users/zsh-syntax-highlighting", defer:2

    zplug "zsh-users/zsh-history-substring-search", lazy:true

    ## Additional completion definitions for Zsh
    zplug "zsh-users/zsh-completions", lazy:true

    zplug "docker/compose", use:contrib/completion/zsh

    ## fuzzy matcher
    zplug "junegunn/fzf-bin", as:command, from:gh-r, rename-to:fzf, lazy:true

    ## enhanced cd command 
    zplug "b4b4r07/enhancd", use:init.sh, on:"junegunn/fzf-bin"

    ## theme
    #zplug "caiogondim/bullet-train.zsh", use:bullet-train.zsh-theme, defer:3
    #BULLETTRAIN_PROMPT_ORDER=(
    #  time status custom context dir screen aws git hg cmd_exec_time
    #)

    zplug "bhilburn/powerlevel9k", use:powerlevel9k.zsh-theme

    POWERLEVEL9K_PROMPT_ADD_NEWLINE=true  # Promptの前に1行空ける
    POWERLEVEL9K_PROMPT_ON_NEWLINE=true   # Promptを2行にする
    POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=""    # 1行目の先頭
    POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="$ "   # 2行目の先頭
    POWERLEVEL9K_DIR_SHOW_WRITABLE=true   # 書き込み不可のディレクトリの場合にマーカーを表示

    POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir rbenv vcs)
    POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status root_indicator background_jobs history time)
    POWERLEVEL9K_CONTEXT_DEFAULT_FOREGROUND='black'
    POWERLEVEL9K_CONTEXT_DEFAULT_BACKGROUND='green'

    ## Install plugins if there are plugins that have not been installed
    if ! zplug check --verbose; then
        printf "Install? [y/N]: "
        if read -q; then
            echo; zplug install
        fi
    fi

    ## Then, source plugins and add commands to $PATH
    zplug load --verbose
fi


## ----------------------------------------------------------------------------
## enhancd
## ----------------------------------------------------------------------------

## don't use interactive filter when specifing a double dot (..)
ENHANCD_DISABLE_DOT=1


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


## ============================================================================
## prompt 
## ============================================================================

update_window_title() {
    if [ -n "$TMUX" ]; then
        `tmux set-window-option allow-rename on`
        echo -n "\ek${1} #[fg=colour39,bold]\e\\"
        `tmux set-window-option allow-rename off`
    else
        echo -n "\ek${1}\e\\"
    fi
}

## set screen window title to last command
preexec() {
    title="${1%% *}*"
    update_window_title "$title"
}

## set screen window title to currenty directory
precmd_title() {
    dir="${PWD/#$HOME/~}"
    if [ ! "~" = "$dir" ]; then
        dir=`basename "${dir}"`
    fi 
    title="${dir}"
    update_window_title "$title"
}
add-zsh-hook preexec precmd_title


## ============================================================================
## anyenv
## ============================================================================

## zshenvの読み込みが遅くならないようにzshrcでinitを実施
if [ -d "${ANYENV_ROOT}" ]; then
    eval "$(anyenv init - --no-rehash)"
fi


## ============================================================================
## tmux
## ============================================================================

if [ ! -e ~/.tmux/plugins/tpm ]; then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

