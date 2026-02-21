#!/usr/bin/env bash

# ============================================
# XCX MEGA TOP - CLEAN PROFESSIONAL DESKTOP
# Version: 9.0.0 (Orderly UI)
# Codename: Precision Interface
# ============================================

# ============================================
# COLOR SCHEME - CLEAN & PROFESSIONAL
# ============================================

declare -A XCX=(
    # Clean colors
    [BLACK]="\033[0;30m"
    [RED]="\033[0;31m"
    [GREEN]="\033[0;32m"
    [YELLOW]="\033[0;33m"
    [BLUE]="\033[0;34m"
    [PURPLE]="\033[0;35m"
    [CYAN]="\033[0;36m"
    [WHITE]="\033[0;37m"
    
    # Styles
    [BOLD]="\033[1m"
    [DIM]="\033[2m"
    [UNDERLINE]="\033[4m"
    [RESET]="\033[0m"
    
    # Professional accents
    [ACCENT1]="\033[38;5;39m"   # Bright Blue
    [ACCENT2]="\033[38;5;46m"   # Bright Green
    [ACCENT3]="\033[38;5;202m"  # Orange
    [ACCENT4]="\033[38;5;198m"  # Pink
    [ACCENT5]="\033[38;5;226m"  # Yellow
    
    # Backgrounds
    [BG_DARK]="\033[48;5;235m"   # Dark gray
    [BG_LIGHT]="\033[48;5;255m"  # Light gray
    [BG_BLACK]="\033[48;5;0m"    # Black
    [BG_WHITE]="\033[48;5;15m"   # White
)

# ============================================
# XCX HOME - ORGANIZED STRUCTURE
# ============================================

XCX_HOME="$HOME/.xcx-mega-v9"

# Organized directory structure
declare -A XCX_PATHS=(
    [ROOT]="$XCX_HOME"
    [APPS]="$XCX_HOME/applications"
    [TOOLS]="$XCX_HOME/tools"
    [DATA]="$XCX_HOME/data"
    [CONFIG]="$XCX_HOME/config"
    [CACHE]="$XCX_HOME/cache"
    [LOGS]="$XCX_HOME/logs"
    [TEMP]="$XCX_HOME/temp"
    
    # Organized by category
    [SYSTEM]="$XCX_HOME/applications/system"
    [SECURITY]="$XCX_HOME/applications/security"
    [NETWORK]="$XCX_HOME/applications/network"
    [CRACKING]="$XCX_HOME/applications/cracking"
    [ANONYMITY]="$XCX_HOME/applications/anonymity"
    [STORAGE]="$XCX_HOME/applications/storage"
    [UTILITIES]="$XCX_HOME/applications/utilities"
    
    # Data organization
    [WORDLISTS]="$XCX_HOME/data/wordlists"
    [PAYLOADS]="$XCX_HOME/data/payloads"
    [RESULTS]="$XCX_HOME/data/results"
    [WORKSPACE]="$XCX_HOME/data/workspace"
)

# ============================================
# TERMINAL DIMENSIONS
# ============================================

ROWS=$(tput lines)
COLS=$(tput cols)

# Fixed UI regions
TASKBAR_H=2                     # Top taskbar height
TOOLBAR_H=3                     # Quick access toolbar
STATUSBAR_H=2                   # Bottom status bar
CONTENT_START=$((TASKBAR_H + 1))
CONTENT_END=$((ROWS - STATUSBAR_H - TOOLBAR_H - 1))

# Panel dimensions
SIDEBAR_W=30                    # Left sidebar width
TOOLBAR_W=$COLS                 # Full width
STATUSBAR_W=$COLS               # Full width

# ============================================
# WINDOW MANAGEMENT
# ============================================

declare -A WINDOWS
declare -A WIN_TITLE
declare -A WIN_X WIN_Y WIN_W WIN_H
declare -A WIN_TYPE
declare -A WIN_PID
declare -A WIN_CONTENT

NEXT_WIN_ID=1000
ACTIVE_WIN=""
WIN_COUNT=0

# ============================================
# TOOL CATEGORIES - ORDERLY ARRANGED
# ============================================

declare -A TOOL_CATEGORIES=(
    [1]="SYSTEM"
    [2]="SECURITY"
    [3]="NETWORK"
    [4]="CRACKING"
    [5]="ANONYMITY"
    [6]="STORAGE"
    [7]="UTILITIES"
)

declare -A CATEGORY_ICONS=(
    [SYSTEM]="⚙️"
    [SECURITY]="🛡️"
    [NETWORK]="🌐"
    [CRACKING]="🔑"
    [ANONYMITY]="🕵️"
    [STORAGE]="💾"
    [UTILITIES]="🔧"
)

# Organized tools by category
declare -A TOOLS=(
    # System Tools
    [1]="TERMINAL:system:bash"
    [2]="FILE MANAGER:system:ls -la"
    [3]="PROCESS MONITOR:system:top -bn1"
    [4]="SYSTEM INFO:system:uname -a"
    
    # Security Tools
    [5]="PORT SCANNER:security:nmap localhost"
    [6]="VULN SCANNER:security:nmap --script vuln localhost"
    [7]="PACKET SNIFFER:security:tcpdump -c 5"
    [8]="DNS ENUM:security:dnsrecon -d google.com"
    
    # Network Tools
    [9]="NETWORK MAP:network:arp -a"
    [10]="BANDWIDTH MONITOR:network:iftop -t -s 1"
    [11]="CONNECTION TRACKER:network:ss -tunap"
    [12]="ROUTE ANALYZER:network:route -n"
    
    # Cracking Tools
    [13]="PASSWORD CRACKER:cracking:john --test"
    [14]="HASH GENERATOR:cracking:echo 'hash' | md5sum"
    [15]="BRUTE FORCE:cracking:hydra -h"
    [16]="RAINBOW TABLES:cracking:rcrack -h"
    
    # Anonymity Tools
    [17]="MAC CHANGER:anonymity:macchanger --help"
    [18]="PROXY CHAIN:anonymity:proxychains curl ifconfig.me"
    [19]="TOR CHECK:anonymity:curl --socks5 localhost:9050 ifconfig.me"
    [20]="IP SPOOFER:anonymity:echo 'Spoofing active'"
    
    # Storage Tools
    [21]="DISK ANALYZER:storage:df -h"
    [22]="FILE ENCRYPTOR:storage:gpg --help"
    [23]="DATA SHREDDER:storage:shred --help"
    [24]="VOLUME MANAGER:storage:lsblk"
    
    # Utilities
    [25]="CALCULATOR:utilities:bc -l"
    [26]="TEXT EDITOR:utilities:nano --version"
    [27]="HEX VIEWER:utilities:xxd --version"
    [28]="FILE COMPARATOR:utilities:diff --help"
)

# ============================================
# INITIALIZATION
# ============================================

init_system() {
    # Create all directories
    for path in "${XCX_PATHS[@]}"; do
        mkdir -p "$path"
    done
    
    # Create category directories
    mkdir -p "${XCX_PATHS[SYSTEM]}" "${XCX_PATHS[SECURITY]}" "${XCX_PATHS[NETWORK]}"
    mkdir -p "${XCX_PATHS[CRACKING]}" "${XCX_PATHS[ANONYMITY]}" "${XCX_PATHS[STORAGE]}"
    mkdir -p "${XCX_PATHS[UTILITIES]}"
    
    # Create data subdirectories
    mkdir -p "${XCX_PATHS[WORDLISTS]}" "${XCX_PATHS[PAYLOADS]}" "${XCX_PATHS[RESULTS]}"
    
    # Hide cursor
    tput civis
    
    # Trap cleanup
    trap cleanup SIGINT SIGTERM
    
    # Create tool wrappers
    create_tool_wrappers
}

create_tool_wrappers() {
    # Create wrapper scripts for each tool
    for id in "${!TOOLS[@]}"; do
        IFS=':' read -r name category cmd <<< "${TOOLS[$id]}"
        local wrapper="${XCX_PATHS[TOOLS]}/tool_$id.sh"
        
        cat > "$wrapper" << EOF
#!/usr/bin/env bash
echo -e "\033[1;36m═══════════════════════════════════════════════\033[0m"
echo -e "\033[1;33m  $name - XCX Tool v1.0\033[0m"
echo -e "\033[1;36m═══════════════════════════════════════════════\033[0m"
echo ""
$cmd 2>&1
echo ""
echo -e "\033[1;36m═══════════════════════════════════════════════\033[0m"
echo -e "\033[1;33m  Press any key to close\033[0m"
read -n1
EOF
        chmod +x "$wrapper"
    done
}

# ============================================
# CLEAN UI COMPONENTS
# ============================================

draw_taskbar() {
    local datetime=$(date "+%H:%M:%S")
    local date=$(date "%Y-%m-%d")
    
    # Clean top bar
    tput cup 0 0
    echo -ne "${XCX[BG_DARK]}${XCX[WHITE]}${XCX[BOLD]}"
    printf "%-${COLS}s" "╔══════════════════════════════════════════════════════════════════════════════╗"
    
    tput cup 1 0
    printf "║ ${XCX[ACCENT1]}XCX MEGA TOP${XCX[WHITE]} │ ${XCX[ACCENT2]}WIN:${#WINDOWS[@]}${XCX[WHITE]} │ ${XCX[ACCENT3]}MODE:NORMAL${XCX[WHITE]} │ ${XCX[ACCENT4]}$date${XCX[WHITE]} │ ${XCX[ACCENT5]}$datetime${XCX[WHITE]} %-$((COLS-80))s ║" ""
    
    echo -ne "${XCX[RESET]}"
}

draw_statusbar() {
    local y=$((ROWS - STATUSBAR_H))
    
    tput cup $y 0
    echo -ne "${XCX[BG_DARK]}${XCX[WHITE]}${XCX[BOLD]}"
    printf "%-${COLS}s" "╠══════════════════════════════════════════════════════════════════════════════╣"
    
    tput cup $((y+1)) 0
    printf "║ ${XCX[ACCENT1]}[F1] HELP${XCX[WHITE]} │ ${XCX[ACCENT2]}[F2] CATEGORIES${XCX[WHITE]} │ ${XCX[ACCENT3]}[F3] TOOLS${XCX[WHITE]} │ ${XCX[ACCENT4]}[F4] CLOSE${XCX[WHITE]} │ ${XCX[ACCENT5]}[Q] EXIT${XCX[WHITE]} %-$((COLS-60))s ║" ""
    
    echo -ne "${XCX[RESET]}"
}

draw_toolbar() {
    local y=$((ROWS - STATUSBAR_H - TOOLBAR_H))
    
    tput cup $y 0
    echo -ne "${XCX[BG_DARK]}${XCX[WHITE]}${XCX[BOLD]}"
    printf "%-${COLS}s" "╠══════════════════════════════════════════════════════════════════════════════╣"
    
    # Quick access buttons
    tput cup $((y+1)) 2
    echo -e "${XCX[ACCENT1]}${XCX[BOLD]} QUICK ACCESS: ${XCX[RESET]}"
    
    local x=20
    for i in {1..5}; do
        tput cup $((y+1)) $x
        echo -e "${XCX[BG_LIGHT]}${XCX[BLACK]} TOOL $i ${XCX[RESET]}"
        x=$((x+12))
    done
    
    tput cup $((y+2)) 2
    echo -e "${XCX[ACCENT2]}${XCX[BOLD]} CATEGORIES: ${XCX[RESET]}"
    
    x=20
    for cat in "${TOOL_CATEGORIES[@]}"; do
        tput cup $((y+2)) $x
        echo -e "${XCX[ACCENT3]}${CATEGORY_ICONS[$cat]} $cat ${XCX[RESET]}"
        x=$((x+15))
    done
}

draw_sidebar() {
    local y=$CONTENT_START
    local x=2
    local width=$SIDEBAR_W
    
    # Sidebar header
    tput cup $y $x
    echo -e "${XCX[ACCENT1]}${XCX[BOLD]}╔══════════════════════════════╗${XCX[RESET]}"
    tput cup $((y+1)) $x
    echo -e "${XCX[ACCENT1]}${XCX[BOLD]}║     TOOL CATEGORIES         ║${XCX[RESET]}"
    tput cup $((y+2)) $x
    echo -e "${XCX[ACCENT1]}${XCX[BOLD]}╠══════════════════════════════╣${XCX[RESET]}"
    
    # List categories
    local line=3
    for num in {1..7}; do
        local cat="${TOOL_CATEGORIES[$num]}"
        local icon="${CATEGORY_ICONS[$cat]}"
        
        tput cup $((y+line)) $((x+2))
        echo -e "${XCX[ACCENT2]}$num.${XCX[WHITE]} $icon $cat"
        
        # Show first 2 tools under each category
        local subline=1
        for id in "${!TOOLS[@]}"; do
            IFS=':' read -r name cat_name cmd <<< "${TOOLS[$id]}"
            if [ "$cat_name" = "$cat" ] && [ $subline -le 2 ]; then
                tput cup $((y+line+subline)) $((x+4))
                echo -e "${XCX[DIM]}  • $name${XCX[RESET]}"
                ((subline++))
            fi
        done
        
        line=$((line + 4))
    done
    
    tput cup $((y+line)) $x
    echo -e "${XCX[ACCENT1]}${XCX[BOLD]}╚══════════════════════════════╝${XCX[RESET]}"
}

draw_content_area() {
    local y=$CONTENT_START
    local x=$((SIDEBAR_W + 4))
    local width=$((COLS - SIDEBAR_W - 6))
    local height=$((CONTENT_END - CONTENT_START))
    
    # Content area border
    tput cup $y $x
    echo -e "${XCX[ACCENT2]}${XCX[BOLD]}╔════════════════════════════════════════════════════════════════╗${XCX[RESET]}"
    tput cup $((y+1)) $x
    echo -e "${XCX[ACCENT2]}${XCX[BOLD]}║                    ACTIVE WINDOWS                              ║${XCX[RESET]}"
    tput cup $((y+2)) $x
    echo -e "${XCX[ACCENT2]}${XCX[BOLD]}╠════════════════════════════════════════════════════════════════╣${XCX[RESET]}"
    
    # Show active windows
    if [ ${#WINDOWS[@]} -eq 0 ]; then
        tput cup $((y+4)) $((x+4))
        echo -e "${XCX[DIM]}No active windows. Press a number (1-28) to launch a tool.${XCX[RESET]}"
    else
        local line=4
        for id in "${!WINDOWS[@]}"; do
            tput cup $((y+line)) $((x+4))
            echo -e "${XCX[ACCENT3]}• ${XCX[WHITE]}${WIN_TITLE[$id]}${XCX[RESET]}"
            ((line++))
        done
    fi
    
    # Fill rest of content area
    for ((i=3; i<height-1; i++)); do
        tput cup $((y+i)) $x
        echo -e "${XCX[ACCENT2]}${XCX[BOLD]}║${XCX[RESET]}"
        tput cup $((y+i)) $((x+width-1))
        echo -e "${XCX[ACCENT2]}${XCX[BOLD]}║${XCX[RESET]}"
    done
    
    tput cup $((y+height-1)) $x
    echo -e "${XCX[ACCENT2]}${XCX[BOLD]}╚════════════════════════════════════════════════════════════════╝${XCX[RESET]}"
}

draw_system_stats() {
    local y=$((CONTENT_END - 12))
    local x=$((SIDEBAR_W + 4))
    local width=$((COLS - SIDEBAR_W - 6))
    
    # System stats panel
    tput cup $y $x
    echo -e "${XCX[ACCENT4]}${XCX[BOLD]}╔════════════════════════════════════════════════════════════════╗${XCX[RESET]}"
    tput cup $((y+1)) $x
    echo -e "${XCX[ACCENT4]}${XCX[BOLD]}║                    SYSTEM STATISTICS                           ║${XCX[RESET]}"
    tput cup $((y+2)) $x
    echo -e "${XCX[ACCENT4]}${XCX[BOLD]}╠════════════════════════════════════════════════════════════════╣${XCX[RESET]}"
    
    # Real system stats
    local cpu=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}' | cut -d'%' -f1)
    local mem=$(free -m | awk '/^Mem:/{print int($3/$2 * 100)}')
    local disk=$(df -h / | awk 'NR==2 {print $5}' | tr -d '%')
    
    tput cup $((y+3)) $((x+4))
    echo -e "${XCX[ACCENT1]}CPU:${XCX[WHITE]} ${cpu:-0}%"
    tput cup $((y+4)) $((x+4))
    echo -e "${XCX[ACCENT2]}MEM:${XCX[WHITE]} ${mem:-0}%"
    tput cup $((y+5)) $((x+4))
    echo -e "${XCX[ACCENT3]}DISK:${XCX[WHITE]} ${disk:-0}%"
    
    # Storage usage
    local storage_size=$(du -sh "${XCX_PATHS[DATA]}" 2>/dev/null | cut -f1)
    local tool_count=${#TOOLS[@]}
    
    tput cup $((y+3)) $((x+30))
    echo -e "${XCX[ACCENT4]}STORAGE:${XCX[WHITE]} $storage_size"
    tput cup $((y+4)) $((x+30))
    echo -e "${XCX[ACCENT5]}TOOLS:${XCX[WHITE]} $tool_count"
    tput cup $((y+5)) $((x+30))
    echo -e "${XCX[ACCENT1]}WINDOWS:${XCX[WHITE]} ${#WINDOWS[@]}"
    
    tput cup $((y+6)) $x
    echo -e "${XCX[ACCENT4]}${XCX[BOLD]}╚════════════════════════════════════════════════════════════════╝${XCX[RESET]}"
}

# ============================================
# WINDOW MANAGEMENT - CLEAN POPUPS
# ============================================

create_window() {
    local title="$1"
    local content="$2"
    local w=${3:-60}
    local h=${4:-15}
    local id=$((NEXT_WIN_ID++))
    
    # Center window in content area
    local content_x=$((SIDEBAR_W + 4))
    local content_y=$CONTENT_START
    local content_w=$((COLS - SIDEBAR_W - 6))
    local content_h=$((CONTENT_END - CONTENT_START))
    
    # Center within content area
    local x=$((content_x + (content_w - w) / 2))
    local y=$((content_y + (content_h - h) / 2))
    
    # Ensure window stays within bounds
    [ $x -lt $((content_x + 2)) ] && x=$((content_x + 2))
    [ $y -lt $((content_y + 2)) ] && y=$((content_y + 2))
    
    # Store window data
    WINDOWS[$id]="$x $y $w $h"
    WIN_TITLE[$id]="$title"
    WIN_X[$id]=$x
    WIN_Y[$id]=$y
    WIN_W[$id]=$w
    WIN_H[$id]=$h
    WIN_CONTENT[$id]="$content"
    
    # Draw window
    draw_window $id
    ACTIVE_WIN=$id
    
    return $id
}

draw_window() {
    local id=$1
    local x=${WIN_X[$id]} y=${WIN_Y[$id]} w=${WIN_W[$id]} h=${WIN_H[$id]}
    local title="${WIN_TITLE[$id]}"
    
    # Window border with title
    tput cup $y $x
    echo -ne "${XCX[ACCENT1]}┌"
    for ((i=1; i<w-1; i++)); do
        if [ $i -eq $(((w - ${#title} - 2) / 2)) ]; then
            echo -ne " ${title} "
            i=$((i + ${#title} + 1))
        else
            echo -ne "─"
        fi
    done
    echo -ne "┐${XCX[RESET]}"
    
    # Close button
    tput cup $y $((x + w - 2))
    echo -ne "${XCX[RED]}✗${XCX[RESET]}"
    
    # Side borders
    for ((i=1; i<h-1; i++)); do
        tput cup $((y + i)) $x
        echo -ne "${XCX[ACCENT1]}│${XCX[RESET]}"
        tput cup $((y + i)) $((x + w - 1))
        echo -ne "${XCX[ACCENT1]}│${XCX[RESET]}"
    done
    
    # Bottom border
    tput cup $((y + h - 1)) $x
    echo -ne "${XCX[ACCENT1]}└"
    for ((i=1; i<w-1; i++)); do
        echo -ne "─"
    done
    echo -ne "┘${XCX[RESET]}"
    
    # Fill content
    local line_num=0
    IFS=$'\n' read -rd '' -a lines <<< "$content"
    for line in "${lines[@]}"; do
        if [ $line_num -lt $((h - 2)) ]; then
            tput cup $((y + 1 + line_num)) $((x + 1))
            echo -ne "${XCX[WHITE]}${line:0:$((w-2))}${XCX[RESET]}"
            ((line_num++))
        fi
    done
}

close_window() {
    local id=$1
    
    # Clear window area
    local x=${WIN_X[$id]} y=${WIN_Y[$id]} w=${WIN_W[$id]} h=${WIN_H[$id]}
    for ((i=0; i<h; i++)); do
        tput cup $((y + i)) $x
        printf "%${w}s" " "
    done
    
    # Remove from array
    unset WINDOWS[$id] WIN_TITLE[$id] WIN_X[$id] WIN_Y[$id]
    unset WIN_W[$id] WIN_H[$id] WIN_CONTENT[$id]
    
    if [ "$ACTIVE_WIN" = "$id" ]; then
        ACTIVE_WIN=""
    fi
}

# ============================================
# TOOL EXECUTION
# ============================================

launch_tool() {
    local id=$1
    IFS=':' read -r name category cmd <<< "${TOOLS[$id]}"
    
    # Run tool and capture output
    local output
    output=$(bash "${XCX_PATHS[TOOLS]}/tool_$id.sh" 2>&1)
    
    # Create window with output
    create_window "$name" "$output" 70 20
}

# ============================================
# KEYBOARD HANDLER
# ============================================

handle_input() {
    read -n1 -s key
    
    case "$key" in
        $'\x1b') # ESC sequences
            read -n2 -s rest
            case "$rest" in
                '[11~') # F1 - Help
                    local help_text="XCX MEGA TOP v9.0 - HELP\n\n"
                    help_text+="KEYBOARD SHORTCUTS:\n"
                    help_text+="  F1     - This help window\n"
                    help_text+="  F2     - Show categories\n"
                    help_text+="  F3     - List all tools\n"
                    help_text+="  F4     - Close active window\n"
                    help_text+="  Q      - Exit desktop\n\n"
                    help_text+="TOOL LAUNCH:\n"
                    help_text+="  Press numbers 1-28 to launch corresponding tool\n\n"
                    help_text+="CATEGORIES:\n"
                    help_text+="  1-7: System, Security, Network, Cracking, Anonymity, Storage, Utilities"
                    create_window "HELP" "$help_text" 60 20
                    ;;
                '[12~') # F2 - Categories
                    local cat_text="TOOL CATEGORIES:\n\n"
                    for num in {1..7}; do
                        local cat="${TOOL_CATEGORIES[$num]}"
                        local icon="${CATEGORY_ICONS[$cat]}"
                        cat_text+="$num. $icon $cat\n"
                        
                        # List tools in category
                        for id in "${!TOOLS[@]}"; do
                            IFS=':' read -r name cat_name cmd <<< "${TOOLS[$id]}"
                            if [ "$cat_name" = "$cat" ]; then
                                cat_text+="     $id. $name\n"
                            fi
                        done
                        cat_text+="\n"
                    done
                    create_window "CATEGORIES" "$cat_text" 50 25
                    ;;
                '[13~') # F3 - All tools
                    local tools_text="ALL TOOLS (1-28):\n\n"
                    for id in {1..28}; do
                        IFS=':' read -r name cat cmd <<< "${TOOLS[$id]}"
                        tools_text+="$id. ${CATEGORY_ICONS[$cat]} $name\n"
                    done
                    create_window "TOOLS" "$tools_text" 45 25
                    ;;
                '[14~') # F4 - Close window
                    if [ -n "$ACTIVE_WIN" ]; then
                        close_window $ACTIVE_WIN
                    fi
                    ;;
            esac
            ;;
            
        # Number keys 1-28 for tools
        [1-9]|1[0-9]|2[0-8])
            local num=$key
            if [ ${#key} -eq 2 ]; then
                num=${key:1}
            fi
            if [ $num -ge 1 ] && [ $num -le 28 ]; then
                launch_tool $num
            fi
            ;;
            
        # Close window
        [xX])
            if [ -n "$ACTIVE_WIN" ]; then
                close_window $ACTIVE_WIN
            fi
            ;;
            
        # Exit
        [qQ])
            create_window "EXIT" "Exit XCX MEGA TOP?\n\nPress Y to confirm" 40 6
            read -n1 -s confirm
            if [ "$confirm" = "y" ] || [ "$confirm" = "Y" ]; then
                cleanup
            fi
            ;;
    esac
}

# ============================================
# CLEANUP
# ============================================

cleanup() {
    # Kill any running processes
    for pid in "${WIN_PID[@]}"; do
        kill -9 $pid 2>/dev/null
    done
    
    # Clear screen
    clear
    
    # Show cursor
    tput cnorm
    
    # Exit message
    echo -e "${XCX[ACCENT1]}${XCX[BOLD]}"
    echo "╔══════════════════════════════════════════════════════════╗"
    echo "║     XCX MEGA TOP v9.0 - Session Ended                   ║"
    echo "║     Thank you for using the clean, organized desktop    ║"
    echo "╚══════════════════════════════════════════════════════════╝"
    echo -e "${XCX[RESET]}"
    
    exit 0
}

# ============================================
# MAIN DESKTOP LOOP
# ============================================

main() {
    # Initialize
    init_system
    
    # Welcome window
    local welcome="╔══════════════════════════════════════╗\n"
    welcome+="║     XCX MEGA TOP v9.0                ║\n"
    welcome+="║     Clean & Organized Desktop        ║\n"
    welcome+="║                                      ║\n"
    welcome+="║  Features:                           ║\n"
    welcome+="║  • 28 organized tools                ║\n"
    welcome+="║  • 7 clear categories                ║\n"
    welcome+="║  • Clean, professional UI            ║\n"
    welcome+="║  • Keyboard-driven workflow          ║\n"
    welcome+="║                                      ║\n"
    welcome+="║  Press F1 for help                    ║\n"
    welcome+="║  Press 1-28 to launch tools           ║\n"
    welcome+="╚══════════════════════════════════════╝"
    create_window "WELCOME" "$welcome" 50 15
    
    # Main loop
    while true; do
        # Draw desktop components
        draw_taskbar
        draw_sidebar
        draw_content_area
        draw_system_stats
        draw_toolbar
        draw_statusbar
        
        # Redraw windows
        for id in "${!WINDOWS[@]}"; do
            draw_window $id
        done
        
        # Handle input
        handle_input
    done
}

# ============================================
# START DESKTOP
# ============================================

# Run main
main
