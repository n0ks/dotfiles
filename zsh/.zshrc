# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi

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

export DOTFILES=$HOME/.dotfiles
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export EDITOR="nvim"
export TERM=xterm-256color

export PATH=$PATH:/bin:/usr/bin$HOME/.rbenv/bin:/usr/local/var/rbenv/shims/pod:$HOME/bin
export ANDROID_HOME=$HOME/Library/Android/sdk
export ANDROID_SDK_ROOT=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH=$PATH:$HOME/.pub-cache/bin
export PATH=$PATH:$HOME/fvm/default/bin
export PATH=$PATH:$HOME/.cargo/bin

# export JAVA_HOME=$(/usr/libexec/java_home -v11)
export JAVA_HOME=$(/usr/libexec/java_home -v 1.8.0)

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
export FZF_ALT_C_COMMAND="fd -t d . $HOME/Documents/Projects/flutter_bvpd"

# export PATH="$HOME/.rbenv/bin"
export SSH_KEY_PATH="~/.ssh/rsa_id"

# Git things
alias g="git"
alias gcm="git checkout master"
alias gcm="git checkout develop"
alias cph="git log -1 --pretty=format:"%h" | pbcopy"
alias sourcezsh="source ~/.zshrc"
alias ggl="git pull"
alias gsb='git status -sb'
alias gtv='git tag | sort -V'
alias gupa='git pull --rebase --autostash'

alias rmn="rm -rf node_modules && echo node_modules deleted!"
alias lfolder="ls -d -- */ .*/"
alias lc='colorls --sd'
alias lct='colorls --sd --tree=1'
alias nv=nvim
alias vim=nvim
alias ls=exa
alias luamake=$HOME/Documents/Projects/github/lua-language-server/3rd/luamake/luamake
# Shortcuts
alias vim=nvim
alias ls=exa
alias luamake=$HOME/Documents/Projects/github/lua-language-server/3rd/luamake/luamake
# Shortcuts
alias d="cd ~/Dropbox"
alias dl="cd ~/Downloads"
alias dt="cd ~/Desktop"
alias p="cd $PROJECTS"
# Gatekeeper (for installing 3rd party apps)
alias gatekeeperOff="sudo spctl --master-disable"
alias gatekeeperOn="sudo spctl --master-enable"

eval "$(rbenv init -)"

# source ~/powerlevel10k/powerlevel10k.zsh-theme

# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
# (( ! ${+functions[p10k]} )) || p10k finalize

function runAll(){
  ls -d */ | xargs -I {} bash -c "cd '{}' && $1"
}

