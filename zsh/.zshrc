setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_BEEP
setopt AUTO_PUSHD # cd -1,-2 etc..
setopt appendhistory
setopt auto_cd
unsetopt MULTIOS
autoload bashcompinit && bashcompinit
autoload -Uz compinit && compinit
autoload -U edit-command-line
zle -N edit-command-line

bindkey -M vicmd v edit-command-line
bindkey '^ ' autosuggest-accept
#
# complete -C '/usr/local/bin/aws_completer' aws
# bindkey -v

HISTSIZE=10000
SAVEHIST=10000

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

. $HOME/.asdf/asdf.sh
#. ~/.asdf/plugins/java/set-java-home.zsh
export HISTFILE=$HOME/.zsh_history
export DOTFILES=$HOME/.dotfiles
export MANPAGER="sh -c 'col -bx | bat -l man -p --theme zenburn'"
export EDITOR="nvim"
export TERM=xterm-256color
# export TERM=screen-256color
export GREP_OPTIONS='--color=auto'
export BROWSER='/usr/bin/firefox'
export PATH=$PATH:/bin:/usr/bin$HOME/.rbenv/bin:/usr/local/var/rbenv/shims/pod:$HOME/bin:$HOME/chtsh/:$HOME/.local/bin/
export ANDROID_HOME=$HOME/Library/Android/sdk
export ANDROID_SDK_ROOT=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH=$PATH:$HOME/.pub-cache/bin
export PATH=$PATH:$HOME/fvm/default/bin
export PATH=$PATH:$HOME/.cargo/bin
export PATH=$PATH:$HOME/neovim/bin
export PATH=$PATH:$HOME/.asdf/shims
export FVM_HOME=$HOME/fvm
export GEM_HOME=$HOME/.gem
export GOROOT=/usr/local/go
export GOPATH=$HOME/go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
# export PATH=$PATH:$GOBIN
# export PATH=$PATH:$GOPATH 
# export PATH=$PATH:$GOROOT/bin 
# export JAVA_HOME=$(/usr/libexec/java_home -v11)

# export JAVA_HOME=$(/usr/libexec/java_home -v 1.8.0)
# export JAVA_HOME=/usr/lib/java
export MANPAGER='nvim +Man!'
export MANWIDTH=999

export HOMEBREW_NO_AUTO_UPDATE=1
export MAGICK_HOME="$HOME/ImageMagick-7.0.8"
export PATH="$MAGICK_HOME/bin:$PATH"
export DYLD_LIBRARY_PATH="$MAGICK_HOME/lib/"  
export GIT_EDITOR=vim
export GIT_SEQUENCE_EDITOR="vim"
export RBENV_ROOT=/usr/local/var/rbenv
export PROJECTS=$HOME/Documents/Projects
export FREETYPE_PROPERTIES="truetype:interpreter-version=35"
export FD_OPTIONS="--follow --exclude .git --exclude node_modules"
export FASTLANE_HIDE_CHANGELOG=1
export FASTLANE_SKIP_UPDATE_CHECK=1 

export FZF_DEFAULT_OPTS="--height 50% --layout=reverse --border --multi --no-mouse 
--bind 'f1:execute(less -f {}),ctrl-y:execute-silent(echo {} | pbcopy)+abort'"

export FZF_CTRL_T_COMMAND="fd $FD_OPTIONS"
export FZF_CTRL_R_OPTS='--no-sort'
export FZF_ALT_C_COMMAND="fd -t d . $HOME/code"
export GLFW_IM_MODULE=ibus
export SSH_KEY_PATH="~/.ssh/rsa_id"

source ~/.aliases

source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[[ -f ~/functions.sh ]] && source ~/functions.sh

# fpath+=("$(brew --prefix)/share/zsh/site-functions")
fpath+=($HOME/.zsh/pure)

autoload -U promptinit; promptinit
prompt pure

## [Completion] 
## Completion scripts setup. Remove the following line to uninstall
[[ -f /Users/rodrigo.m.de.campos/.dart-cli-completion/zsh-config.zsh ]] && . /Users/rodrigo.m.de.campos/.dart-cli-completion/zsh-config.zsh || true
## [/Completion]

