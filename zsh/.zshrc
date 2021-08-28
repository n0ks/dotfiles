# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_BEEP
setopt auto_cd
# source ~/git-plugin.zsh
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export EDITOR="nvim"
export TERM=xterm-256color

export DOTFILES=$HOME/.dotfiles

export PATH=$PATH:/bin:/usr/bin$HOME/.rbenv/bin:/usr/local/var/rbenv/shims/pod:$HOME/bin:$HOME/Documents/Projects/flutter_bvpd/card-holy-scripts
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH=$PATH:$HOME/.pub-cache/bin
export PATH=$PATH:$HOME/fvm/default/bin
export PATH=$PATH:$HOME/.cargo/bin

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

export BB_URL="https://${GIT_BV_USERNAME}:${GIT_BV_PASSWORD}@bitbucket.bvnet.bv"

# export PATH="$HOME/.rbenv/bin"
# export SSH_KEY_PATH="~/.ssh/rsa_id"

alias gcm="git checkout master"
alias cph="git log -1 --pretty=format:"%h" | pbcopy"
alias sourcezsh="source ~/.zshrc"
alias projects="cd $PROJECTS"
alias bvbank="cd $PROJECTS/flutter_bvpd/flutapp-bvpd-base-bank.git/"
alias bvcart="cd $PROJECTS/flutter_bvpd/cartoes/"
alias rmn="rm -rf node_modules && echo node_modules deleted!"
alias lfolder="ls -d -- */ .*/"
alias lc='colorls --sd'
alias lct='colorls --sd --tree=1'
alias nv=nvim
alias luamake=$HOME/Documents/Projects/github/lua-language-server/3rd/luamake/luamake

alias bvpr-appca="./bitbucket.sh open_pr flutapp-acli-cart-appcartoes"
alias bvpr-core="./bitbucket.sh open_pr flutlib-acli-cart-core"
alias bvpr-model="./bitbucket.sh open_pr flutlib-acli-cart-model"
alias bvpr-service="./bitbucket.sh open_pr flutlib-acli-cart-service"
alias bvpr-utils="./bitbucket.sh open_pr flutlib-acli-cart-utils"
alias bvpr-home="./bitbucket.sh open_pr flutmicro-acli-cart-home"
alias bvpr-hub="./bitbucket.sh open_pr flutmicro-acli-cart-hub"
alias bvpr-invoice="./bitbucket.sh open_pr flutmicro-acli-cart-invoice"
alias bvpr-unloc="./bitbucket.sh open_pr flutmicro-acli-cart-lock-unlock"
alias bvpr-points="./bitbucket.sh open_pr flutmicro-acli-cart-pointsprogram"
alias bvpr-settings="./bitbucket.sh open_pr flutmicro-acli-cart-settings"
alias bvpr-timeline="./bitbucket.sh open_pr flutmicro-acli-cart-timeline"
alias bvpr-vcard="./bitbucket.sh open_pr flutmicro-acli-cart-virtualcard"
alias bvpr-credit="./bitbucket.sh open_pr flutmicro-acli-cart-personalcredit"
alias bvpr-review="./bitbucket.sh open_pr flutmicro-acli-cart-store-review"
alias bvpr:e="nv ~/Documents/Projects/flutter_bvpd/cartoes/card-holy-scripts/.env"

eval "$(rbenv init -)"

source ~/powerlevel10k/powerlevel10k.zsh-theme

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
(( ! ${+functions[p10k]} )) || p10k finalize

function runAll(){
  ls -d */ | xargs -I {} bash -c "cd '{}' && $1"
}

