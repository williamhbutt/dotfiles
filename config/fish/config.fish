alias h='history'
alias ..='cd ..'
alias c='clear'
alias ls='ls -G'
alias home='cd ~'
alias v='mvim'
alias cdu='cd (git rev-parse --show-toplevel)'
alias s='git status'
alias pull='git pull'
alias push='git push'
alias dev='cd ~/Developer'
alias mou="open /Applications/Mou.app"
function cd
  builtin cd $argv; ls
end
function mkcd
  mkdir $argv; cd $argv
end
git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%C(bold blue)<%an>%Creset' --abbrev-commit"


# DIGITAS Specific Aliases
alias jmvc='cd ~/Developer/flag_enterprise_code/flag-ent-webapp/WebContent/jmvc/'
alias bmh='cd /Users/wbutt/Developer/flag_bmh/bmh-webapp/src/main/ui/'
