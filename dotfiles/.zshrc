# Aliases
if [ -f ~/.zsh_aliases ]; then
    source ~/.zsh_aliases
fi

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/ronald/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/ronald/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/ronald/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/ronald/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

addToPath() {
    if [[ "$PATH" != *"$1"* ]]; then
        export PATH=$PATH:$1
    fi
}

addToPath $HOME/.local/scripts
export PATH="/opt/homebrew/opt/ruby/bin:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

###########

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
MAGENTA='\033[0;35m'  # Added missing MAGENTA
NC='\033[0m' # No Color

# Enable colors for zsh
autoload -U colors && colors

# Git functions (compatible with zsh)
parse_git_branch() {
    local branch=$(git symbolic-ref --short HEAD 2>/dev/null)
    if [ -n "$branch" ]; then
        echo " ($branch)"
    fi
}

# Helper function to get git dirty indicator with color
git_dirty() {
    if [[ -n $(git status --porcelain 2>/dev/null) ]]; then
        echo "*"
    fi
}

# Zsh-style prompt with colors and git info
setopt PROMPT_SUBST  # Enable command substitution in prompts

# Set up the prompt using zsh syntax with proper colors
# Format: username@hostname:path (branch)* $
# Branch in yellow, dirty indicator (*) in red
PROMPT='%{$fg[green]%}%n%{$reset_color%}:%{$fg[blue]%}%~%{$reset_color%}%{$fg[yellow]%}$(parse_git_branch)%{$reset_color%}%{$fg[red]%}$(git_dirty)%{$reset_color%}%# '

# Set window title for compatible terminals
case $TERM in
    xterm*|rxvt*|screen*)
        precmd() {
            print -Pn "\e]0;%n@%m: %~\a"
        }
        ;;
esac

# Enable better completion
autoload -Uz compinit && compinit

# History settings (zsh-specific improvements)
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history
setopt SHARE_HISTORY          # Share history between sessions
setopt HIST_IGNORE_DUPS       # Don't record duplicates
setopt HIST_IGNORE_ALL_DUPS   # Remove older duplicates
setopt HIST_IGNORE_SPACE      # Don't record commands starting with space

# Color support for ls and grep
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    # Linux
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
elif [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS
    alias ls='ls -G'
    export CLICOLOR=1
fi

# Zsh-specific improvements
setopt AUTO_CD              # Change directory without typing cd
setopt CORRECT              # Spell correction for commands
setopt GLOB_DOTS            # Include dotfiles in glob patterns

# =============================================================================================================
# =============================================================================================================
# =============================================================================================================
print_ronalds_notes() {
    echo -e "${CYAN}====== ${WHITE}Ronald's Notes ${CYAN}======"
    echo ""
    echo -e "${PURPLE}🖥️  TMUX SHORTCUTS${NC}"
    echo -e "  List sessions:   ${YELLOW}tls${NC}"
    echo -e "  List sessions:   ${YELLOW}tmux list-sessions${NC}"
    echo -e "  Attach sessions: ${YELLOW}ta <name> ${NC}"
    echo -e "  Attach sessions: ${YELLOW}tmux attach -t <name> ${NC}"
    echo -e "  New session:     ${CYAN}tmux new -s ${WHITE}<name>${NC}"
    echo -e "  Navigation:      ${CYAN}Ctrl+b${NC} ${WHITE}c${NC}(new) ${WHITE}n${NC}(next) ${WHITE}p${NC}(prev)"
    echo -e "  Split panes:     ${CYAN}Ctrl+b${NC} ${WHITE}%${NC}(vertical) ${WHITE}\"${NC}(horizontal)"
    echo -e "  Session mgmt:    ${CYAN}Ctrl+b d${NC}(detach) ${CYAN}tmux attach -t ${WHITE}<name>${NC}"
    echo ""
    echo -e "${RED}🗂️  SESSION MANAGEMENT${NC}"
    echo -e "  Kill session:    ${YELLOW}tmux kill-session -t ${WHITE}<name>${NC}"
    echo ""
    echo -e "${MAGENTA}⌨️  COMMAND LINE SHORTCUTS${NC}"
    echo -e "  Previous cmd:    ${CYAN}Ctrl+p${NC}"
    echo -e "  Next cmd:        ${CYAN}Ctrl+n${NC}"
    echo -e "  Delete word:     ${CYAN}Ctrl+w${NC} (before cursor)"
    echo -e "  Delete line:     ${CYAN}Ctrl+u${NC} (whole line)"
    echo -e "  Clear line:      ${CYAN}Ctrl+c${NC} (abort current)"
    echo -e "  Delete rest:     ${CYAN}Ctrl+k${NC} (cursor to end)"
    echo -e "  Search history:  ${CYAN}Ctrl+r${NC} (reverse search)"
    echo -e "  Next match:      ${CYAN}Ctrl+r again${NC} (older matches)"
    echo -e "  Abort search:    ${CYAN}Ctrl+g${NC} (abort search)"
    echo -e "  Directory up:    ${YELLOW}..${NC} ${YELLOW}...${NC}"
    echo ""
    echo -e "${WHITE}💡 HELP COMMANDS${NC}"
    echo -e "  General help:    ${YELLOW}h${NC}"
    echo -e "  TMUX help:       ${YELLOW}htmux${NC}"
    echo -e "  NetRW help:      ${YELLOW}hnetrw${NC}"
    echo -e "  Coc.nvim help:   ${YELLOW}hcoc${NC}"
    echo -e "  Quick fix help:  ${YELLOW}hqfl${NC}"
    echo -e "  Ripgrep help:    ${YELLOW}hrg${NC}"
    echo -e "  Buffers help:    ${YELLOW}hbuffers${NC}"
    echo ""
    echo -e "  Git log:         ${YELLOW}gitlog 10${NC}"
    echo ""
    echo -e "${PURPLE}⌨️  VIM SHORTCUTS${NC}"
    echo -e "  Comments:        ${CYAN}gcc, gc, Ctrl+/${NC}"
    echo -e "  Folding:         ${CYAN}<leader><leader>${NC}"
    echo -e "  File nav:        ${CYAN}<C-p>, <leader>fs, <leader>fa, <leader>fw${NC}"
    echo -e "  Coc config:      ${YELLOW}/.vim/coc-settings${NC} (TypeScript configured)"
}

# Only print notes if this is an interactive shell
if [[ $- == *i* ]]; then
    print_ronalds_notes
fi

export LD_LIBRARY_PATH=$HOME/local/bin:$LD_LIBRARY_PATH
export PKG_CONFIG_PATH=$HOME/local/lib/pkgconfig:$PKG_CONFIG_PATH
