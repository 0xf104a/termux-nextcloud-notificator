#!/data/data/com.termux/files/usr/bin/env bash
cd $(dirname `which $0`)

# Colors
if test -t 1; then
    bold=$(tput bold)
    normal=$(tput sgr0)
    red=$(tput setaf 1)
    green=$(tput setaf 2)
    blue=$(tput setaf 4)
    yellow=$(tput setaf 11)
else
    echo "(!) No colors will be available: not supported."
fi

error(){
    echo "${bold}${red}=x ${normal}${1}"
}

success(){
    echo "${bold}${green}=> ${normal}${1}"
}

warn(){
    echo "${bold}${yellow}(!)${normal}${1}"
}

info(){
    echo "${bold}${blue}=> ${normal}${1}"
}

exec(){
    info "${1}"
    eval "${1}"
    code=$?
    if [ ! $code -eq 0 ]; then
        error "Exec: ${1} failed with non-zero exit code: ${code}"
        exit -1
    fi
}

require_directory(){ # Creates directory if not exist
    if [ ! -d $1 ]; then
        warn "Directory not found: ${1}. Will create it now."
        exec "mkdir ${1}"
    fi
}

check_directory(){ # Creates directory if not exist
    if [ ! -d $1 ]; then
        error "Directory not found: ${1}. Will create it now."
        exit -1
    fi
}

change_dir(){
    if [ ! -d $1 ]; then
        error "No such directory: ${1}"
        exit -1
    fi
    info "Entering directory: ${1}"
    cd $1
}

leave_dir(){
    info "Leaving directory: $(pwd)"
    cd $BASEDIR
}

check_equal(){
    printf "${bold}${blue}=>${normal}Checking equality: ${1} and ${2}..."
    if ! cmp $1 $2 >/dev/null 2>&1
    then
      printf "${bold}${red}FAILED${normal}\n"
      return -1
    fi
    printf "${bold}${green}OK${normal}\n"
    return 0
}

require_equal(){
    check_equal $1 $2
    local r=$?
    if [ ! $r -eq 0 ]; then
       error "Files ${1} and ${2} are not equal."
       exit -1
    fi
}

check_command(){
    printf "${bold}${blue}=>${normal}Checking that ${1} avail..."
    if ! [ -x "$(command -v ${1})" ]; then
      printf "${bold}${red}FAILED${normal}\n"
      return -1
    fi
    printf "${bold}${green}OK${normal}\n"
    return 0
}

require_command(){
    check_command $1
    local r=$?
    if [ ! $r -eq 0 ]; then
       error "Command ${1} is not avail."
       exit -1
    fi
}

if [ $# -eq 0 ]; then
    error "Please specify target. Use -h option for help."
    exit -1
fi

if [[ $1 == "-h" ]]; then
    echo "Usage:"$0" <-h> [all]"
    echo "-h        Display this help message and exit."
    echo "all       Install everything"
    echo "deps      Installs required packages to run the app"
    echo "gems      Installs gems"
    echo "install   Copies files and registers program"
    exit 0
fi

TERMUX_ROOT="/data/data/com.termux/files"

target_deps(){
    info "Updating apt repos..."
    require_command "apt"
    exec "apt update"
    exec "apt upgrade"
    exec "apt install ruby"
    success "Installed ruby"
    exec "apt install termux-api"
    success "Installed Termux API"
}
target_gems(){
    info "Installing gems..."
    info "Checking prerequities"
    require_command "bundle"
    require_command "ruby"
    require_command "termux-toast"
    require_command "termux-notification"
    exec "bundle install"
    success "Installed gems"
}
target_install(){
    info "Installing nextcloud-notificator"
    require_directory "${TERMUX_ROOT}/usr/share/nextcloud-notificator"
    exec "cp ./*.rb ${TERMUX_ROOT}/usr/share/nextcloud-notificator"
    require_directory "${TERMUX_ROOT}/home/.termux/boot/"
    exec "cp ./boot.sh ${TERMUX_ROOT}/home/.termux/boot/boot-notificator.sh"
    exec "cp ./config.yml ${TERMUX_ROOT}/usr/etc/nextcloud-notificator.yml"
    success "Installation complete"
}
target_all(){
    target_deps
    target_gems
    target_install
}

if [[ `type -t "target_${1}"` == "function" ]]; then
     eval "target_${1}"
     success "Done."
else
     error "No such target:${1}."
fi
