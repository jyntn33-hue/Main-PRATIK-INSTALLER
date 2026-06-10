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

# Terminal saaf karo pehle
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
# 2. FIXED MULTI-COLOR PROGRESS BAR
# ==========================================
draw_progress_bar() {
    tput civis # Hide cursor
    
    # Static baseline taaki text glitch na kare
    echo -e "${CYAN}⚡ Initializing Environment Modules...${NC}"

    for i in {1..100}; do
        # Progress ke hisab se status text ko overwrite karne ke liye line-return use kiya hai
        if [ $i -eq 30 ]; then
            printf "\r\033[K${ORANGE}⚙️ Structuring System Configuration...${NC}\n"
        elif [ $i -eq 60 ]; then
            printf "\r\033[K${YELLOW}🌀 Optimizing Core Panel Links...${NC}\n"
        elif [ $i -eq 85 ]; then
            printf "\r\033[K${GREEN}🚀 Finalizing Setup Layers...${NC}\n"
        fi

        # Bar ka rang setup
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

        # \r se line ke start mein jaakar render hoga bina upar-niche bhage
        printf "\r${BOLD}[${COLOR}%s${NC}${BOLD}%s] %d%%${NC}" "$fill" "$empty" "$i"
        
        sleep 0.02
    done
    echo -e "\n"
    tput cnorm # Restore cursor
}

# Loading Bar ko chalayein
draw_progress_bar

# ==========================================
# 3. INTERACTIVE MAIN MENU (Your Custom Box Layout)
# ==========================================
show_main_menu() {
    clear
    echo -e "${CYAN}----------------------------------------------------------"
    echo -e "|                    PRATIK EXTRAS V5                    |"
    echo -e "----------------------------------------------------------${NC}"
    echo -e "${YELLOW}[A] Panel (Pterodactyl Management)${NC}"
    echo -e "${RED}[B] Exit${NC}"
    echo -e "${CYAN}----------------------------------------------------------${NC}\n"
    
    # Ab read bilkul safe chalega bina kisi bypass error ke
    printf "${BOLD}Select --> ${NC}"
    read main_choice
    
    case $main_choice in
        [Aa])
            show_panel_menu
            ;;
        [Bb])
            echo -e "\n${GREEN}Chalo bye bhai! Phir milenge. 😎${NC}\n"
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
# 4. SUB MENU: PTERODACTYL PANEL INSIDE [A]
# ==========================================
show_panel_menu() {
    clear
    echo -e "${CYAN}----------------------------------------------------------"
    echo -e "|             PTERODACTYL PANEL MANAGEMENT               |"
    echo -e "----------------------------------------------------------${NC}"
    echo -e "${GREEN}[1] Setup Database${NC}"
    echo -e "${GREEN}[2] Configure Cloudflare DNS${NC}"
    echo -e "${GREEN}[3] Link Domain Name${NC}"
    echo -e "${GREEN}[4] Create New User (Admin/Non-Admin)${NC}"
    echo -e "${YELLOW}[B] Go Back to Main Menu${NC}"
    echo -e "${CYAN}----------------------------------------------------------${NC}\n"
    
    printf "${BOLD}Select Sub-Option --> ${NC}"
    read panel_choice
    
    case $panel_choice in
        1)
            echo -e "\n${YELLOW}[+] Database configure ho raha hai...${NC}"
            sleep 2
            show_panel_menu
            ;;
        2)
            echo -e "\n${YELLOW}[+] Cloudflare configuration loading...${NC}"
            sleep 2
            show_panel_menu
            ;;
        3)
            echo -e "\n${YELLOW}[+] Domain connect ho raha hai...${NC}"
            sleep 2
            show_panel_menu
            ;;
        4)
            clear
            echo -e "${CYAN}----------------------------------------------------------"
            echo -e "|                   CREATE PANEL USER                    |"
            echo -e "----------------------------------------------------------${NC}"
            echo -e "1) Make Admin User"
            echo -e "2) Make Non-Admin (Regular) User"
            echo -e "${CYAN}----------------------------------------------------------${NC}\n"
            printf "Choose Role --> "
            read role_choice
            
            if [ "$role_choice" == "1" ]; then
                echo -e "\n${GREEN}⚡ Creating Admin User... Done!${NC}"
            else
                echo -e "\n${GREEN}👤 Creating Non-Admin User... Done!${NC}"
            fi
            sleep 2
            show_panel_menu
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

# Sabse pehle main menu par bhejein
show_main_menu
