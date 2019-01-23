
## automate fisher install
if not functions -q fisher
    set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
    curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
    fish -c fisher
end

## aliases
alias cp 'cp -i'
alias rm 'rm -i'
alias mv 'mv -i'

## setup anyenv
set -x PATH $HOME/.anyenv/bin $PATH
anyenv init - --no-rehash fish | source

## customize pure theme
set pure_separate_prompt_on_error true

## customize fzf plugin
## enable new keybindings
set -U FZF_LEGACY_KEYBINDINGS 0

