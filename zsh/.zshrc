setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_BEEP
setopt AUTO_PUSHD # cd -1,-2 etc..
setopt SHARE_HISTORY
setopt HIST_REDUCE_BLANKS
setopt appendhistory
setopt auto_cd
unsetopt MULTIOS

# Homebrew prefix, cached (HOMEBREW_PREFIX comes from `brew shellenv` in ~/.zprofile)
BREW_PREFIX="${HOMEBREW_PREFIX:-/opt/homebrew}"
fpath+=("$BREW_PREFIX/share/zsh/site-functions") # also where brew's pure lives
fpath+=($HOME/.zsh-complete)

# autoload bashcompinit && bashcompinit
autoload -Uz compinit && compinit
autoload -U edit-command-line
#
zle -N edit-command-line

# source <(kubectl completion zsh)
bindkey -M vicmd v edit-command-line
bindkey '^ ' autosuggest-accept

PURE_GIT_DELAY_DIRTY_CHECK=0
PURE_CMD_MAX_EXEC_TIME=1
PURE_GIT_PULL=0
#
# complete -C '/usr/local/bin/aws_completer' aws
bindkey -v

HISTSIZE=10000
SAVEHIST=10000

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

export ASDF_DATA_DIR=~/.asdf
export XDG_CONFIG_HOME="$HOME/.config"
export HISTFILE=$HOME/.zsh_history
export DOTFILES=$HOME/.dotfiles
export MANPAGER="sh -c 'col -bx | bat -l man -p --theme zenburn'"
export EDITOR="nvim"
export PATH=$PATH:/bin:/usr/bin:$HOME/bin:$HOME/.local/bin/:$HOME/Library/Android/sdk/build-tools/34.0.0:$ASDF_DATA_DIR/shims
export ANDROID_HOME=$HOME/Library/Android/sdk
export ANDROID_SDK_ROOT=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH=$PATH:$HOME/.pub-cache/bin
export PATH=$PATH:$HOME/fvm/default/bin
export PATH=$PATH:$HOME/.cargo/bin
export PATH="$PATH:/Applications/Docker.app/Contents/Resources/bin"
# export PATH=$PATH:$HOME/.asdf/shims
export FVM_CACHE_PATH=$HOME/fvm
export GEM_HOME=$HOME/.gem
export PATH=$GEM_HOME/bin:$PATH
# runtimes managed by asdf; only exported when installed
if (( $+commands[asdf] )); then
  _asdf_dir=$(asdf where java 2>/dev/null) && export JAVA_HOME=$_asdf_dir
  _asdf_dir=$(asdf where golang 2>/dev/null) && export GOROOT=$_asdf_dir/go GOBIN=$_asdf_dir/packages/bin
  unset _asdf_dir
fi
# export MANPAGER='nvim -u +Man!'
export MANWIDTH=999
export PATH="$BREW_PREFIX/opt/mysql@8.4/bin:$PATH"

export HOMEBREW_NO_AUTO_UPDATE=1
export GIT_EDITOR=vim
export GIT_SEQUENCE_EDITOR="vim"
export FREETYPE_PROPERTIES="truetype:interpreter-version=35"
export FD_OPTIONS="--follow --exclude .git --exclude node_modules"
export FASTLANE_HIDE_CHANGELOG=1
export FASTLANE_SKIP_UPDATE_CHECK=1 
export LG_CONFIG_FILE="$HOME/.config/lazygit/config.yml"

export FZF_DEFAULT_OPTS="--height 50% --layout=reverse --border --multi --no-mouse 
--bind 'f1:execute(less -f {}),ctrl-y:execute-silent(echo {} | pbcopy)+abort'"

export FZF_CTRL_T_COMMAND="fd $FD_OPTIONS"
# Preview file content using bat (https://github.com/sharkdp/bat)
export FZF_CTRL_T_OPTS="
  --walker-skip .git,node_modules,target
  --preview 'bat -n --color=always {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"

# export FZF_CTRL_R_OPTS='--no-sort'
# CTRL-Y to copy the command into clipboard using pbcopy
export FZF_CTRL_R_OPTS="
  --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
  --color header:italic
  --header 'Press CTRL-Y to copy command into clipboard'"

export FZF_ALT_C_COMMAND="fd --max-results 200 --max-depth 2 -t d . $HOME/code "
export GLFW_IM_MODULE=ibus


source ~/.aliases
unalias azp 2>/dev/null; azp() { az pipelines "$@" --organization "https://dev.azure.com/timbrasil/" --project "Projeto_App_Meu_TIM"; }
[[ -f $BREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]] &&
  source $BREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh

(( $+commands[fzf] )) && source <(fzf --zsh)
(( $+commands[zoxide] )) && eval "$(zoxide init zsh)"
[[ -f ~/functions.sh ]] && source ~/functions.sh

autoload -U promptinit; promptinit
prompt pure

## [Completion]
## Completion scripts setup. Remove the following line to uninstall
[[ -f $HOME/.config/.dart-cli-completion/zsh-config.zsh ]] && . $HOME/.config/.dart-cli-completion/zsh-config.zsh || true
## [/Completion]


# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

if command -v wt >/dev/null 2>&1; then eval "$(command wt config shell init zsh)"; fi

[[ -f "$HOME/.local/bin/env" ]] && . "$HOME/.local/bin/env"

# checkTrack — auditor de tagueamento Dashboard Metrics
checkTrack() {
  bash "${HOME}/.claude/scripts/check_track.sh" "$@"
}

# machine-local secrets/overrides (not versioned; created by the setup script)
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local
