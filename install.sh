#!/bin/bash

# ==========================================
# COLOR DEFINITIONS (ANSI Codes)
# ==========================================
RED='\033[0;31m'
ORANGE='\033[38;5;208m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
MAGENTA='\033[38;5;201m'
NC='\033[0m' # No Color
BOLD='\033[1m'

clear

# ==========================================
# 1. BIG ASCII BANNER (PRATIK EXTRAS V5)
# ==========================================
echo -e "${CYAN}${BOLD}"
echo "  _____  _____       _______ _____ _  __  ______   _______ _____        _____  __      ________ "
echo " |  __ \|  __ \   /\|__   __|_   _| |/ / |  ____| \ /|__   __|  __ \ /\   / ____| \ \    / /  ____|"
echo " | |__) | |__) | /  \  | |    | | | ' /  | |__  \   /   | |  | |__) /  \ | (___    \ \  / /| |__   "
echo " |  ___/|  _  / / /\ \ | |    | | |  <   |  __|  / \    | |  |  _  / /\ \ \___ \    \ \/ / |  __|  "
echo " | |    | | \ \/ ____ \| |   _| |_| . \  | |____/   \   | |  | | \/ ____ \____) |    \  /  | |____ "
echo " |_|    |_|  \_\_/    \_\_|  |_____|_|\_\|______/_/ \_\ |_|  |_|  \_/    \_\_____/      \/   |______|"
echo -e "${NC}"
echo -e "${MAGENTA}💠═════════════════════════════════════════════════════════════════════════════════════💠${NC}\n"

# Initializing fast bar
draw_init_bar() {
    tput civis
    echo -e "${CYAN}✨ Initializing UnOfficial System Architecture...${NC}"
    for i in {1..100}; do
        if [ $i -le 30 ]; then COLOR=$ORANGE; elif [ $i -le 60 ]; then COLOR=$YELLOW; else COLOR=$GREEN; fi
        local done=$((i / 2)); local left=$((50 - done))
        printf "\r${BOLD}[${COLOR}%s${NC}${BOLD}%s] 💎 %d%%${NC}" "$(printf "%${done}s" | tr ' ' '█')" "$(printf "%${left}s" | tr ' ' '░')" "$i"
        sleep 0.01
    done
    echo -e "\n"
    tput cnorm
}
draw_init_bar

# ==========================================
# 2. REAL-TIME BACKGROUND TASK PROCESSOR
# ==========================================
# Yeh function asli progress calculate karta hai parde ke peeche jab tak command chalti hai
execute_with_progress() {
    local message_1="⚡ Updating System Lists..."
    local message_2="📥 Downloading NodeJS & System Tools..."
    local message_3="🌀 Cloning Repository (Crispy Adventure)..."
    local message_4="📦 Making It Happen & Installing Express..."
    
    tput civis # Hide cursor
    
    # Is block mein saari real tasks back-to-back execute hongi silently
    (
        apt-get update -y > /dev/null 2>&1
        apt-get upgrade -y > /dev/null 2>&1
        apt-get install nodejs screen neofetch git -y > /dev/null 2>&1
        rm -rf crispy-adventure > /dev/null 2>&1
        git clone https://github.com/pratikgamer11/crispy-adventure > /dev/null 2>&1
        npm install express > /dev/null 2>&1
    ) &
    
    # Background process ki ID capture karte hain
    local pid=$!
    local progress=0
    
    # Pehli line print kar dete hain baseline ke liye
    echo -e "${CYAN}$message_1${NC}"

    # Jab tak peeche background job active hai, yeh loop chalega
    while kill -0 $pid 2>/dev/null; do
        # Progress ko slowly smooth tareeqe se 99% tak badhayenge duration ke hisab se
        if [ $progress -lt 99 ]; then
            progress=$((progress + 1))
        fi
        
        # 0 se 100 ke beech dynamic custom status updates upar waali line par
        tput cuu1
        tput el
        if [ $progress -le 25 ]; then
            echo -e "${ORANGE}$message_1${NC}"
        elif [ $progress -le 55 ]; then
            echo -e "${YELLOW}$message_2${NC}"
        elif [ $progress -le 80 ]; then
            echo -e "${CYAN}$message_3${NC}"
        else
            echo -e "${GREEN}$message_4${NC}"
        fi
        
        # Color profile set karo percentages par
        if [ $progress -le 30 ]; then COLOR=$ORANGE; elif [ $progress -le 60 ]; then COLOR=$YELLOW; else COLOR=$GREEN; fi
        
        local done=$((progress / 2))
        local left=$((50 - done))
        local fill=$(printf "%${done}s" | tr ' ' '█')
        local empty=$(printf "%${left}s" | tr ' ' '░')
        
        printf "\r${BOLD}[${COLOR}%s${NC}${BOLD}%s] %d%%${NC}" "$fill" "$empty" "$progress"
        
        # Speed tweak karne ke liye sleep dynamic rakha hai (Har block par slow/fast handle karne ko)
        if [ $progress -le 25 ]; then sleep 0.2; elif [ $progress -le 55 ]; then sleep 0.4; else sleep 0.1; fi
    done
    
    # Jab background process khatam ho jaye, use zabardasti 100% par lock kar do
    tput cuu1
    tput el
    echo -e "${GREEN}🚀 All Tasks Successfully Synchronized!${NC}"
    printf "\r${BOLD}[${GREEN}%s${NC}${BOLD}] 100%%${NC}\n" "$(printf "%50s" | tr ' ' '█')"
    
    tput cnorm
    sleep 15 # User ko confirmation dekhne ke liye stop
}

# ==========================================
# 3. INTERACTIVE MAIN MENU (Fancy Box Layout)
# ==========================================
show_main_menu() {
    clear
    echo -e "${MAGENTA}╭──────────────────────────────────────────────────────────╮${NC}"
    echo -e "${MAGENTA}│${NC}                ${BOLD}${CYAN}🔮 PRATIK EXTRAS V5 🔮${NC}                    ${MAGENTA}│${NC}"
    echo -e "${MAGENTA}├──────────────────────────────────────────────────────────┤${NC}"
    echo -e "${MAGENTA}│${NC}  ${BOLD}${YELLOW}[A] ➔ UnOfficial Panel Installation${NC}                     ${MAGENTA}│${NC}"
    echo -e "${MAGENTA}│${NC}  ${BOLD}${RED}[B] ➔ Shut Down Terminal / Exit${NC}                          ${MAGENTA}│${NC}"
    echo -e "${MAGENTA}╰──────────────────────────────────────────────────────────╯${NC}\n"
    
    read -t 1 -n 10000 discard
    printf "${BOLD}${MAGENTA}Select Option ✨𝄪 ${NC}"
    read main_choice
    
    case $main_choice in
        [Aa])
            show_panel_menu
            ;;
        [Bb])
            echo -e "\n${GREEN}🔌 Disconnected. Chalo bye bhai! Phir milenge. 😎${NC}\n"
            exit 0
            ;;
        *)
            echo -e "\n${RED}╭──────────────────────────────────────────────────────────╮"
            echo -e "│     ⚠️ Galat option choose kiya bhai! Dobara try karo.  │"
            echo -e "╰──────────────────────────────────────────────────────────╯${NC}"
            sleep 2
            show_main_menu
            ;;
    esac
}

# ==========================================
# 4. SUB MENU: UNOFFICIAL PANEL
# ==========================================
show_panel_menu() {
    clear
    echo -e "${CYAN}╭──────────────────────────────────────────────────────────╮${NC}"
    echo -e "${CYAN}│${NC}              ${BOLD}${MAGENTA}🛰️ UNOFFICIAL PANEL MAIN CONSOLE${NC}            ${CYAN}│${NC}"
    echo -e "${CYAN}├──────────────────────────────────────────────────────────┤${NC}"
    echo -e "${CYAN}│${NC}  ${GREEN}[1] ⚡ Deploy & Run UnOfficial Panel (Full Auto)${NC}      ${CYAN}│${NC}"
    echo -e "${CYAN}│${NC}  ${YELLOW}[B] ↩ Return Back to Core Menu${NC}                          ${CYAN}│${NC}"
    echo -e "${CYAN}╰──────────────────────────────────────────────────────────╯${NC}\n"
    
    read -t 1 -n 10000 discard
    printf "${BOLD}${CYAN}Execute Action ❖ ${NC}"
    read panel_choice
    
    case $panel_choice in
        1)
            clear
            echo -e "${MAGENTA}═════════════════════════════════════════════════════════${NC}"
            echo -e "${BOLD}${YELLOW}⚡ BACKGROUND COMPILATION RUNNING (CRISPY ADVENTURE)${NC}"
            echo -e "${MAGENTA}═════════════════════════════════════════════════════════${NC}\n"
            
            # Yahan humne dynamic process run kar diya
            execute_with_progress
            
            # Jab process final complete hoga, tab screen transparent hoke directory me jump karegi
            cd crispy-adventure && node .
            ;;
        [Bb])
            show_main_menu
            ;;
        *)
            echo -e "\n${RED}╭──────────────────────────────────────────────────────────╮"
            echo -e "│     ⚠️ Galat option choose kiya bhai! Dobara try karo.  │"
            echo -e "╰──────────────────────────────────────────────────────────╯${NC}"
            sleep 2
            show_panel_menu
            ;;
    esac
}

# Start the application loop
show_main_menu
