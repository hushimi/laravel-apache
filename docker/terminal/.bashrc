# prompt
# . /root/git-prompt.sh
PROMPT_COMMAND='echo;';
PS1='\[\e[38;5;248;1m\]\d\[\e[0m\] \[\e[38;5;158;1m\]\w\n\[\e[0m\][\[\e[38;5;155m\]nectoapp\[\e[0m\]]\[\e[38;5;196m\]${PS1_CMD1}\[\e[0m\]: \$ ';

set-alias(){
    alias ls='ls -alFG --color';
    alias cl='clear';
    alias grep='grep --color';
}
set-alias
