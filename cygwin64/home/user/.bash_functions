################ BASH FUNCTIONS ################

################ BASH FILES ################

### Edit and reload bash aliases ###
function ealiases () {
    nano ~/.bash_aliases && . ~/.bashrc;
}

### Edit and reload bash functions ###
function efunctions () {
    nano ~/.bash_functions && . ~/.bashrc;
}

### Edit and reload bash paths ###
function epaths () {
    nano ~/.bash_paths && . ~/.bashrc;
}

################ FOLDER OPERATIONS ################

### Copy large file with progress ###
function cpb() {
    if [ -z "$1" ]; then
        # display usage if no parameters given
        echo "Usage: cp %file/folder source% %file/folder destination%"
    else
        rsync "$1" "$2" -Pavz
    fi
}

### Create a directory and change into it at the same time ###
function md() {                                     # $ md $foldername
    if [ -z "$1" ]; then
        # display usage if no parameters given
        echo "Usage: md <folder_name>   # create folder_name and cd into it"
    else
        mkdir -p "$@" && cd "$@";
    fi
}

### Allow 'cd' to maintain a history ###
# This function defines a 'cd' replacement function capable of keeping,
# displaying and accessing history of visited directories, up to 10 entries.
# acd_func 1.0.5, 10-nov-2004
# Petar Marinov, http:/geocities.com/h2428, this is public domain
cd_func () {                                        # $ cd -- # for a list of entries
                                                    # $ cd .i # to cd to the i-th entry
    if [ -z "$1" ]; then
        # display usage if no parameters given
        echo "Usage:    cd -- # shows the last 10 entries"
        echo "          cd .i # cd to the i^th entry"
    else
        local x2 the_new_dir adir index
        local -i cnt

        if [[ $1 ==  "--" ]]; then
            dirs -v
            return 0
        fi

        the_new_dir=$1
        [[ -z $1 ]] && the_new_dir=$HOME

        if [[ ${the_new_dir:0:1} == '-' ]]; then
            # Extract dir N from dirs
            index=${the_new_dir:1}
            [[ -z $index ]] && index=1
            adir=$(dirs +$index)
            [[ -z $adir ]] && return 1
            the_new_dir=$adir
        fi

        # '~' has to be substituted by ${HOME}
        [[ ${the_new_dir:0:1} == '~' ]] && the_new_dir="${HOME}${the_new_dir:1}"

        # Now change to the new dir and add to the top of the stack
        pushd "${the_new_dir}" > /dev/null
        [[ $? -ne 0 ]] && return 1
        the_new_dir=$(pwd)

        # Trim down everything beyond 11th entry
        popd -n +11 2>/dev/null 1>/dev/null

        # Remove any other occurence of this dir, skipping the top of the stack
        for ((cnt=1; cnt <= 10; cnt++)); do
            x2=$(dirs +${cnt} 2>/dev/null)
            [[ $? -ne 0 ]] && return 0
            [[ ${x2:0:1} == '~' ]] && x2="${HOME}${x2:1}"
            if [[ "${x2}" == "${the_new_dir}" ]]; then
                popd -n +$cnt 2>/dev/null 1>/dev/null
                cnt=cnt-1
            fi
        done
    fi

    return 0
}

alias cd=cd_func

### cd up n directories ###
function mcd() {                                    # mcd n # where n is the number of entries to go up
    if [ -z "$1" ]; then
        # display usage if no parameters given
        echo "Usage: mcd <number of dirs to cd up>"
    else
        if [[ $1 -lt 1 ]]; then
            echo "Only positive integer values larger than 1 are allowed!" >&2
            echo -e "\n\tUsage:\n\t======\n\n\t\t# to go up 10 levels in your directory\n\t\tmcd 10\n\n\t\t# to go up just 2 levels\n\t\tmcd 2\n" >&2
            return 1;
        fi
    fi

    up=""

    for ((i=1; i<=$1;i++)); do
        up="${up}../"
    done

    cd $up
}

### Extract file based on extension ###
function extract {
    if [ -z "$1" ]; then
        # display usage if no parameters given
        echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
    else
        if [ -f "$1" ] ; then
            NAME=${1%.*}
            #mkdir $NAME && cd $NAME
            case "$1" in
                *.tar.bz2)   tar xvjf ./"$1"    ;;
                *.tar.gz)    tar xvzf ./"$1"    ;;
                *.tar.xz)    tar xvJf ./"$1"    ;;
                *.lzma)      unlzma ./"$1"      ;;
                *.bz2)       bunzip2 ./"$1"     ;;
                *.rar)       unrar x -ad ./"$1" ;;
                *.gz)        gunzip ./"$1"      ;;
                *.tar)       tar xvf ./"$1"     ;;
                *.tbz2)      tar xvjf ./"$1"    ;;
                *.tgz)       tar xvzf ./"$1"    ;;
                *.zip)       unzip ./"$1"       ;;
                *.Z)         uncompress ./"$1"  ;;
                *.7z)        7z x ./"$1"        ;;
                *.xz)        unxz ./"$1"        ;;
                *.exe)       cabextract ./"$1"  ;;
                *)           echo "extract: '$1' - unknown archive method" ;;
            esac
        else
            echo "'$1' - file does not exist"
        fi
    fi
}

### Select appropriate music folder ###
# PROTIP: use cd `lmus %letter%` to cd directly into the appropriate dir
function lmus () {                                  # $ lmus x # where x is the letter to sort by
    if [ -z "$1" ]; then
        # display usage if no parameters given
        echo "Usage: lmus <folder letter to sort by>"
    else
        if [[ $1 == [1-9a-fA-F] ]] ; then
            echo "/cygdrive/C/Users/$USER/Music/Music_1-F"
        elif [[ $1 == [g-mG-M] ]] ; then
            echo "/cygdrive/C/Users/$USER/Music/Music_G-M"
        elif [[ $1 == [n-tN-T] ]] ; then
            echo "/cygdrive/C/Users/$USER/Music/Music_N-T"
        elif [[ $1 == [u-zU-Z] ]] ; then
            echo "/cygdrive/C/Users/$USER/Music/Music_U-Z"
        else
            echo Invalid Range
        fi
    fi
}

### Create a ZIP archive of a file or folder ###
function makezip() {
    if [ -z "$1" ]; then
        # display usage if no parameters given
        echo "Usage: makezip <file/folder to zip>"
    else
        zip -r "${1%%/}.zip" "$1" ;
    fi
}

### Repeat command n times ###
function repeat() {
    local i max
    max=$1; shift;
    for ((i=1; i <= max ; i++)); do  # --> C-like syntax
        eval "$@";
    done
}

### Make your directories and files access rights sane ###
function sanitize() {
    chmod -R u=rwX,g=rX,o= "$@" ;
}

### Run dos2unix on all custom bash files
function d2ubf() {
    dos2unix ~/.bash_aliases
    dos2unix ~/.bash_functions
    dos2unix ~/.bash_paths
}

### Run gitignore.io from command line
function gi() {                                         # $ gi language1,language2,etc >> .gitignore
                                                        # $ gi list # displays list of supported languages
    if [ -z "$1" ]; then
        # display usage if no parameters given
        echo "Usage: gi <language1,language2,...> >> <destination file_name>"
    else
        curl -L -s https://www.gitignore.io/api/$@ ;
    fi
}

### Get weather forecast courtesy of graph.no
function forecast() {
    if [ -z "$1" ]; then
        # forecast for home city
	    finger helsinki@graph.no
    else
        # forecast for input city
        finger $1@graph.no
    fi
}
