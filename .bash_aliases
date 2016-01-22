# ~/.bash_aliases

# aliases
alias la='ls -a --color=auto'
alias ls='ls --hide="*~" --color=auto'
alias ll='ls -l -a --color=auto'

alias sshpi='ssh pi@129.22.161.120'
alias duall='du -sch .[!.]* * |sort -h'
alias pacclean='paccache -r; paccache -ruk0'
alias pacll='expac --timefmt="%Y-%m-%d %T" "%l\t%n" | sort | tail -20'

