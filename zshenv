
## override system defaults
export LANG=en_US.UTF-8
export LC_ALL=$LANG

## /etc/profileの読み込みを無効化
setopt no_global_rcs

## path_helperがある場合(Macの場合)PATHを初期化
if [ -x /usr/libexec/path_helper ]; then
    PATH=""
    eval `/usr/libexec/path_helper -s`
fi

## append $HOME/bin path if not exist
[[ ":$PATH:" != *":${HOME}/bin:"* ]] && PATH="${HOME}/bin:${PATH}"

## append sbin path if not exist
[[ ":$PATH:" != *":/usr/local/sbin:"* ]] && PATH="/usr/local/sbin:${PATH}"
[[ ":$PATH:" != *":/usr/sbin:"* ]] && PATH="/usr/sbin:${PATH}"
[[ ":$PATH:" != *":/sbin:"* ]] && PATH="/sbin:${PATH}"

## append asdf path if not exist
[[ ":$PATH:" != *":${HOME}/.asdf/shims:"* ]] && PATH="${HOME}/.asdf/shims:${PATH}"


## ============================================================================
## exports
## ============================================================================
[[ -f "${HOME}/.asdf/plugins/java/set-java-home.zsh" ]] && source "${HOME}/.asdf/plugins/java/set-java-home.zsh"
export JAVA_OPTS="-Dfile.encoding=UTF-8"

## enable Docker BuildKit
export DOCKER_BUILDKIT=1

## append cargo envs
[[ -f "${HOME}/.cargo/env" ]] && source "${HOME}/.cargo/env"

## ============================================================================
## Android SDK
## ============================================================================
ANDROID_ROOT="${HOME}/Library/Android"

if [ -d "${ANDROID_ROOT}" ]; then
    export ANDROID_SDK="${ANDROID_ROOT}/sdk"
    export PATH=${ANDROID_SDK}/platform-tools:$PATH
fi

