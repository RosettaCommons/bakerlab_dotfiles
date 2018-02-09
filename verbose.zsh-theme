# this is essentially this:
# http://stevelosh.com/blog/2010/02/my-extravagant-zsh-prompt/

# set different prompt characters if working in a git/hg repo
function prompt_char {
    git branch >/dev/null 2>/dev/null && echo '±' && return
    # hg root >/dev/null 2>/dev/null && echo '☿' && return # i never use hg
    echo '○'
}

# start prompt with a newline, then print "$USER at $HOST"
PROMPT='
%{$fg[magenta]%}%n%{$reset_color%} at %{$fg[yellow]%}%m%{$reset_color%}'

# display the CWD, collapse $HOME to ~
PROMPT=$PROMPT' in %{$fg_bold[green]%}${PWD/#$HOME/~}%{$reset_color%}'

# add git repo information (current branch, if it's dirty) and the prompt char
PROMPT=$PROMPT'$(git_prompt_info)
%{$fg[blue]%}$(prompt_char)%{$reset_color%} '

ZSH_THEME_GIT_PROMPT_PREFIX=" on %{$fg[magenta]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[green]%} ☝︎"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[green]%}?" # unsupported in mainline omz
ZSH_THEME_GIT_PROMPT_CLEAN=""
