################ BASH ALIASES ################

# If these are enabled they will be used instead of any instructions
# they may mask.  For example, alias rm='rm -i' will mask the rm
# application.  To override the alias instruction use a \ before, ie
# \rm will call the real rm not the alias.

########### ENVIRONMENT VARIABLES ############



#################### BASH ####################

### Repeat previous command with sudo ###
alias ffs='sudo $(history -p \!\!)'
### Reload .bashrc ###
alias 'rbash'='. ~/.bashrc'



############ DIRECTORY OPERATIONS ############

### Default to human readable figures ###
alias df='df -h'								# free disk space
alias du='du -h'								# print disk usage

alias less='less -r'							# raw control characters
alias whence='type -a'							# where, of a sort
alias grep='grep --color'						# show differences in color
alias egrep='egrep --color=auto'				# show differences in color
alias fgrep='fgrep --color=auto'				# show differences in color

alias mkdir='mkdir -pv'						# create parent directories on demand

### Shortcuts for directory listings ###
alias ls='ls -hF --color=tty'					# classify files in color
alias lx='ls -lXB'								# sort by extension
alias lk='ls -lSr'								# sort by size, biggest last
alias lt='ls -ltr'								# sort by date, most recent last
alias lc='ls -ltcr'								# sort by/show change time, most recent last
alias lu='ls -ltur'								# sort by/show access time, most recent last
alias dir='ls --color=auto --format=vertical'
alias vdir='ls --color=auto --format=long'
alias ll='ls -l'								# long list
alias la='ls -A'								# all but . and ..
alias l='ls -CF'

alias mount='mount |column -t'					# mount command human readable



############## FILE OPERATIONS ##############

### Interactive operation ###
#alias rm='rm -i'
alias rm='rm -I --preserve-root'
alias cp='cp -i'
alias mv='mv -i'
alias ln='ln -i'

### Remap rm to put into trash ###
#alias tp="trash-put";
#alias rm="trash-put";
#alias tl="trash-list";

### List all files and grep the names ###
alias lg='ls -la | grep';



################## SYSTEM #################
## pass options to free ## 
alias meminfo='free -m -l -t'
 
## get top process eating memory
alias psmem='ps auxf | sort -nr -k 4'
alias psmem10='ps auxf | sort -nr -k 4 | head -10'
 
## get top process eating cpu ##
alias pscpu='ps auxf | sort -nr -k 3'
alias pscpu10='ps auxf | sort -nr -k 3 | head -10'
 
## Get server cpu info ##
alias cpuinfo='lscpu'

alias top='watch "ps -W"' # pipe to grep for filtering



################# PROGRAMS #################



################# FUN STUFF #################

