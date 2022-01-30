setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_BEEP
setopt auto_cd
unsetopt MULTIOS
autoload -U edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line
bindkey -v

. $HOME/.asdf/asdf.sh
# . /opt/asdf-vm/asdf.sh
#. ~/.asdf/plugins/java/set-java-home.zsh

export DOTFILES=$HOME/.dotfiles
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export EDITOR="nvim"
export TERM=xterm-256color
export GREP_OPTIONS='--color=auto'
export BROWSER='/usr/bin/firefox'
export PATH=$PATH:/bin:/usr/bin$HOME/.rbenv/bin:/usr/local/var/rbenv/shims/pod:$HOME/bin:$HOME/.fvm:$HOME/chtsh/:$HOME/.local/bin/
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
export FVM_HOME=$HOME/fvm
. ~/.asdf/plugins/java/set-java-home.zsh
# export JAVA_HOME=$(/usr/libexec/java_home -v11)
# export JAVA_HOME=$(/usr/libexec/java_home -v 1.8.0)

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

export FZF_DEFAULT_OPTS='--height 50% --layout=reverse --border --multi --no-mouse'
export FZF_CTRL_T_COMMAND="fd $FD_OPTIONS"
export FZF_ALT_C_COMMAND="fd -t d . $HOME/Documents/code"
export GLFW_IM_MODULE=ibus
# export PATH="$HOME/.rbenv/bin"
export SSH_KEY_PATH="~/.ssh/rsa_id"

source ~/.aliases

#eval "$(rbenv init -)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

function runAll(){
  ls -d */ | xargs -I {} bash -c "cd '{}' && $1"
}

f() {
    fff "$@"
    cd "$(cat "${XDG_CACHE_HOME:=${HOME}/.cache}/fff/.fff_d")"
}

eval "$(starship init zsh)"

function tmx(){
 tmux new-session -d -c "~/code/python-book/"-s Python
 tmux new-window -n code
 tmux  new-window -d -n build
 tmux attach-session -d -t Testing
}

#eval "$(starship init zsh)"
fpath=($fpath "/home/noks/.zfunctions")

# Set Spaceship ZSH as a prompt
# autoload -U promptinit; promptinit
# prompt spaceship

export SPACESHIP_PROMPT_ADD_NEWLINE=false
export SPACESHIP_PROMPT_SEPARATE_LINE=false

alias luamake=/home/noks/code/lua-language-server/3rd/luamake/luamake
