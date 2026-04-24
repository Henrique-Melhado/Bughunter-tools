#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
NC='\033[0m' 
BOLD='\033[1m'

CHECKMARK="${GREEN}✔${NC}"
CROSS="${RED}✘${NC}"
INFO="${BLUE}ℹ${NC}"
WARN="${YELLOW}⚠${NC}"

show_banner() {
    clear
    echo -e "${CYAN}${BOLD}"
    echo "  ██████╗ ██╗   ██╗ ██████╗      ██╗  ██╗██╗   ██╗███╗   ██╗████████╗███████╗██████╗ "
    echo "  ██╔══██╗██║   ██║██╔════╝      ██║  ██║██║   ██║████╗  ██║╚══██╔══╝██╔════╝██╔══██╗"
    echo "  ██████╔╝██║   ██║██║  ███╗     ███████║██║   ██║██╔██╗ ██║   ██║   █████╗  ██████╔╝"
    echo "  ██╔══██╗██║   ██║██║   ██║     ██╔══██║██║   ██║██║╚██╗██║   ██║   ██╔══╝  ██╔══██╗"
    echo "  ██████╔╝╚██████╔╝╚██████╔╝     ██║  ██║╚██████╔╝██║ ╚████║   ██║   ███████╗██║  ██║"
    echo "  ╚══════╝  ╚═════╝  ╚═════╝      ╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═══╝   ╚═╝   ╚══════╝╚═╝  ╚═╝"
    echo -e "                                                                    ${PURPLE}${NC}"
    echo -e "${WHITE}---------------------------------------------------------------------------------------${NC}"
}

log_info()    { echo -e "${INFO} ${CYAN}$1${NC}"; }
log_success() { echo -e "${CHECKMARK} ${GREEN}$1${NC}"; }
log_error()   { echo -e "${CROSS} ${RED}$1${NC}"; }
log_warn()    { echo -e "${WARN} ${YELLOW}$1${NC}"; }

spinner() {
    local pid=$1
    local delay=0.1
    local spinstr='|/-\'
    while [ "$(ps a | awk '{print $1}' | grep $pid)" ]; do
        local temp=${spinstr#?}
        printf " [%c]  " "$spinstr"
        local spinstr=$temp${spinstr%"$temp"}
        sleep $delay
        printf "\b\b\b\b\b\b"
    done
    printf "    \b\b\b\b"
}

check_env() {
    log_info "Checking system environment..."
    
    local deps=("git" "curl" "wget" "python3" "go")
    for dep in "${deps[@]}"; do
        if command -v $dep &> /dev/null; then
            log_success "$dep is already installed"
        else
            log_warn "$dep is missing. Installing..."
            sudo apt-get install -y $dep &> /dev/null &
            spinner $!
        fi
    done
}

install_go_tools() {
    echo -e "\n${BOLD}${PURPLE}➤ Installing Go-based Tools${NC}"
    
    export GOPATH=$HOME/go
    export PATH=$PATH:$GOPATH/bin
    mkdir -p $GOPATH/bin

    local go_tools=(
        "github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest"
        "github.com/projectdiscovery/httpx/cmd/httpx@latest"
        "github.com/projectdiscovery/nuclei/v2/cmd/nuclei@latest"
        "github.com/projectdiscovery/naabu/v2/cmd/naabu@latest"
        "github.com/projectdiscovery/interactsh/cmd/interactsh-client@latest"
        "github.com/ffuf/ffuf@latest"
        "github.com/tomnomnom/assetfinder@latest"
        "github.com/tomnomnom/gau/v2/cmd/gau@latest"
        "github.com/tomnomnom/waybackurls@latest"
        "github.com/lc/gau/v2/cmd/gau@latest"
        "github.com/hakluke/hakrawler@latest"
        "github.com/jaeles-project/jaeles@latest"
    )

    for tool in "${go_tools[@]}"; do
        name=$(echo $tool | awk -F'/' '{print $NF}' | cut -d'@' -f1)
        log_info "Installing $name..."
        go install -v $tool &> /dev/null &
        spinner $!
        if [ -f "$GOPATH/bin/$name" ]; then
            log_success "$name installed successfully"
        else
            log_error "Failed to install $name"
        fi
    done
}

install_python_tools() {
    echo -e "\n${BOLD}${PURPLE}➤ Installing Python-based Tools${NC}"
    
    if ! command -v pip3 &> /dev/null; then
        log_warn "Pip3 missing. Installing..."
        sudo apt-get install -y python3-pip &> /dev/null &
        spinner $!
    fi

    local pip_tools=(
        "sqlmap"
        "arjun"
        "paramspider"
        "waymore"
    )

    for tool in "${pip_tools[@]}"; do
        log_info "Installing $tool via pip..."
        pip3 install $tool --upgrade &> /dev/null &
        spinner $!
        log_success "$tool installed/updated"
    done

    mkdir -p ~/tools
    
    log_info "Installing Dirsearch..."
    if [ ! -d "$HOME/tools/dirsearch" ]; then
        git clone https://github.com/maurosoria/dirsearch.git $HOME/tools/dirsearch &> /dev/null &
        spinner $!
        pip3 install -r $HOME/tools/dirsearch/requirements.txt &> /dev/null
    fi
    log_success "Dirsearch ready"

    log_info "Installing SecretFinder..."
    if [ ! -d "$HOME/tools/SecretFinder" ]; then
        git clone https://github.com/m4ll0k/SecretFinder.git $HOME/tools/SecretFinder &> /dev/null &
        spinner $!
        pip3 install -r $HOME/tools/SecretFinder/requirements.txt &> /dev/null
    fi
    log_success "SecretFinder ready"
}

show_banner
check_env
install_go_tools
install_python_tools

echo -e "\n${GREEN}${BOLD}──────────────────────────────────────────────────────────────────────────"
echo -e "  Installation Complete! Happy Hunting! 🛡️"
echo -e "  Note: Make sure to add ~/go/bin to your .bashrc or .zshrc"
echo -e "  export PATH=\$PATH:\$HOME/go/bin"
echo -e "──────────────────────────────────────────────────────────────────────────${NC}\n"