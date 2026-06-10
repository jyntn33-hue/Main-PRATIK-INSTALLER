#!/bin/bash

# ==========================================
# COLOR DEFINITIONS
# ==========================================
RED='\033[0;31m'
NC='\033[0m' # No Color
ORANGE='\033[38;5;208m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
GREEN='\033[0;32m'
BOLD='\033[1m'

clear

# ==========================================
# 1. BIG ASCII BANNER (RED COLOR)
# ==========================================
echo -e "${RED}${BOLD}"
echo "  _____  _____       _______ _____ _  __  ______   _______ _____        _____  __      ________ "
echo " |  __ \|  __ \   /\|__   __|_   _| |/ / |  ____| \ /|__   __|  __ \ /\   / ____| \ \    / /  ____|"
echo " | |__) | |__) | /  \  | |    | | | ' /  | |__  \   /   | |  | |__) /  \ | (___    \ \  / /| |__   "
echo " |  ___/|  _  / / /\ \ | |    | | |  <   |  __|  / \    | |  |  _  / /\ \ \___ \    \ \/ / |  __|  "
echo " | |    | | \ \/ ____ \| |   _| |_| . \  | |____/   \   | |  | | \/ ____ \____) |    \  /  | |____ "
echo " |_|    |_|  \_\_/    \_\_|  |_____|_|\_\|______/_/ \_\ |_|  |_|  \_/    \_\_____/      \/   |______|"
echo -e "${NC}"

# ==========================================
# 2. INTRO PROGRESS BAR (Optional flair)
# ==========================================
draw_init_bar() {
    tput civis
    echo -e "${RED}⚡ Initializing System...${NC}"
    for i in {1..100}; do
        if [ $i -le 30 ]; then COLOR=$ORANGE; elif [ $i -le 60 ]; then COLOR=$YELLOW; else COLOR=$GREEN; fi
        local done=$((i / 2)); local left=$((50 - done))
        printf "\r${BOLD}[${COLOR}%s${NC}${BOLD}%s] %d%%${NC}" "$(printf "%${done}s" | tr ' ' '█')" "$(printf "%${left}s" | tr ' ' '░')" "$i"
        sleep 0.01
    done
    echo -e "\n"
    tput cnorm
}
draw_init_bar

# ==========================================
# 3. REAL-TIME BACKGROUND TASK PROCESSOR
# ==========================================
execute_with_progress() {
    local msg1="⚡ Updating System Lists..."
    local msg2="📥 Downloading nodejs & tools..."
    local msg3="🌀 Cloning Repository..."
    local msg4="📦 Making It Happen..."
    
    tput civis
    
    # Asli commands background me chupchaap chalengi
    (
        apt-get update -y > /dev/null 2>&1
        apt-get upgrade -y > /dev/null 2>&1
        apt-get install nodejs screen neofetch git -y > /dev/null 2>&1
        rm -rf crispy-adventure > /dev/null 2>&1
        git clone https://github.com/pratikgamer11/crispy-adventure > /dev/null 2>&1
        npm install express > /dev/null 2>&1
    ) &
    
    local pid=$!
    local progress=0
    
    echo -e "${RED}$msg1${NC}"

    while kill -0 $pid 2>/dev/null; do
        if [ $progress -lt 99 ]; then progress=$((progress + 1)); fi
        
        tput cuu1
        tput el
        
        if [ $progress -le 25 ]; then echo -e "${RED}$msg1${NC}"
        elif [ $progress -le 55 ]; then echo -e "${ORANGE}$msg2${NC}"
        elif [ $progress -le 80 ]; then echo -e "${YELLOW}$msg3${NC}"
        else echo -e "${GREEN}$msg4${NC}"; fi
        
        if [ $progress -le 30 ]; then COLOR=$RED; elif [ $progress -le 60 ]; then COLOR=$ORANGE; else COLOR=$GREEN; fi
        
        local done=$((progress / 2))
        local left=$((50 - done))
        printf "\r${BOLD}[${COLOR}%s${NC}${BOLD}%s] %d%%${NC}" "$(printf "%${done}s" | tr ' ' '█')" "$(printf "%${left}s" | tr ' ' '░')" "$progress"
        
        if [ $progress -le 25 ]; then sleep 0.2; elif [ $progress -le 55 ]; then sleep 0.4; else sleep 0.1; fi
    done
    
    tput cuu1
    tput el
    echo -e "${GREEN}🚀 Setup Completed Successfully!${NC}"
    printf "\r${BOLD}[${GREEN}%s${NC}${BOLD}] 100%%${NC}\n" "$(printf "%50s" | tr ' ' '█')"
    
    tput cnorm
    sleep 2
}

# ==========================================
# 4. INTERACTIVE MAIN MENU (RED BOX LAYOUT)
# ==========================================
show_main_menu() {
    clear
    echo -e "${RED}----------------------------------------------------------"
    echo -e "|                    PRATIK EXTRAS V5                    |"
    echo -e "----------------------------------------------------------"
    echo -e "[A] Panel"
    echo -e "[B] Exit"
    echo -e "----------------------------------------------------------${NC}\n"
    
    printf "${RED}${BOLD}Select --> ${NC}"
    
    # YEH HAI ASLI FIX: < /dev/tty lagane se auto-select glitch life me nahi aayega
    read main_choice < /dev/tty
    
    case $main_choice in
        [Aa])
            show_panel_menu
            ;;
        [Bb])
            echo -e "\n${GREEN}🔌 Disconnected. Bye bhai!${NC}\n"
            exit 0
            ;;
        *)
            echo -e "\n${RED}----------------------------------------------------------"
            echo -e "|       Galat option choose kiya bhai! Dobara try karo.  |"
            echo -e "----------------------------------------------------------${NC}"
            sleep 2
            show_main_menu
            ;;
    esac
}

# ==========================================
# 5. SUB MENU: UNOFFICIAL PANEL
# ==========================================
show_panel_menu() {
    clear
    echo -e "${RED}----------------------------------------------------------"
    echo -e "|              UNOFFICIAL PANEL MAIN CONSOLE             |"
    echo -e "----------------------------------------------------------"
    echo -e "[1] Deploy & Run UnOfficial Panel (Full Auto)"
    echo -e "[B] Return Back"
    echo -e "----------------------------------------------------------${NC}\n"
    
    printf "${RED}${BOLD}Select Sub-Option --> ${NC}"
    
    # Yahan bhi FIX lagaya hai
    read panel_choice < /dev/tty
    
    case $panel_choice in
        1)
            clear
            echo -e "${RED}----------------------------------------------------------"
            echo -e "|               BACKGROUND PROCESS RUNNING               |"
            echo -e "----------------------------------------------------------${NC}\n"
            
            # Progress bar chalega
            execute_with_progress
            
            # Process complete hone par direct node trigger karega
            cd crispy-adventure && node .
            ;;
        [Bb])
            show_main_menu
            ;;
        *)
            echo -e "\n${RED}----------------------------------------------------------"
            echo -e "|       Galat option choose kiya bhai! Dobara try karo.  |"
            echo -e "----------------------------------------------------------${NC}"
            sleep 2
            show_panel_menu
            ;;
    esac
}

# Start the application loop
show_main_menu
