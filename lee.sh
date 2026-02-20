#!/usr/bin/env bash

# ============================================
# XCX MEGA TOP - INDEPENDENT DESKTOP ENVIRONMENT
# Version: 8.0.0 (Self-Contained)
# Codename: Cyber Sanctuary
# ============================================

# ============================================
# COLOR SCHEME - ULTRA HD
# ============================================

declare -A XCX=(
    # Base Colors
    [BLACK]="\033[0;30m"
    [RED]="\033[0;31m"
    [GREEN]="\033[0;32m"
    [YELLOW]="\033[0;33m"
    [BLUE]="\033[0;34m"
    [MAGENTA]="\033[0;35m"
    [CYAN]="\033[0;36m"
    [WHITE]="\033[0;37m"
    
    # Styles
    [BOLD]="\033[1m"
    [DIM]="\033[2m"
    [ITALIC]="\033[3m"
    [UNDERLINE]="\033[4m"
    [BLINK]="\033[5m"
    [REVERSE]="\033[7m"
    [HIDDEN]="\033[8m"
    [RESET]="\033[0m"
    
    # Neon Colors
    [NEON_GREEN]="\033[38;5;46m"
    [NEON_RED]="\033[38;5;196m"
    [NEON_BLUE]="\033[38;5;33m"
    [NEON_YELLOW]="\033[38;5;226m"
    [NEON_PURPLE]="\033[38;5;129m"
    [NEON_CYAN]="\033[38;5;51m"
    [NEON_PINK]="\033[38;5;213m"
    [NEON_ORANGE]="\033[38;5;214m"
    [NEON_LIME]="\033[38;5;154m"
    [NEON_TEAL]="\033[38;5;49m"
    [NEON_VIOLET]="\033[38;5;135m"
    [NEON_ROSE]="\033[38;5;211m"
    [NEON_GOLD]="\033[38;5;220m"
    [NEON_SILVER]="\033[38;5;251m"
    
    # Backgrounds
    [BG_BLACK]="\033[48;5;0m"
    [BG_DARK]="\033[48;5;16m"
    [BG_DARKER]="\033[48;5;232m"
    [BG_DARKEST]="\033[48;5;234m"
    [BG_RED]="\033[48;5;160m"
    [BG_GREEN]="\033[48;5;46m"
    [BG_BLUE]="\033[48;5;21m"
    [BG_PURPLE]="\033[48;5;93m"
    [BG_CYAN]="\033[48;5;44m"
    [BG_ORANGE]="\033[48;5;208m"
    
    # Special
    [MATRIX_GREEN]="\033[38;5;82m"
    [BLOOD_RED]="\033[38;5;124m"
    [OCEAN_BLUE]="\033[38;5;27m"
    [LAVENDER]="\033[38;5;183m"
    [PEACH]="\033[38;5;216m"
    [MINT]="\033[38;5;121m"
    [CORAL]="\033[38;5;203m"
    [AQUA]="\033[38;5;86m"
)

# ============================================
# XCX HOME - COMPLETE ISOLATION
# ============================================

# Base directory (everything self-contained)
XCX_HOME="$HOME/.xcx-mega-v8"

# Complete isolated structure
declare -A XCX_PATHS=(
    [ROOT]="$XCX_HOME"
    [CACHE]="$XCX_HOME/cache"
    [STORAGE]="$XCX_HOME/storage"
    [APPS]="$XCX_HOME/apps"
    [BIN]="$XCX_HOME/bin"
    [LIB]="$XCX_HOME/lib"
    [ETC]="$XCX_HOME/etc"
    [TMP]="$XCX_HOME/tmp"
    [LOG]="$XCX_HOME/log"
    [DATA]="$XCX_HOME/data"
    [CONFIG]="$XCX_HOME/config"
    [THEMES]="$XCX_HOME/themes"
    [ICONS]="$XCX_HOME/icons"
    [WALLPAPERS]="$XCX_HOME/wallpapers"
    [WINDOWS]="$XCX_HOME/windows"
    [USERS]="$XCX_HOME/users"
    [NETWORK]="$XCX_HOME/network"
    [SECURITY]="$XCX_HOME/security"
    [PLUGINS]="$XCX_HOME/plugins"
    [BACKUP]="$XCX_HOME/backup"
    [WORKSPACE]="$XCX_HOME/workspace"
    [PROJECTS]="$XCX_HOME/projects"
    [DOWNLOADS]="$XCX_HOME/downloads"
    [DOCUMENTS]="$XCX_HOME/documents"
    [MUSIC]="$XCX_HOME/music"
    [VIDEOS]="$XCX_HOME/videos"
    [PICTURES]="$XCX_HOME/pictures"
)

# Create all directories
create_xcx_structure() {
    for path in "${XCX_PATHS[@]}"; do
        mkdir -p "$path"
    done
    
    # Create sub-storage volumes
    for i in {1..10}; do
        mkdir -p "${XCX_PATHS[STORAGE]}/volume-$i"/{data,cache,temp,projects}
    done
    
    # Create user profiles
    mkdir -p "${XCX_PATHS[USERS]}/guest"/{desktop,documents,downloads}
    mkdir -p "${XCX_PATHS[USERS]}/admin"/{desktop,documents,downloads}
    mkdir -p "${XCX_PATHS[USERS]}/hacker"/{desktop,documents,downloads}
    
    # Create network profiles
    mkdir -p "${XCX_PATHS[NETWORK]}/profiles"/{anonymous,normal,stealth}
    
    # Create security keys
    mkdir -p "${XCX_PATHS[SECURITY]}/keys"/{public,private,encrypted}
}

# ============================================
# TERMINAL DIMENSIONS
# ============================================

ROWS=$(tput lines)
COLS=$(tput cols)

# Desktop regions
TASKBAR_H=2
MENU_W=35
MONITOR_W=45
STORAGE_W=35
START_Y=$((TASKBAR_H + 1))

# ============================================
# WINDOW MANAGEMENT SYSTEM
# ============================================

declare -A WINDOWS
declare -A WIN_TITLE
declare -A WIN_PID
declare -A WIN_X WIN_Y WIN_W WIN_H
declare -A WIN_TYPE
declare -A WIN_COLOR
declare -A WIN_CONTENT
declare -A WIN_BUFFER
declare -A WIN_CACHE
declare -A WIN_HISTORY

NEXT_WIN_ID=1000
ACTIVE_WIN=""
WINDOW_FOCUS=true
WINDOW_ANIMATION=true

# ============================================
# XCX DESKTOP STATE
# ============================================

XCX_MODE="NORMAL"  # NORMAL, STEALTH, ANON, GAMING
XCX_THEME="DARK"   # DARK, LIGHT, NEON, MATRIX
XCX_VOLUME=75      # System volume (visual only)
XCX_BRIGHTNESS=100 # Screen brightness (visual only)
XCX_NETWORK="ONLINE"
XCX_BATTERY=85     # Fake battery
XCX_CPU=0
XCX_MEM=0
XCX_DISK=0
XCX_UPTIME=0

# Fake processes
declare -A PROCESSES
for i in {1..20}; do
    PROCESSES[$i]="systemd:$((RANDOM % 100 + 50))"
done

# ============================================
# ANIMATED STARTUP - EPIC XCX SHOW
# ============================================

show_xcx_startup() {
    clear
    tput civis
    
    # Get terminal center
    local center_row=$((ROWS / 2))
    local center_col=$((COLS / 2))
    
    # Phase 1: Matrix rain entrance
    for i in {1..100}; do
        local rand_row=$((RANDOM % ROWS))
        local rand_col=$((RANDOM % COLS))
        tput cup $rand_row $rand_col
        echo -ne "${XCX[MATRIX_GREEN]}$(printf '%x' $((RANDOM % 16)))${XCX[RESET]}"
        usleep 5000
    done
    
    # Phase 2: XCX Logo build-up with particles
    local logo=(
        "    ██╗  ██╗ ██████╗██╗  ██╗    ███╗   ███╗███████╗ ██████╗  █████╗ "
        "    ╚██╗██╔╝██╔════╝██║  ██║    ████╗ ████║██╔════╝██╔════╝ ██╔══██╗"
        "     ╚███╔╝ ██║     ███████║    ██╔████╔██║█████╗  ██║  ███╗███████║"
        "     ██╔██╗ ██║     ██╔══██║    ██║╚██╔╝██║██╔══╝  ██║   ██║██╔══██║"
        "    ██╔╝ ██╗╚██████╗██║  ██║    ██║ ╚═╝ ██║███████╗╚██████╔╝██║  ██║"
        "    ╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝    ╚═╝     ╚═╝╚══════╝ ╚═════╝ ╚═╝  ╚═╝"
    )
    
    local version="══════════════════════════════════════════════════════════════════"
    local version2="           XCX MEGA TOP v8.0 - INDEPENDENT DESKTOP"
    local version3="         Where Style Meets Function - Everything Cached Locally"
    
    # Animated logo appearance
    local logo_y=$((center_row - 8))
    local logo_x=$((center_col - 38))
    
    for phase in {1..3}; do
        clear
        for color in "${XCX[NEON_RED]}" "${XCX[NEON_GREEN]}" "${XCX[NEON_BLUE]}" "${XCX[NEON_PURPLE]}" "${XCX[NEON_CYAN]}" "${XCX[NEON_PINK]}"; do
            tput cup $logo_y $logo_x
            for line in "${logo[@]}"; do
                echo -e "${color}${XCX[BOLD]}$line${XCX[RESET]}"
                tput cup $((++logo_y)) $logo_x
            done
            
            # Reset logo_y
            logo_y=$((center_row - 8))
            
            # Show version with glow
            tput cup $((logo_y + 7)) $((center_col - 35))
            echo -e "${XCX[NEON_SILVER]}${XCX[BOLD]}$version${XCX[RESET]}"
            tput cup $((logo_y + 8)) $((center_col - 35))
            echo -e "${XCX[NEON_GOLD]}${XCX[BOLD]}$version2${XCX[RESET]}"
            tput cup $((logo_y + 9)) $((center_col - 35))
            echo -e "${XCX[NEON_SILVER]}${XCX[BOLD]}$version3${XCX[RESET]}"
            
            usleep 100000
        done
    done
    
    # Phase 3: Loading animation with progress
    local steps=(
        "[    ] Initializing XCX Kernel..."
        "[█   ] Loading Desktop Environment..."
        "[██  ] Mounting Storage Volumes..."
        "[███ ] Caching Applications..."
        "[████] Starting Window Manager..."
        "[█████] System Ready!"
    )
    
    for i in "${!steps[@]}"; do
        clear
        # Redraw logo
        tput cup $logo_y $logo_x
        for line in "${logo[@]}"; do
            echo -e "${XCX[NEON_CYAN]}${XCX[BOLD]}$line${XCX[RESET]}"
            tput cup $((++logo_y)) $logo_x
        done
        logo_y=$((center_row - 8))
        
        # Show version
        tput cup $((logo_y + 7)) $((center_col - 35))
        echo -e "${XCX[NEON_SILVER]}$version${XCX[RESET]}"
        tput cup $((logo_y + 8)) $((center_col - 35))
        echo -e "${XCX[NEON_GOLD]}$version2${XCX[RESET]}"
        tput cup $((logo_y + 9)) $((center_col - 35))
        echo -e "${XCX[NEON_SILVER]}$version3${XCX[RESET]}"
        
        # Show progress
        tput cup $((logo_y + 12)) $((center_col - 20))
        echo -e "${XCX[NEON_GREEN]}${steps[$i]}${XCX[RESET]}"
        
        # Fake loading details
        case $i in
            0) tput cup $((logo_y + 13)) $((center_col - 20))
               echo -e "${XCX[NEON_CYAN]}   • Loading modules: $(printf '%02d' $((RANDOM % 100)))%" ;;
            1) tput cup $((logo_y + 13)) $((center_col - 20))
               echo -e "${XCX[NEON_CYAN]}   • Desktop effects: ENABLED" ;;
            2) tput cup $((logo_y + 13)) $((center_col - 20))
               echo -e "${XCX[NEON_CYAN]}   • Volume 1: $(du -sh ${XCX_PATHS[STORAGE]}/volume-1 2>/dev/null | cut -f1)" ;;
            3) tput cup $((logo_y + 13)) $((center_col - 20))
               echo -e "${XCX[NEON_CYAN]}   • Caching: $((RANDOM % 500 + 100)) MB" ;;
            4) tput cup $((logo_y + 13)) $((center_col - 20))
               echo -e "${XCX[NEON_CYAN]}   • Windows: 0 active" ;;
            5) tput cup $((logo_y + 13)) $((center_col - 20))
               echo -e "${XCX[NEON_GREEN]}   • Welcome to XCX MEGA TOP!" ;;
        esac
        
        sleep 0.5
    done
    
    # Final flash
    for i in {1..3}; do
        clear
        sleep 0.1
        tput cup $logo_y $logo_x
        for line in "${logo[@]}"; do
            echo -e "${XCX[WHITE]}${XCX[BOLD]}$line${XCX[RESET]}"
            tput cup $((++logo_y)) $logo_x
        done
        logo_y=$((center_row - 8))
        sleep 0.1
    done
    
    sleep 0.5
    clear
}

# ============================================
# WALLPAPER ENGINE
# ============================================

draw_wallpaper() {
    local theme="${XCX_THEME:-DARK}"
    
    case "$theme" in
        "DARK")
            # Gradient dark background
            for ((i=0; i<ROWS; i++)); do
                local color=$((232 + (i * 23 / ROWS)))
                tput cup $i 0
                echo -ne "\033[48;5;${color}m"
                printf "%${COLS}s" " "
            done
            ;;
        "NEON")
            # Neon grid background
            for ((i=0; i<ROWS; i++)); do
                tput cup $i 0
                if ((i % 4 == 0)); then
                    echo -ne "${XCX[BG_DARKER]}"
                    for ((j=0; j<COLS; j++)); do
                        if ((j % 10 == 0)); then
                            echo -ne "${XCX[NEON_CYAN]}+${XCX[RESET]}"
                        else
                            echo -ne " "
                        fi
                    done
                else
                    echo -ne "${XCX[BG_BLACK]}"
                    printf "%${COLS}s" " "
                fi
            done
            ;;
        "MATRIX")
            # Matrix code rain background
            for ((i=0; i<ROWS; i++)); do
                tput cup $i 0
                echo -ne "${XCX[BG_BLACK]}"
                for ((j=0; j<COLS; j++)); do
                    if ((RANDOM % 50 == 0)); then
                        echo -ne "${XCX[MATRIX_GREEN]}$(printf '%x' $((RANDOM % 16)))${XCX[RESET]}"
                    else
                        echo -ne " "
                    fi
                done
            done
            ;;
    esac
}

# ============================================
# TASKBAR WITH LIVE METRICS
# ============================================

draw_taskbar() {
    # Update system metrics
    update_metrics
    
    # Top bar gradient
    tput cup 0 0
    echo -ne "${XCX[BG_DARKER]}${XCX[NEON_CYAN]}${XCX[BOLD]}"
    printf "╔%-$((COLS-2))s╗" ""
    
    # Taskbar content
    tput cup 1 0
    echo -ne "${XCX[BG_DARKER]}${XCX[NEON_CYAN]}${XCX[BOLD]}"
    
    # Left section - Logo and mode
    printf "║ ${XCX[NEON_GREEN]}XCX${XCX[NEON_CYAN]} │ "
    
    # Mode indicator with color
    case "$XCX_MODE" in
        "NORMAL") echo -ne "${XCX[NEON_BLUE]}NORMAL${XCX[NEON_CYAN]}" ;;
        "STEALTH") echo -ne "${XCX[NEON_PURPLE]}STEALTH${XCX[NEON_CYAN]}" ;;
        "ANON") echo -ne "${XCX[NEON_RED]}ANON${XCX[NEON_CYAN]}" ;;
        "GAMING") echo -ne "${XCX[NEON_GREEN]}GAMING${XCX[NEON_CYAN]}" ;;
    esac
    
    echo -ne " │ "
    
    # Window count
    echo -ne "${XCX[NEON_YELLOW]}WIN:${#WINDOWS[@]}${XCX[NEON_CYAN]} │ "
    
    # CPU meter
    echo -ne "${XCX[NEON_RED]}CPU:${XCX[WHITE]}$XCX_CPU% ${XCX[NEON_CYAN]}│ "
    
    # MEM meter
    echo -ne "${XCX[NEON_GREEN]}MEM:${XCX[WHITE]}$XCX_MEM% ${XCX[NEON_CYAN]}│ "
    
    # Network status
    if [ "$XCX_NETWORK" = "ONLINE" ]; then
        echo -ne "${XCX[NEON_GREEN]}NET:⬆️⬇️ ${XCX[NEON_CYAN]}│ "
    else
        echo -ne "${XCX[NEON_RED]}NET:⛔ ${XCX[NEON_CYAN]}│ "
    fi
    
    # Battery
    echo -ne "${XCX[NEON_YELLOW]}BAT:${XCX[WHITE]}$XCX_BATTERY% ${XCX[NEON_CYAN]}│ "
    
    # Volume
    echo -ne "${XCX[NEON_PURPLE]}VOL:${XCX[WHITE]}$XCX_VOLUME% ${XCX[NEON_CYAN]}│ "
    
    # Time
    local datetime=$(date "+%H:%M:%S %Y-%m-%d")
    echo -ne "${XCX[WHITE]}$datetime"
    
    # Right padding
    printf " %-$((COLS-80))s ║" ""
    
    echo -e "${XCX[RESET]}"
}

update_metrics() {
    # Fake but realistic metrics
    XCX_CPU=$((RANDOM % 30 + 10 + (${#WINDOWS[@]} * 5)))
    XCX_MEM=$((RANDOM % 40 + 20 + (${#WINDOWS[@]} * 3)))
    XCX_DISK=$((RANDOM % 60 + 30))
    XCX_UPTIME=$(( $(date +%s) - XCX_START_TIME ))
    XCX_BATTERY=$((XCX_BATTERY - 1))
    [ $XCX_BATTERY -lt 10 ] && XCX_BATTERY=85
}

# ============================================
# MAIN MENU - STYLISH APP LAUNCHER
# ============================================

draw_main_menu() {
    local y=3
    local x=2
    local width=$MENU_W
    
    # Menu header with gradient
    tput cup $y $x
    echo -e "${XCX[NEON_PURPLE]}${XCX[BOLD]}╔══════════════════════════════════╗${XCX[RESET]}"
    tput cup $((y+1)) $x
    echo -e "${XCX[NEON_PURPLE]}${XCX[BOLD]}║     🚀 XCX LAUNCHPAD             ║${XCX[RESET]}"
    tput cup $((y+2)) $x
    echo -e "${XCX[NEON_PURPLE]}${XCX[BOLD]}╠══════════════════════════════════╣${XCX[RESET]}"
    
    # Application categories
    local categories=(
        "📁 SYSTEM TOOLS"
        "🔍 SECURITY SCANNERS"
        "🔑 CRACKING SUITE"
        "🌐 NETWORK TOOLS"
        "🕵️ ANONYMITY KIT"
        "💾 STORAGE MANAGER"
        "🎮 ENTERTAINMENT"
        "⚙️ CONFIGURATION"
    )
    
    local cat_y=$((y+3))
    for cat in "${categories[@]}"; do
        tput cup $cat_y $((x+2))
        echo -e "${XCX[NEON_CYAN]}${XCX[BOLD]}$cat${XCX[RESET]}"
        
        # Sub-items per category
        case "$cat" in
            "📁 SYSTEM TOOLS")
                tput cup $((cat_y+1)) $((x+4))
                echo -e "${XCX[NEON_GREEN]}1.${XCX[WHITE]} Terminal Emulator"
                tput cup $((cat_y+2)) $((x+4))
                echo -e "${XCX[NEON_GREEN]}2.${XCX[WHITE]} File Manager"
                tput cup $((cat_y+3)) $((x+4))
                echo -e "${XCX[NEON_GREEN]}3.${XCX[WHITE]} Process Monitor"
                cat_y=$((cat_y+4))
                ;;
            "🔍 SECURITY SCANNERS")
                tput cup $((cat_y+1)) $((x+4))
                echo -e "${XCX[NEON_GREEN]}4.${XCX[WHITE]} Port Scanner"
                tput cup $((cat_y+2)) $((x+4))
                echo -e "${XCX[NEON_GREEN]}5.${XCX[WHITE]} Vulnerability Scanner"
                tput cup $((cat_y+3)) $((x+4))
                echo -e "${XCX[NEON_GREEN]}6.${XCX[WHITE]} Network Mapper"
                cat_y=$((cat_y+4))
                ;;
            "🔑 CRACKING SUITE")
                tput cup $((cat_y+1)) $((x+4))
                echo -e "${XCX[NEON_GREEN]}7.${XCX[WHITE]} Password Cracker"
                tput cup $((cat_y+2)) $((x+4))
                echo -e "${XCX[NEON_GREEN]}8.${XCX[WHITE]} Hash Generator"
                tput cup $((cat_y+3)) $((x+4))
                echo -e "${XCX[NEON_GREEN]}9.${XCX[WHITE]} Brute Force Tool"
                cat_y=$((cat_y+4))
                ;;
            "🌐 NETWORK TOOLS")
                tput cup $((cat_y+1)) $((x+4))
                echo -e "${XCX[NEON_GREEN]}10.${XCX[WHITE]} Packet Sniffer"
                tput cup $((cat_y+2)) $((x+4))
                echo -e "${XCX[NEON_GREEN]}11.${XCX[WHITE]} DNS Analyzer"
                tput cup $((cat_y+3)) $((x+4))
                echo -e "${XCX[NEON_GREEN]}12.${XCX[WHITE]} Traffic Monitor"
                cat_y=$((cat_y+4))
                ;;
            "🕵️ ANONYMITY KIT")
                tput cup $((cat_y+1)) $((x+4))
                echo -e "${XCX[NEON_GREEN]}13.${XCX[WHITE]} MAC Changer"
                tput cup $((cat_y+2)) $((x+4))
                echo -e "${XCX[NEON_GREEN]}14.${XCX[WHITE]} Proxy Chain"
                tput cup $((cat_y+3)) $((x+4))
                echo -e "${XCX[NEON_GREEN]}15.${XCX[WHITE]} Identity Spoofer"
                cat_y=$((cat_y+4))
                ;;
            "💾 STORAGE MANAGER")
                tput cup $((cat_y+1)) $((x+4))
                echo -e "${XCX[NEON_GREEN]}16.${XCX[WHITE]} Volume Manager"
                tput cup $((cat_y+2)) $((x+4))
                echo -e "${XCX[NEON_GREEN]}17.${XCX[WHITE]} File Encryptor"
                tput cup $((cat_y+3)) $((x+4))
                echo -e "${XCX[NEON_GREEN]}18.${XCX[WHITE]} Data Wiper"
                cat_y=$((cat_y+4))
                ;;
            "🎮 ENTERTAINMENT")
                tput cup $((cat_y+1)) $((x+4))
                echo -e "${XCX[NEON_GREEN]}19.${XCX[WHITE]} Media Player"
                tput cup $((cat_y+2)) $((x+4))
                echo -e "${XCX[NEON_GREEN]}20.${XCX[WHITE]} Terminal Games"
                tput cup $((cat_y+3)) $((x+4))
                echo -e "${XCX[NEON_GREEN]}21.${XCX[WHITE]} Music Visualizer"
                cat_y=$((cat_y+4))
                ;;
            "⚙️ CONFIGURATION")
                tput cup $((cat_y+1)) $((x+4))
                echo -e "${XCX[NEON_GREEN]}22.${XCX[WHITE]} Desktop Settings"
                tput cup $((cat_y+2)) $((x+4))
                echo -e "${XCX[NEON_GREEN]}23.${XCX[WHITE]} Theme Manager"
                tput cup $((cat_y+3)) $((x+4))
                echo -e "${XCX[NEON_GREEN]}24.${XCX[WHITE]} System Info"
                cat_y=$((cat_y+4))
                ;;
        esac
    done
    
    # Menu footer
    tput cup $((cat_y+1)) $x
    echo -e "${XCX[NEON_PURPLE]}${XCX[BOLD]}╚══════════════════════════════════╝${XCX[RESET]}"
}

# ============================================
# SYSTEM MONITOR - LIVE GAUGES
# ============================================

draw_system_monitor() {
    local y=3
    local x=$((COLS - MONITOR_W - STORAGE_W - 5))
    local width=$MONITOR_W
    
    tput cup $y $x
    echo -e "${XCX[NEON_BLUE]}${XCX[BOLD]}╔══════════════════════════════════════╗${XCX[RESET]}"
    tput cup $((y+1)) $x
    echo -e "${XCX[NEON_BLUE]}${XCX[BOLD]}║        📊 SYSTEM MONITOR            ║${XCX[RESET]}"
    tput cup $((y+2)) $x
    echo -e "${XCX[NEON_BLUE]}${XCX[BOLD]}╠══════════════════════════════════════╣${XCX[RESET]}"
    
    # CPU Gauge
    tput cup $((y+3)) $((x+1))
    echo -e "${XCX[NEON_RED]}CPU:${XCX[WHITE]} $XCX_CPU%"
    tput cup $((y+4)) $((x+1))
    echo -ne "${XCX[NEON_RED]}${XCX[BOLD]}[${XCX[RESET]}"
    local cpu_bars=$((XCX_CPU * 30 / 100))
    for ((i=0; i<30; i++)); do
        if [ $i -lt $cpu_bars ]; then
            echo -ne "${XCX[NEON_RED]}█${XCX[RESET]}"
        else
            echo -ne "${XCX[BG_DARK]} ${XCX[RESET]}"
        fi
    done
    echo -e "${XCX[NEON_RED]}${XCX[BOLD]}]${XCX[RESET]}"
    
    # Memory Gauge
    tput cup $((y+5)) $((x+1))
    echo -e "${XCX[NEON_GREEN]}MEM:${XCX[WHITE]} $XCX_MEM%"
    tput cup $((y+6)) $((x+1))
    echo -ne "${XCX[NEON_GREEN]}${XCX[BOLD]}[${XCX[RESET]}"
    local mem_bars=$((XCX_MEM * 30 / 100))
    for ((i=0; i<30; i++)); do
        if [ $i -lt $mem_bars ]; then
            echo -ne "${XCX[NEON_GREEN]}█${XCX[RESET]}"
        else
            echo -ne "${XCX[BG_DARK]} ${XCX[RESET]}"
        fi
    done
    echo -e "${XCX[NEON_GREEN]}${XCX[BOLD]}]${XCX[RESET]}"
    
    # Disk Gauge
    tput cup $((y+7)) $((x+1))
    echo -e "${XCX[NEON_YELLOW]}DISK:${XCX[WHITE]} $XCX_DISK%"
    tput cup $((y+8)) $((x+1))
    echo -ne "${XCX[NEON_YELLOW]}${XCX[BOLD]}[${XCX[RESET]}"
    local disk_bars=$((XCX_DISK * 30 / 100))
    for ((i=0; i<30; i++)); do
        if [ $i -lt $disk_bars ]; then
            echo -ne "${XCX[NEON_YELLOW]}█${XCX[RESET]}"
        else
            echo -ne "${XCX[BG_DARK]} ${XCX[RESET]}"
        fi
    done
    echo -e "${XCX[NEON_YELLOW]}${XCX[BOLD]}]${XCX[RESET]}"
    
    # Network Activity
    tput cup $((y+9)) $((x+1))
    echo -e "${XCX[NEON_CYAN]}NETWORK:${XCX[WHITE]}"
    tput cup $((y+10)) $((x+3))
    echo -e "${XCX[NEON_GREEN]}⬆️ UP: $((RANDOM % 1000 + 100)) KB/s"
    tput cup $((y+11)) $((x+3))
    echo -e "${XCX[NEON_RED]}⬇️ DOWN: $((RANDOM % 2000 + 200)) KB/s"
    
    # Top Processes
    tput cup $((y+12)) $((x+1))
    echo -e "${XCX[NEON_PURPLE]}TOP PROCESSES:${XCX[WHITE]}"
    local line=13
    for i in {1..5}; do
        local pid=$((1000 + i))
        local cpu=$((RANDOM % 20 + 1))
        local mem=$((RANDOM % 15 + 1))
        local name="process_$i"
        tput cup $((y+line)) $((x+3))
        echo -e "${XCX[NEON_CYAN]}$pid${XCX[WHITE]} ${name:0:10} ${XCX[NEON_RED]}CPU:${cpu}%${XCX[WHITE]} ${XCX[NEON_GREEN]}MEM:${mem}%${XCX[RESET]}"
        ((line++))
    done
    
    tput cup $((y+19)) $x
    echo -e "${XCX[NEON_BLUE]}${XCX[BOLD]}╚══════════════════════════════════════╝${XCX[RESET]}"
}

# ============================================
# STORAGE VISUALIZER
# ============================================

draw_storage_info() {
    local y=3
    local x=$((COLS - STORAGE_W - 2))
    local width=$STORAGE_W
    
    tput cup $y $x
    echo -e "${XCX[NEON_GOLD]}${XCX[BOLD]}╔══════════════════════════════════╗${XCX[RESET]}"
    tput cup $((y+1)) $x
    echo -e "${XCX[NEON_GOLD]}${XCX[BOLD]}║        💾 XCX STORAGE            ║${XCX[RESET]}"
    tput cup $((y+2)) $x
    echo -e "${XCX[NEON_GOLD]}${XCX[BOLD]}╠══════════════════════════════════╣${XCX[RESET]}"
    
    # Volume information
    local line=3
    for vol in {1..5}; do
        local vol_path="${XCX_PATHS[STORAGE]}/volume-$vol"
        local vol_size=$(du -sh "$vol_path" 2>/dev/null | cut -f1)
        [ -z "$vol_size" ] && vol_size="0K"
        
        local vol_usage=$((RANDOM % 100))
        local vol_color="${XCX[NEON_GREEN]}"
        [ $vol_usage -gt 70 ] && vol_color="${XCX[NEON_RED]}"
        [ $vol_usage -gt 40 ] && [ $vol_usage -le 70 ] && vol_color="${XCX[NEON_YELLOW]}"
        
        tput cup $((y+line)) $((x+1))
        echo -e "${XCX[NEON_CYAN]}VOL $vol:${XCX[WHITE]} $vol_size"
        
        tput cup $((y+line+1)) $((x+2))
        echo -ne "${vol_color}["
        local bars=$((vol_usage * 20 / 100))
        for ((i=0; i<20; i++)); do
            if [ $i -lt $bars ]; then
                echo -ne "█"
            else
                echo -ne "░"
            fi
        done
        echo -e "] $vol_usage%${XCX[RESET]}"
        
        ((line+=3))
    done
    
    # Total storage
    local total_size=$(du -sh "${XCX_PATHS[STORAGE]}" 2>/dev/null | cut -f1)
    tput cup $((y+18)) $((x+1))
    echo -e "${XCX[NEON_PURPLE]}TOTAL:${XCX[WHITE]} $total_size"
    
    # Cache info
    local cache_size=$(du -sh "${XCX_PATHS[CACHE]}" 2>/dev/null | cut -f1)
    tput cup $((y+19)) $((x+1))
    echo -e "${XCX[NEON_ORANGE]}CACHE:${XCX[WHITE]} $cache_size"
    
    tput cup $((y+20)) $x
    echo -e "${XCX[NEON_GOLD]}${XCX[BOLD]}╚══════════════════════════════════╝${XCX[RESET]}"
}

# ============================================
# NETWORK VISUALIZER
# ============================================

draw_network_graph() {
    local y=$((ROWS - 15))
    local x=$((COLS - MONITOR_W - STORAGE_W - 5))
    local width=$MONITOR_W
    
    tput cup $y $x
    echo -e "${XCX[NEON_CYAN]}${XCX[BOLD]}╔══════════════════════════════════════╗${XCX[RESET]}"
    tput cup $((y+1)) $x
    echo -e "${XCX[NEON_CYAN]}${XCX[BOLD]}║        🌐 NETWORK ACTIVITY          ║${XCX[RESET]}"
    tput cup $((y+2)) $x
    echo -e "${XCX[NEON_CYAN]}${XCX[BOLD]}╠══════════════════════════════════════╣${XCX[RESET]}"
    
    # Live network graph
    local graph_data=()
    for i in {1..10}; do
        graph_data[$i]=$((RANDOM % 10 + 1))
    done
    
    for row in {1..10}; do
        tput cup $((y+2+row)) $((x+1))
        for col in {1..30}; do
            if [ $((RANDOM % 10)) -lt ${graph_data[$(( (col % 10) + 1 ))]} ]; then
                echo -ne "${XCX[NEON_GREEN]}█${XCX[RESET]}"
            else
                echo -ne "${XCX[BG_DARK]} ${XCX[RESET]}"
            fi
        done
    done
    
    # Connection stats
    tput cup $((y+13)) $((x+1))
    echo -e "${XCX[NEON_PURPLE]}ACTIVE CONNECTIONS:${XCX[WHITE]} $((RANDOM % 50 + 10))"
    tput cup $((y+14)) $((x+1))
    echo -e "${XCX[NEON_YELLOW]}BANDWIDTH:${XCX[WHITE]} $((RANDOM % 100 + 50)) Mbps"
    
    tput cup $((y+15)) $x
    echo -e "${XCX[NEON_CYAN]}${XCX[BOLD]}╚══════════════════════════════════════╝${XCX[RESET]}"
}

# ============================================
# QUICK ACCESS BAR
# ============================================

draw_quick_access() {
    local y=$((ROWS - 4))
    local x=2
    local width=$MENU_W
    
    tput cup $y $x
    echo -e "${XCX[NEON_GREEN]}${XCX[BOLD]}╔══════════════════════════════════╗${XCX[RESET]}"
    tput cup $((y+1)) $x
    echo -e "${XCX[NEON_GREEN]}${XCX[BOLD]}║     ⚡ QUICK ACCESS BAR          ║${XCX[RESET]}"
    tput cup $((y+2)) $x
    echo -e "${XCX[NEON_GREEN]}${XCX[BOLD]}╠══════════════════════════════════╣${XCX[RESET]}"
    
    tput cup $((y+3)) $((x+2))
    echo -e "${XCX[NEON_CYAN]}[F1]${XCX[WHITE]} Help  ${XCX[NEON_CYAN]}[F2]${XCX[WHITE]} Tools  ${XCX[NEON_CYAN]}[F3]${XCX[WHITE]} Storage  ${XCX[NEON_CYAN]}[F4]${XCX[WHITE]} Close  ${XCX[NEON_RED]}[Q]${XCX[WHITE]} Exit${XCX[RESET]}"
    
    tput cup $((y+4)) $x
    echo -e "${XCX[NEON_GREEN]}${XCX[BOLD]}╚══════════════════════════════════╝${XCX[RESET]}"
}

# ============================================
# WINDOW MANAGEMENT
# ============================================

create_window() {
    local title="$1"
    local content="$2"
    local w=${3:-60}
    local h=${4:-15}
    local type="${5:-normal}"
    local id=$((NEXT_WIN_ID++))
    
    # Center window
    local x=$(( (COLS - w) / 2 ))
    local y=$(( (ROWS - h) / 2 ))
    
    # Store window data
    WINDOWS[$id]="$x $y $w $h"
    WIN_TITLE[$id]="$title"
    WIN_X[$id]=$x
    WIN_Y[$id]=$y
    WIN_W[$id]=$w
    WIN_H[$id]=$h
    WIN_TYPE[$id]="$type"
    WIN_CONTENT[$id]="$content"
    
    # Choose color based on type
    case "$type" in
        "normal") WIN_COLOR[$id]="${XCX[NEON_CYAN]}" ;;
        "tool") WIN_COLOR[$id]="${XCX[NEON_GREEN]}" ;;
        "error") WIN_COLOR[$id]="${XCX[NEON_RED]}" ;;
        "success") WIN_COLOR[$id]="${XCX[NEON_PURPLE]}" ;;
        "terminal") WIN_COLOR[$id]="${XCX[NEON_BLUE]}" ;;
        *) WIN_COLOR[$id]="${XCX[NEON_CYAN]}" ;;
    esac
    
    # Draw window
    draw_window $id
    
    # Animate window opening
    if [ "$WINDOW_ANIMATION" = true ]; then
        animate_window_open $id
    fi
    
    ACTIVE_WIN=$id
    return $id
}

draw_window() {
    local id=$1
    local x=${WIN_X[$id]} y=${WIN_Y[$id]} w=${WIN_W[$id]} h=${WIN_H[$id]}
    local title="${WIN_TITLE[$id]}"
    local color="${WIN_COLOR[$id]}"
    
    # Top border with title
    tput cup $y $x
    echo -ne "${color}${XCX[BOLD]}┌"
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
    echo -ne "${XCX[NEON_RED]}✗${XCX[RESET]}"
    
    # Side borders
    for ((i=1; i<h-1; i++)); do
        tput cup $((y + i)) $x
        echo -ne "${color}│${XCX[RESET]}"
        tput cup $((y + i)) $((x + w - 1))
        echo -ne "${color}│${XCX[RESET]}"
    done
    
    # Bottom border
    tput cup $((y + h - 1)) $x
    echo -ne "${color}└"
    for ((i=1; i<w-1; i++)); do
        echo -ne "─"
    done
    echo -ne "┘${XCX[RESET]}"
    
    # Fill content area
    local content_y=$((y + 1))
    local content_x=$((x + 1))
    
    IFS=$'\n' read -d '' -ra lines <<< "${WIN_CONTENT[$id]}"
    local line_num=0
    for line in "${lines[@]}"; do
        if [ $line_num -lt $((h - 2)) ]; then
            tput cup $((content_y + line_num)) $content_x
            echo -ne "${XCX[WHITE]}${line:0:$((w-2))}${XCX[RESET]}"
            ((line_num++))
        fi
    done
}

animate_window_open() {
    local id=$1
    local x=${WIN_X[$id]} y=${WIN_Y[$id]} w=${WIN_W[$id]} h=${WIN_H[$id]}
    
    for i in {1..5}; do
        # Shrink effect
        local new_w=$((w * (6-i) / 5))
        local new_h=$((h * (6-i) / 5))
        local new_x=$((x + (w - new_w) / 2))
        local new_y=$((y + (h - new_h) / 2))
        
        # Clear area
        for ((dy=0; dy<h; dy++)); do
            tput cup $((y + dy)) $x
            printf "%${w}s" " "
        done
        
        # Draw smaller window
        tput cup $new_y $new_x
        echo -ne "${WIN_COLOR[$id]}${XCX[BOLD]}┌"
        for ((j=1; j<new_w-1; j++)); do echo -ne "─"; done
        echo -ne "┐${XCX[RESET]}"
        
        for ((j=1; j<new_h-1; j++)); do
            tput cup $((new_y + j)) $new_x
            echo -ne "${WIN_COLOR[$id]}│${XCX[RESET]}"
            tput cup $((new_y + j)) $((new_x + new_w - 1))
            echo -ne "${WIN_COLOR[$id]}│${XCX[RESET]}"
        done
        
        tput cup $((new_y + new_h - 1)) $new_x
        echo -ne "${WIN_COLOR[$id]}└"
        for ((j=1; j<new_w-1; j++)); do echo -ne "─"; done
        echo -ne "┘${XCX[RESET]}"
        
        usleep 50000
    done
    
    # Draw final window
    draw_window $id
}

close_window() {
    local id=$1
    
    # Animate closing
    if [ "$WINDOW_ANIMATION" = true ]; then
        local x=${WIN_X[$id]} y=${WIN_Y[$id]} w=${WIN_W[$id]} h=${WIN_H[$id]}
        
        for i in {1..5}; do
            local new_w=$((w * i / 5))
            local new_h=$((h * i / 5))
            local new_x=$((x + (w - new_w) / 2))
            local new_y=$((y + (h - new_h) / 2))
            
            # Clear area
            for ((dy=0; dy<h; dy++)); do
                tput cup $((y + dy)) $x
                printf "%${w}s" " "
            done
            
            # Draw smaller window
            if [ $new_w -gt 2 ] && [ $new_h -gt 2 ]; then
                tput cup $new_y $new_x
                echo -ne "${WIN_COLOR[$id]}${XCX[BOLD]}┌"
                for ((j=1; j<new_w-1; j++)); do echo -ne "─"; done
                echo -ne "┐${XCX[RESET]}"
                
                for ((j=1; j<new_h-1; j++)); do
                    tput cup $((new_y + j)) $new_x
                    echo -ne "${WIN_COLOR[$id]}│${XCX[RESET]}"
                    tput cup $((new_y + j)) $((new_x + new_w - 1))
                    echo -ne "${WIN_COLOR[$id]}│${XCX[RESET]}"
                done
                
                tput cup $((new_y + new_h - 1)) $new_x
                echo -ne "${WIN_COLOR[$id]}└"
                for ((j=1; j<new_w-1; j++)); do echo -ne "─"; done
                echo -ne "┘${XCX[RESET]}"
            fi
            
            usleep 50000
        done
    fi
    
    # Clear window area
    local x=${WIN_X[$id]} y=${WIN_Y[$id]} w=${WIN_W[$id]} h=${WIN_H[$id]}
    for ((dy=0; dy<h; dy++)); do
        tput cup $((y + dy)) $x
        printf "%${w}s" " "
    done
    
    # Remove from arrays
    unset WINDOWS[$id] WIN_TITLE[$id] WIN_PID[$id]
    unset WIN_X[$id] WIN_Y[$id] WIN_W[$id] WIN_H[$id]
    unset WIN_TYPE[$id] WIN_COLOR[$id] WIN_CONTENT[$id]
    
    if [ "$ACTIVE_WIN" = "$id" ]; then
        ACTIVE_WIN=""
    fi
}

# ============================================
# APPLICATION FACTORY - CACHED TOOLS
# ============================================

create_cached_tools() {
    echo -e "${XCX[NEON_CYAN]}[*] Creating cached tools...${XCX[RESET]}"
    
    # Terminal App
    cat > "${XCX_PATHS[APPS]}/terminal.sh" << 'EOF'
#!/usr/bin/env bash
echo "XCX Terminal v8.0"
echo "Type 'help' for commands"
echo ""
while true; do
    echo -n "xcx@terminal:~$ "
    read cmd
    case $cmd in
        "help")
            echo "Available commands:"
            echo "  help     - Show this help"
            echo "  clear    - Clear screen"
            echo "  date     - Show date/time"
            echo "  whoami   - Show user"
            echo "  pwd      - Show directory"
            echo "  ls       - List files"
            echo "  exit     - Close terminal"
            ;;
        "clear") clear ;;
        "date") date ;;
        "whoami") echo "xcx-user" ;;
        "pwd") echo "/home/xcx" ;;
        "ls") echo "Desktop  Documents  Downloads  Music  Pictures  Videos" ;;
        "exit") break ;;
        *) echo "Command not found: $cmd" ;;
    esac
done
EOF

    # Port Scanner
    cat > "${XCX_PATHS[APPS]}/portscanner.sh" << 'EOF'
#!/usr/bin/env bash
echo "XCX Port Scanner v1.0"
echo "====================="
echo ""
echo "Scanning common ports on localhost..."
for port in 22 80 443 3306 8080; do
    echo -n "Port $port: "
    if nc -z localhost $port 2>/dev/null; then
        echo -e "\033[0;32mOPEN\033[0m"
    else
        echo -e "\033[0;31mCLOSED\033[0m"
    fi
    sleep 0.5
done
EOF

    # Password Cracker
    cat > "${XCX_PATHS[APPS]}/cracker.sh" << 'EOF'
#!/usr/bin/env bash
echo "XCX Password Cracker v1.0"
echo "========================"
echo ""
echo "Hash: 5f4dcc3b5aa765d61d8327deb882cf99"
echo "Attempting to crack MD5 hash..."
echo ""
sleep 1
echo "[*] Trying dictionary attack..."
sleep 1
echo "[*] Found: password123"
EOF

    # Make all apps executable
    chmod +x "${XCX_PATHS[APPS]}"/*
    
    # Create bin symlinks
    for app in "${XCX_PATHS[APPS]}"/*; do
        local name=$(basename "$app" .sh)
        ln -sf "$app" "${XCX_PATHS[BIN]}/$name" 2>/dev/null
    done
    
    echo -e "${XCX[NEON_GREEN]}[✓] Tools cached successfully${XCX[RESET]}"
    sleep 1
}

# ============================================
# THEME ENGINE
# ============================================

load_theme() {
    local theme="${1:-DARK}"
    XCX_THEME="$theme"
    
    case "$theme" in
        "DARK")
            XCX[BG]="${XCX[BG_DARK]}"
            XCX[FG]="${XCX[WHITE]}"
            XCX[ACCENT]="${XCX[NEON_CYAN]}"
            ;;
        "NEON")
            XCX[BG]="${XCX[BG_BLACK]}"
            XCX[FG]="${XCX[NEON_GREEN]}"
            XCX[ACCENT]="${XCX[NEON_PINK]}"
            ;;
        "MATRIX")
            XCX[BG]="${XCX[BG_BLACK]}"
            XCX[FG]="${XCX[MATRIX_GREEN]}"
            XCX[ACCENT]="${XCX[NEON_GREEN]}"
            ;;
    esac
}

# ============================================
# KEYBOARD HANDLER
# ============================================

handle_keyboard() {
    read -n1 -s key
    
    case "$key" in
        $'\x1b') # ESC sequences
            read -n2 -s rest
            case "$rest" in
                '[A'|'[B'|'[C'|'[D') ;; # Arrow keys
                '[11~') # F1 - Help
                    create_window "XCX HELP" "XCX MEGA TOP v8.0 HELP\n\nKEYBOARD SHORTCUTS:\n\nF1  - This help window\nF2  - Tool manager\nF3  - Storage viewer\nF4  - Close active window\nQ   - Quick exit\n\nAPP NUMBERS:\n1-24 - Launch applications\n\nTIPS:\n• Everything is cached locally\n• No internet required\n• 10 storage volumes\n• Multiple themes available" 60 22 "success"
                    ;;
                '[12~') # F2 - Tools
                    local tool_list=""
                    for tool in "${XCX_PATHS[APPS]}"/*; do
                        tool_list+="• $(basename "$tool" .sh)\n"
                    done
                    create_window "TOOLS" "INSTALLED TOOLS:\n\n$tool_list" 50 20 "tool"
                    ;;
                '[13~') # F3 - Storage
                    local storage_info=""
                    for vol in {1..5}; do
                        local size=$(du -sh "${XCX_PATHS[STORAGE]}/volume-$vol" 2>/dev/null | cut -f1)
                        storage_info+="Volume $vol: ${size:-empty}\n"
                    done
                    create_window "STORAGE" "STORAGE VOLUMES:\n\n$storage_info\nCache: $(du -sh ${XCX_PATHS[CACHE]} | cut -f1)" 45 15 "normal"
                    ;;
                '[14~') # F4 - Close window
                    if [ -n "$ACTIVE_WIN" ]; then
                        close_window $ACTIVE_WIN
                        ACTIVE_WIN=""
                    fi
                    ;;
            esac
            ;;
            
        # Number keys 1-24 for apps
        [1-9]|1[0-9]|2[0-4])
            case "$key" in
                1) create_window "Terminal" "$(cat ${XCX_PATHS[APPS]}/terminal.sh 2>/dev/null || echo 'Terminal app not found')" 70 20 "terminal" ;;
                2) create_window "File Manager" "XCX FILE MANAGER\n\nDocuments: 24 files\nDownloads: 12 files\nMusic: 8 files\nPictures: 15 files\nVideos: 3 files" 60 15 "normal" ;;
                3) create_window "Process Monitor" "$(top -bn1 | head -20)" 70 20 "tool" ;;
                4) create_window "Port Scanner" "$(bash ${XCX_PATHS[APPS]}/portscanner.sh 2>/dev/null || echo 'Scanner not available')" 60 15 "tool" ;;
                5) create_window "Vuln Scanner" "XCX Vulnerability Scanner\n\nScanning local system...\n\n[✓] No critical vulnerabilities found\n[!] 3 low-severity issues detected\n[✓] System is secure" 60 15 "tool" ;;
                6) create_window "Network Mapper" "Network Map:\n\n192.168.1.1 (router)\n192.168.1.2 (this device)\n192.168.1.3 (unknown)\n192.168.1.4 (printer)" 50 12 "tool" ;;
                7) create_window "Password Cracker" "$(bash ${XCX_PATHS[APPS]}/cracker.sh 2>/dev/null || echo 'Cracker not available')" 60 15 "tool" ;;
                8) create_window "Hash Tool" "Hash Generator:\n\nInput: 'hello'\nMD5: 5d41402abc4b2a76b9719d911017c592\nSHA1: aaf4c61ddcc5e8a2dabede0f3b482cd9aea9434d" 60 12 "tool" ;;
                9) create_window "Brute Force" "Brute Force Tool\n\nTarget: localhost\nService: SSH\nWordlist: rockyou.txt\n\n[•] Trying passwords...\n[•] 245 attempts so far" 60 12 "tool" ;;
                10) create_window "Packet Sniffer" "Packet Capture:\n\nInterfaces:\n• eth0 (active)\n• wlan0 (active)\n• lo (active)\n\nCapturing 127 packets..." 55 15 "tool" ;;
                11) create_window "DNS Analyzer" "DNS Lookup:\n\ngoogle.com → 142.250.185.46\ngithub.com → 140.82.112.3\nstackoverflow.com → 151.101.1.69" 50 12 "tool" ;;
                12) create_window "Traffic Monitor" "$(netstat -an | head -20)" 70 20 "tool" ;;
                13) create_window "MAC Changer" "Current MAC: 00:1A:2B:3C:4D:5E\nNew MAC: 00:1A:2B:3C:4D:5F\n\n[✓] MAC changed successfully" 50 10 "tool" ;;
                14) create_window "Proxy Chain" "Proxy Configuration:\n\nProxy 1: 127.0.0.1:9050 (Tor)\nProxy 2: 127.0.0.1:8118 (Privoxy)\nProxy 3: 127.0.0.1:1080 (SOCKS)\n\nStatus: Chain active" 55 12 "tool" ;;
                15) create_window "Identity Spoofer" "Identity Information:\n\nIP: 203.0.113.42\nCountry: Netherlands\nBrowser: Firefox\nOS: Linux\nMAC: Spoofed\n\n[✓] Anonymity active" 50 14 "tool" ;;
                16) create_window "Volume Manager" "$(df -h | head -10)" 70 15 "normal" ;;
                17) create_window "File Encryptor" "AES-256 Encryption\n\nFile: secret.txt\nStatus: Encrypted\nKey: stored in keyring\n\n[✓] Encryption complete" 55 12 "tool" ;;
                18) create_window "Data Wiper" "Secure Deletion Tool\n\nWiping: /tmp/files\nMethod: DoD 5220.22-M\nPasses: 7\n\n[•] Pass 3/7 complete" 55 12 "tool" ;;
                19) create_window "Media Player" "XCX Media Player\n\nNow Playing: ambient_loop.mp3\nVolume: 75%\nDuration: 3:42\n\n⏯️ ⏸️ ⏹️ ⏮️ ⏭️" 50 12 "normal" ;;
                20) create_window "Terminal Games" "Available Games:\n\n1. Snake\n2. Tetris\n3. Pong\n4. Space Invaders\n\nSelect game (1-4): _" 45 12 "normal" ;;
                21) create_window "Music Visualizer" "🎵 Visualizer Active 🎵\n\n▰▰▰▰▰▰▰▰▰▰ 100Hz\n▰▰▰▰▰▰▰▰▰▰ 200Hz\n▰▰▰▰▰▰▰▰▰▰ 400Hz\n▰▰▰▰▰▰▰▰▰▰ 800Hz\n▰▰▰▰▰▰▰▰▰▰ 1.6kHz" 50 12 "normal" ;;
                22) create_window "Desktop Settings" "Current Settings:\n\nTheme: $XCX_THEME\nMode: $XCX_MODE\nVolume: $XCX_VOLUME%\nBrightness: $XCX_BRIGHTNESS%\n\nPress T to change theme" 50 12 "normal" ;;
                23) create_window "Theme Manager" "Available Themes:\n\n1. Dark (current)\n2. Neon\n3. Matrix\n4. Light\n5. Cyberpunk\n\nPress number to change" 45 12 "normal" ;;
                24) create_window "System Info" "XCX MEGA TOP v8.0\n\nUptime: $(printf '%02d:%02d:%02d' $((XCX_UPTIME/3600)) $((XCX_UPTIME%3600/60)) $((XCX_UPTIME%60)))\nCPU: $XCX_CPU%\nMemory: $XCX_MEM%\nDisk: $XCX_DISK%\nWindows: ${#WINDOWS[@]}\nStorage: $(du -sh ${XCX_PATHS[STORAGE]} | cut -f1)\nCache: $(du -sh ${XCX_PATHS[CACHE]} | cut -f1)" 50 15 "normal" ;;
            esac
            ;;
            
        # Theme switching
        [tT]) 
            case "$XCX_THEME" in
                "DARK") load_theme "NEON" ;;
                "NEON") load_theme "MATRIX" ;;
                "MATRIX") load_theme "DARK" ;;
            esac
            create_window "Theme Changed" "Theme switched to: $XCX_THEME" 40 5 "success"
            ;;
            
        # Mode switching
        [mM])
            case "$XCX_MODE" in
                "NORMAL") XCX_MODE="STEALTH" ;;
                "STEALTH") XCX_MODE="ANON" ;;
                "ANON") XCX_MODE="GAMING" ;;
                "GAMING") XCX_MODE="NORMAL" ;;
            esac
            create_window "Mode Changed" "Mode switched to: $XCX_MODE" 40 5 "success"
            ;;
            
        # Close window
        [xX])
            if [ -n "$ACTIVE_WIN" ]; then
                close_window $ACTIVE_WIN
                ACTIVE_WIN=""
            fi
            ;;
            
        # Emergency exit
        [qQ])
            create_window "Exit Confirmation" "Are you sure you want to exit?\n\nPress Y to confirm" 40 6 "error"
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
    # Kill all processes
    for pid in "${WIN_PID[@]}"; do
        kill -9 $pid 2>/dev/null
    done
    
    # Clear screen
    clear
    
    # Show cursor
    tput cnorm
    
    # Exit message
    echo -e "${XCX[NEON_GREEN]}${XCX[BOLD]}"
    echo "╔══════════════════════════════════════════════════════════╗"
    echo "║     Thank you for using XCX MEGA TOP v8.0               ║"
    echo "║     All your data is safely cached in:                  ║"
    echo "║     $XCX_HOME"
    echo "╚══════════════════════════════════════════════════════════╝"
    echo -e "${XCX[RESET]}"
    
    exit 0
}

# ============================================
# MAIN DESKTOP LOOP
# ============================================

main() {
    # Initialize
    create_xcx_structure
    create_cached_tools
    
    # Set start time
    XCX_START_TIME=$(date +%s)
    
    # Load default theme
    load_theme "DARK"
    
    # Show startup animation
    show_xcx_startup
    
    # Hide cursor
    tput civis
    
    # Main loop
    while true; do
        # Draw desktop
        draw_wallpaper
        draw_taskbar
        draw_main_menu
        draw_system_monitor
        draw_storage_info
        draw_network_graph
        draw_quick_access
        
        # Redraw all windows
        for id in "${!WINDOWS[@]}"; do
            draw_window $id
        done
        
        # Handle input
        handle_keyboard
    done
}

# ============================================
# START THE DESKTOP
# ============================================

# Trap for cleanup
trap cleanup SIGINT SIGTERM

# Run main
main
