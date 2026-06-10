#!/bin/bash

# ==========================================
# COLOR DEFINITIONS (ANSI Codes)
# ==========================================
RED='\033[0;31m'
ORANGE='\033[38;5;208m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color
BOLD='\033[1m'

# Clear terminal for a fresh start
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
echo -e "${YELLOW}=========================================================================================${NC}\n"

# ==========================================
# 2. MULTI-COLOR PROGRESS BAR (100% Native)
# ==========================================
draw_progress_bar() {
    # Hide cursor
    tput civis

    for i in {1..100}; do
        tput cuu1 # Move cursor up 1 line
        tput el   # Clear that line
        
        if [ $i -le 25 ]; then
            echo -e "${CYAN}⚡ Initializing PRATIK EXTRAS V5...${NC}"
        elif [ $i -le 55 ]; then
            echo -e "${ORANGE}⚙️ Structuring Environment...${NC}"
        elif [ $i -le 85 ]; then
            echo -e "${YELLOW}🌀 Optimizing Core Modules...${NC}"
        else
            echo -e "${GREEN}🚀 Finalizing Setup...${NC}"
        fi

        if [ $i -le 30 ]; then
            COLOR=$ORANGE
        elif [ $i -le 60 ]; then
            COLOR=$YELLOW
        else
            COLOR=$GREEN
        fi

        local done=$((i / 2))
        local left=$((50 - done))
        local fill=$(printf "%${done}s" | tr ' ' '█')
        local empty=$(printf "%${left}s" | tr ' ' '░')

        printf "\r${BOLD}[${COLOR}%s${NC}${BOLD}%s] %d%%${NC}" "$fill" "$empty" "$i"
        
        sleep 0.03 # Smooth fast loading (No 'bc' dependency)
    done
    echo -e "\n"
    tput cnorm # Restore cursor
}

# Run the progress bar animation
draw_progress_bar

# ==========================================
# 3. INTERACTIVE MAIN MENU
# ==========================================
show_main_menu() {
    clear
    echo -e "${CYAN}${BOLD}======================================================="
    echo -e "             🔥 PRATIK EXTRAS V5 MENU 🔥               "
    echo -e "=======================================================${NC}\n"
    
    echo -e "${YELLOW}${BOLD}[A] Panel ➔ Pterodactyl Management${NC}"
    echo -e "${RED}[E] Exit${NC}\n"
    
    read -p "Bhai, option select karo: " main_choice
    
    case $main_choice in
        [Aa])
            show_panel_menu
            ;;
        [Ee])
            echo -e "\n${GREEN}Chalo bye bhai! Phir milenge. 😎${NC}\n"
            exit 0
            ;;
        *)
            echo -e "\n${RED}Galat option choose kiya bhai! Dobara try karo.${NC}"
            sleep 2
            show_main_menu
            ;;
    esac
}

# ==========================================
# 4. SUB MENU: PTERODACTYL PANEL INSIDE [A]
# ==========================================
show_panel_menu() {
    clear
    echo -e "${CYAN}${BOLD}======================================================="
    echo -e "         🎮 PTERODACTYL PANEL MANAGEMENT 🎮            "
    echo -e "=======================================================${NC}\n"
    
    echo -e "${GREEN}[1] Setup Database${NC}"
    echo -e "${GREEN}[2] Configure Cloudflare DNS${NC}"
    echo -e "${GREEN}[3] Link Domain Name${NC}"
    echo -e "${GREEN}[4] Create New User (Admin/Non-Admin)${NC}"
    echo -e "${YELLOW}[B] Go Back to Main Menu${NC}\n"
    
    read -p "Kaunsa task run karna hai? Choose karo: " panel_choice
    
    case $panel_choice in
        1)
            echo -e "\n${YELLOW}[+] Database options clear ho rahe hain... (Yahan apna feature code daalna)${NC}"
            sleep 3
            show_panel_menu
            ;;
        2)
            echo -e "\n${YELLOW}[+] Cloudflare API settings check ho rahi hain...${NC}"
            sleep 3
            show_panel_menu
            ;;
        3)
            echo -e "\n${YELLOW}[+] Domain mapping start ho rahi hai...${NC}"
            sleep 3
            show_panel_menu
            ;;
        4)
            clear
            echo -e "${CYAN}${BOLD}--- CREATE NEW PANEL USER ---${NC}\n"
            echo -e "1) Make Admin User"
            echo -e "2) Make Non-Admin (Regular) User"
            read -p "Select Role: " role_choice
            if [ "$role_choice" == "1" ]; then
                echo -e "\n${GREEN}⚡ Creating Admin User... Done!${NC}"
            else
                echo -e "\n${GREEN}👤 Creating Non-Admin User... Done!${NC}"
            fi
            sleep 3
            show_panel_menu
            ;;
        [Bb])
            show_main_menu
            ;;
        *)
            echo -e "\n${RED}Galat input! Waapis jaa rahe hain...${NC}"
            sleep 2
            show_panel_menu
            ;;
    esac
}

# Kickstart the menu loop after progress bar finishes
show_main_menu
