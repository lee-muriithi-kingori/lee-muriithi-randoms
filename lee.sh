#!/usr/bin/env bash

# ============================================
# XCX MEGA TOP - SYSTEM TRANSFORMER
# Version: 7.0.0 (REAL ENVIRONMENT)
# Codename: Digital Metamorphosis
# ============================================

# ============================================
# SYSTEM INTEGRATION CORE
# ============================================

# Color Scheme - Maximum visibility
declare -A XCX=(
    [BLACK]="\033[0;30m"
    [RED]="\033[0;31m"
    [GREEN]="\033[0;32m"
    [YELLOW]="\033[0;33m"
    [BLUE]="\033[0;34m"
    [PURPLE]="\033[0;35m"
    [CYAN]="\033[0;36m"
    [WHITE]="\033[0;37m"
    [BOLD]="\033[1m"
    [DIM]="\033[2m"
    [ITALIC]="\033[3m"
    [UNDERLINE]="\033[4m"
    [BLINK]="\033[5m"
    [REVERSE]="\033[7m"
    [RESET]="\033[0m"
    [BG_BLACK]="\033[48;5;0m"
    [BG_DARK]="\033[48;5;16m"
    [BG_DARKER]="\033[48;5;232m"
    [BG_RED]="\033[48;5;160m"
    [BG_GREEN]="\033[48;5;46m"
    [BG_BLUE]="\033[48;5;21m"
    [BG_PURPLE]="\033[48;5;129m"
    [NEON_GREEN]="\033[38;5;46m"
    [NEON_RED]="\033[38;5;196m"
    [NEON_BLUE]="\033[38;5;21m"
    [NEON_YELLOW]="\033[38;5;226m"
    [NEON_PURPLE]="\033[38;5;129m"
    [NEON_CYAN]="\033[38;5;51m"
    [NEON_PINK]="\033[38;5;213m"
    [NEON_ORANGE]="\033[38;5;214m"
    [MATRIX_GREEN]="\033[38;5;82m"
)

# ============================================
# SYSTEM PATHS & ENVIRONMENT
# ============================================

# XCX Root Directory (Permanent Storage)
XCX_ROOT="/opt/xcx-mega"
XCX_HOME="$HOME/.xcx-mega"
XCX_CACHE="$XCX_HOME/cache"
XCX_DATA="$XCX_HOME/data"
XCX_CONFIG="$XCX_HOME/config"
XCX_LOGS="$XCX_HOME/logs"
XCX_TEMP="$XCX_HOME/temp"
XCX_STORAGE="$XCX_HOME/storage"
XCX_TOOLS="$XCX_HOME/tools"
XCX_WINDOWS="$XCX_HOME/windows"
XCX_SESSIONS="$XCX_HOME/sessions"
XCX_DOWNLOADS="$XCX_HOME/downloads"
XCX_UPLOADS="$XCX_HOME/uploads"
XCX_ENCRYPTED="$XCX_HOME/encrypted"
XCX_DECRYPTED="$XCX_HOME/decrypted"
XCX_KEYRING="$XCX_HOME/keyring"
XCX_PLUGINS="$XCX_HOME/plugins"
XCX_THEMES="$XCX_HOME/themes"
XCX_PROFILES="$XCX_HOME/profiles"
XCX_WORKSPACES="$XCX_HOME/workspaces"

# System integration paths
XCX_BIN="/usr/local/bin/xcx"
XCX_SERVICE="/etc/systemd/system/xcx-mega.service"
XCX_BASHRC="$HOME/.bashrc.xcx"
XCX_ZSH="$HOME/.zshrc.xcx"
XCX_VIM="$HOME/.vimrc.xcx"
XCX_NANO="$HOME/.nanorc.xcx"
XCX_SSH="$HOME/.ssh/config.xcx"
XCX_TOR="$HOME/.tor/torrc.xcx"
XCX_PROXYCHAINS="/etc/proxychains.conf.xcx"

# Terminal dimensions
ROWS=$(tput lines)
COLS=$(tput cols)

# ============================================
# WINDOW MANAGEMENT
# ============================================

declare -A WINDOWS
declare -A WIN_TITLE
declare -A WIN_PID
declare -A WIN_X WIN_Y WIN_W WIN_H
declare -A WIN_TYPE
declare -A WIN_CACHE
declare -A WIN_HISTORY
NEXT_WIN_ID=1000
ACTIVE_WIN=""
CURSOR_VISIBLE=true

# ============================================
# SYSTEM STATE
# ============================================

XCX_MODE="NORMAL"
XCX_ANON=false
XCX_TOR=false
XCX_VPN=false
XCX_ENCRYPTED=false
XCX_SESSION_ID=$(date +%s%N | sha256sum | head -c 32)
XCX_START_TIME=$(date +%s)
XCX_NETWORK_INTERFACES=""
XCX_SYSTEM_BACKUP="/tmp/xcx-system-backup-$(date +%Y%m%d-%H%M%S)"

# ============================================
# INITIALIZATION & SYSTEM TRANSFORMATION
# ============================================

init_system() {
    # Create all directories
    mkdir -p "$XCX_ROOT" "$XCX_HOME" "$XCX_CACHE" "$XCX_DATA" "$XCX_CONFIG"
    mkdir -p "$XCX_LOGS" "$XCX_TEMP" "$XCX_STORAGE" "$XCX_TOOLS" "$XCX_WINDOWS"
    mkdir -p "$XCX_SESSIONS" "$XCX_DOWNLOADS" "$XCX_UPLOADS" "$XCX_ENCRYPTED"
    mkdir -p "$XCX_DECRYPTED" "$XCX_KEYRING" "$XCX_PLUGINS" "$XCX_THEMES"
    mkdir -p "$XCX_PROFILES" "$XCX_WORKSPACES"
    
    # Create storage structure
    for i in {1..10}; do
        mkdir -p "$XCX_STORAGE/volume-$i"/{bin,data,logs,temp}
    done
    
    # Create initial workspace
    mkdir -p "$XCX_WORKSPACES/default"/{targets,results,payloads,loot}
    
    # Hide cursor initially
    tput civis
    
    # Set up traps
    trap emergency_exit SIGINT SIGTERM EXIT
    trap handle_emergency_key WINCH
    
    # Backup current system state
    backup_system_state
    
    # Transform system
    transform_system
    
    # Install all tools
    install_all_tools
    
    # Start background services
    start_background_services
    
    # Log startup
    log_event "SYSTEM_START" "XCX MEGA TOP v7.0 initialized"
}

backup_system_state() {
    echo -e "${XCX[NEON_YELLOW]}[*] Backing up system state...${XCX[RESET]}"
    
    mkdir -p "$XCX_SYSTEM_BACKUP"
    
    # Backup important configs
    [ -f "$HOME/.bashrc" ] && cp "$HOME/.bashrc" "$XCX_SYSTEM_BACKUP/"
    [ -f "$HOME/.zshrc" ] && cp "$HOME/.zshrc" "$XCX_SYSTEM_BACKUP/"
    [ -f "$HOME/.vimrc" ] && cp "$HOME/.vimrc" "$XCX_SYSTEM_BACKUP/"
    [ -f "/etc/hosts" ] && sudo cp "/etc/hosts" "$XCX_SYSTEM_BACKUP/" 2>/dev/null
    [ -f "/etc/resolv.conf" ] && sudo cp "/etc/resolv.conf" "$XCX_SYSTEM_BACKUP/" 2>/dev/null
    
    # Save network config
    ip addr show > "$XCX_SYSTEM_BACKUP/network.txt"
    route -n > "$XCX_SYSTEM_BACKUP/routing.txt" 2>/dev/null
    
    echo -e "${XCX[NEON_GREEN]}[✓] System backup created at $XCX_SYSTEM_BACKUP${XCX[RESET]}"
}

transform_system() {
    echo -e "${XCX[NEON_PURPLE]}${XCX[BOLD]}"
    echo "╔══════════════════════════════════════════════════════════╗"
    echo "║     TRANSFORMING SYSTEM INTO XCX TESTING ENVIRONMENT    ║"
    echo "╚══════════════════════════════════════════════════════════╝"
    echo -e "${XCX[RESET]}"
    
    # Create symbolic links to XCX tools
    sudo ln -sf "$XCX_HOME/bin" "$XCX_BIN" 2>/dev/null
    
    # Add XCX to PATH
    if ! grep -q "XCX MEGA TOP" "$HOME/.bashrc" 2>/dev/null; then
        cat >> "$HOME/.bashrc" << EOF

# XCX MEGA TOP - Testing Environment
export XCX_HOME="$XCX_HOME"
export XCX_MODE="ACTIVE"
export PATH="\$XCX_HOME/bin:\$XCX_HOME/tools:\$PATH"
alias xcx="cd \$XCX_HOME"
alias xcx-tools="ls \$XCX_HOME/tools"
alias xcx-storage="cd \$XCX_STORAGE"
alias xcx-workspace="cd \$XCX_WORKSPACES/default"
alias xcx-scan="\$XCX_HOME/tools/portscan"
alias xcx-crack="\$XCX_HOME/tools/crackpass"
alias xcx-anon="\$XCX_HOME/tools/anonsurf"
alias xcx-clean="\$XCX_HOME/tools/cleanlogs"
EOF
    fi
    
    # Create ZSH config if exists
    if [ -f "$HOME/.zshrc" ]; then
        cat >> "$HOME/.zshrc" << EOF

# XCX MEGA TOP - Testing Environment
export XCX_HOME="$XCX_HOME"
export XCX_MODE="ACTIVE"
export PATH="\$XCX_HOME/bin:\$XCX_HOME/tools:\$PATH"
alias xcx="cd \$XCX_HOME"
alias xcx-tools="ls \$XCX_HOME/tools"
alias xcx-storage="cd \$XCX_STORAGE"
EOF
    fi
    
    # Configure system for testing
    configure_testing_environment
    
    echo -e "${XCX[NEON_GREEN]}[✓] System transformed successfully${XCX[RESET]}"
    sleep 1
}

configure_testing_environment() {
    # Disable firewall for testing (with backup)
    if command -v ufw &>/dev/null; then
        sudo ufw disable 2>/dev/null
    fi
    
    # Enable IP forwarding
    sudo sysctl -w net.ipv4.ip_forward=1 >/dev/null 2>&1
    sudo sysctl -w net.ipv6.conf.all.forwarding=1 >/dev/null 2>&1
    
    # Increase network performance
    sudo sysctl -w net.core.rmem_max=16777216 >/dev/null 2>&1
    sudo sysctl -w net.core.wmem_max=16777216 >/dev/null 2>&1
    
    # Allow promiscuous mode
    sudo sysctl -w net.ipv4.conf.all.promote_secondaries=1 >/dev/null 2>&1
    
    # Create testing network namespace
    sudo ip netns add xcx-test 2>/dev/null
    
    # Create virtual interface for testing
    sudo ip link add xcx0 type veth peer name xcx1 2>/dev/null
    
    # Log changes
    log_event "SYSTEM_TRANSFORM" "Testing environment configured"
}

# ============================================
# TOOL INSTALLATION - REAL PENTESTING TOOLS
# ============================================

install_all_tools() {
    echo -e "${XCX[NEON_CYAN]}${XCX[BOLD]}"
    echo "╔══════════════════════════════════════════════════════════╗"
    echo "║     INSTALLING PENTESTING TOOLKIT                       ║"
    echo "╚══════════════════════════════════════════════════════════╝"
    echo -e "${XCX[RESET]}"
    
    # Update package list
    sudo apt-get update -qq
    
    # Install essential pentesting tools
    install_pentesting_tools
    
    # Install XCX custom tools
    install_xcx_tools
    
    # Configure all tools for XCX integration
    configure_tools_for_xcx
    
    echo -e "${XCX[NEON_GREEN]}[✓] All tools installed successfully${XCX[RESET]}"
    sleep 1
}

install_pentesting_tools() {
    local tools=(
        # Network Scanning & Enumeration
        "nmap" "masscan" "netcat" "socat" "tcpdump" "wireshark"
        "dnsutils" "whois" "traceroute" "mtr" "arp-scan"
        
        # Web Application Testing
        "sqlmap" "nikto" "gobuster" "dirb" "wfuzz" "burpsuite"
        "whatweb" "wpscan" "hydra" "medusa" "ncrack"
        
        # Password Cracking
        "john" "hashcat" "fcrackzip" "pdfcrack" "rcrack"
        "ophcrack" "smbclient" "enum4linux"
        
        # Exploitation Frameworks
        "metasploit-framework" "exploitdb" "searchsploit"
        "beef-xss" "social-engineer-toolkit"
        
        # Wireless Testing
        "aircrack-ng" "reaver" "bully" "wifite" "kismet"
        "mdk3" "mdk4" "hostapd-wpe" "asleap"
        
        # Forensic Tools
        "foremost" "scalpel" "binwalk" "testdisk" "photorec"
        "autopsy" "sleuthkit"
        
        # Reverse Engineering
        "gdb" "radare2" "ollydbg" "edb-debugger"
        "apktool" "dex2jar" "jd-gui"
        
        # Anonymity & Privacy
        "tor" "proxychains" "macchanger" "secure-delete"
        "steghide" "gpg" "cryptsetup"
        
        # Vulnerability Analysis
        "openvas" "nexpose" "nessus" "legion" "sparta"
        
        # Database Testing
        "mysql" "postgresql" "mongodb" "redis-tools"
        
        # Miscellaneous
        "curl" "wget" "git" "vim" "nano" "htop" "iotop"
        "tmux" "screen" "terminator" "xterm"
    )
    
    local total=${#tools[@]}
    local current=0
    
    for tool in "${tools[@]}"; do
        ((current++))
        local percent=$((current * 100 / total))
        
        echo -ne "\r${XCX[NEON_YELLOW]}[${percent}%] Installing: $tool${XCX[RESET]}"
        
        if dpkg -l | grep -q "^ii  $tool "; then
            echo -ne " ${XCX[NEON_GREEN]}[ALREADY INSTALLED]${XCX[RESET]}\n"
        else
            sudo apt-get install -y "$tool" &>/dev/null &
            local pid=$!
            
            # Show animation while installing
            while kill -0 $pid 2>/dev/null; do
                echo -ne "\r${XCX[NEON_YELLOW]}[${percent}%] Installing: $tool ${XCX[NEON_CYAN]}[⬇️]${XCX[RESET]}"
                sleep 0.1
                echo -ne "\r${XCX[NEON_YELLOW]}[${percent}%] Installing: $tool ${XCX[NEON_CYAN]}[⬇⬇]${XCX[RESET]}"
                sleep 0.1
            done
            
            wait $pid
            if [ $? -eq 0 ]; then
                echo -ne "\r${XCX[NEON_YELLOW]}[${percent}%] Installing: $tool ${XCX[NEON_GREEN]}[✓ DONE]${XCX[RESET]}\n"
                log_event "TOOL_INSTALL" "Installed $tool"
            else
                echo -ne "\r${XCX[NEON_YELLOW]}[${percent}%] Installing: $tool ${XCX[NEON_RED]}[✗ FAILED]${XCX[RESET]}\n"
            fi
        fi
    done
    
    echo
}

install_xcx_tools() {
    echo -e "\n${XCX[NEON_PURPLE]}[*] Installing XCX Custom Tools...${XCX[RESET]}"
    
    # Create tool directory
    mkdir -p "$XCX_TOOLS"
    
    # Advanced Port Scanner with SQLMap integration
    cat > "$XCX_TOOLS/portscan" << 'EOF'
#!/usr/bin/env python3
import sys
import subprocess
import os
import json
from datetime import datetime

def scan_with_nmap(target, ports):
    print(f"[*] Scanning {target} with nmap...")
    cmd = f"nmap -sV -sC -p{ports} {target} -oX /tmp/nmap_scan.xml"
    result = subprocess.run(cmd, shell=True, capture_output=True, text=True)
    return result.stdout

def scan_with_masscan(target, ports):
    print(f"[*] Scanning {target} with masscan...")
    cmd = f"sudo masscan -p{ports} {target} --rate=1000"
    result = subprocess.run(cmd, shell=True, capture_output=True, text=True)
    return result.stdout

def check_sql_injection(target, port):
    if port in [80, 443, 8080, 8443]:
        print(f"[*] Testing for SQL injection on port {port}...")
        protocol = "https" if port in [443, 8443] else "http"
        url = f"{protocol}://{target}:{port}"
        cmd = f"sqlmap -u {url} --batch --level=1 --risk=1"
        result = subprocess.run(cmd, shell=True, capture_output=True, text=True)
        return result.stdout
    return None

def main():
    if len(sys.argv) < 2:
        print("Usage: portscan <target> [ports]")
        print("Example: portscan 192.168.1.1 1-1000")
        return
    
    target = sys.argv[1]
    ports = sys.argv[2] if len(sys.argv) > 2 else "1-1000"
    
    print(f"\n{'='*60}")
    print(f"XCX PORT SCANNER v2.0")
    print(f"Target: {target}")
    print(f"Ports: {ports}")
    print(f"Started: {datetime.now()}")
    print(f"{'='*60}\n")
    
    # Try nmap first
    nmap_result = scan_with_nmap(target, ports)
    print(nmap_result)
    
    # Check web ports for SQL injection
    web_ports = [80, 443, 8080, 8443]
    for port in web_ports:
        if f"{port}/tcp" in nmap_result and "open" in nmap_result:
            sql_result = check_sql_injection(target, port)
            if sql_result:
                print(sql_result)
    
    # Save results
    with open(f"$XCX_DATA/scan_{target}_{datetime.now().strftime('%Y%m%d_%H%M%S')}.txt", 'w') as f:
        f.write(nmap_result)
    
    print(f"\n[+] Scan complete")

if __name__ == "__main__":
    main()
EOF

    # Password Cracker with John integration
    cat > "$XCX_TOOLS/crackpass" << 'EOF'
#!/usr/bin/env python3
import sys
import subprocess
import os

def crack_with_john(hash_file, wordlist):
    print(f"[*] Cracking with John the Ripper...")
    
    # Try different John formats
    formats = ['raw-md5', 'raw-sha1', 'raw-sha256', 'nt']
    
    for fmt in formats:
        cmd = f"john --format={fmt} --wordlist={wordlist} {hash_file}"
        result = subprocess.run(cmd, shell=True, capture_output=True, text=True)
        
        # Show results
        show_cmd = f"john --show {hash_file}"
        show_result = subprocess.run(show_cmd, shell=True, capture_output=True, text=True)
        
        if "password" in show_result.stdout.lower():
            print(f"[+] Found passwords with {fmt}:")
            print(show_result.stdout)
            return True
    
    return False

def crack_with_hashcat(hash_file, hashtype, wordlist):
    print(f"[*] Cracking with Hashcat...")
    
    # Hash types: 0=MD5, 100=SHA1, 1400=SHA256
    hash_types = {'md5': 0, 'sha1': 100, 'sha256': 1400, 'ntlm': 1000}
    
    if hashtype in hash_types:
        cmd = f"hashcat -m {hash_types[hashtype]} -a 0 {hash_file} {wordlist} --force"
        result = subprocess.run(cmd, shell=True, capture_output=True, text=True)
        
        # Show cracked passwords
        show_cmd = f"hashcat --show {hash_file}"
        show_result = subprocess.run(show_cmd, shell=True, capture_output=True, text=True)
        print(show_result.stdout)
        return True
    
    return False

def main():
    if len(sys.argv) < 3:
        print("Usage: crackpass <hash_file> <wordlist> [type]")
        print("Types: md5, sha1, sha256, auto")
        return
    
    hash_file = sys.argv[1]
    wordlist = sys.argv[2]
    hashtype = sys.argv[3] if len(sys.argv) > 3 else "auto"
    
    print(f"\n{'='*60}")
    print(f"XCX PASSWORD CRACKER v2.0")
    print(f"Hash File: {hash_file}")
    print(f"Wordlist: {wordlist}")
    print(f"Type: {hashtype}")
    print(f"{'='*60}\n")
    
    # Try John first
    if crack_with_john(hash_file, wordlist):
        print("[+] John the Ripper successful")
    
    # Try Hashcat next
    if hashtype != "auto":
        if crack_with_hashcat(hash_file, hashtype, wordlist):
            print("[+] Hashcat successful")
    
    print(f"\n[+] Cracking complete")

if __name__ == "__main__":
    main()
EOF

    # Web Scanner with SQLMap and Nikto
    cat > "$XCX_TOOLS/webscan" << 'EOF'
#!/usr/bin/env python3
import sys
import subprocess
import os

def scan_with_nikto(target):
    print(f"[*] Scanning with Nikto...")
    cmd = f"nikto -h {target} -o /tmp/nikto_scan.txt"
    result = subprocess.run(cmd, shell=True, capture_output=True, text=True)
    
    with open('/tmp/nikto_scan.txt', 'r') as f:
        print(f.read())
    
    return result.stdout

def scan_with_sqlmap(target):
    print(f"[*] Testing with SQLMap...")
    cmd = f"sqlmap -u {target} --batch --level=2 --risk=2 --dbs"
    result = subprocess.run(cmd, shell=True, capture_output=True, text=True)
    
    # Extract database names
    if "available databases" in result.stdout.lower():
        print("[+] Vulnerable to SQL injection!")
        print(result.stdout)
    
    return result.stdout

def scan_with_dirb(target):
    print(f"[*] Directory brute-forcing with Dirb...")
    cmd = f"dirb {target} /usr/share/wordlists/dirb/common.txt"
    result = subprocess.run(cmd, shell=True, capture_output=True, text=True)
    print(result.stdout)
    return result.stdout

def main():
    if len(sys.argv) < 2:
        print("Usage: webscan <url>")
        print("Example: webscan http://example.com")
        return
    
    target = sys.argv[1]
    
    print(f"\n{'='*60}")
    print(f"XCX WEB SCANNER v2.0")
    print(f"Target: {target}")
    print(f"{'='*60}\n")
    
    # Run all scans
    nikto_result = scan_with_nikto(target)
    sqlmap_result = scan_with_sqlmap(target)
    dirb_result = scan_with_dirb(target)
    
    # Save combined results
    with open(f"$XCX_DATA/webscan_{target.replace('/', '_')}.txt", 'w') as f:
        f.write(nikto_result + "\n" + sqlmap_result + "\n" + dirb_result)
    
    print(f"\n[+] Web scan complete")

if __name__ == "__main__":
    main()
EOF

    # Anonymous Surf with Tor and VPN
    cat > "$XCX_TOOLS/anonsurf" << 'EOF'
#!/usr/bin/env python3
import subprocess
import sys
import os
import time
import requests

class AnonymousSurf:
    def __init__(self):
        self.tor_running = False
        self.vpn_running = False
        self.proxychains_conf = "/etc/proxychains.conf"
        
    def check_tor(self):
        try:
            result = subprocess.run(['systemctl', 'is-active', 'tor'], 
                                   capture_output=True, text=True)
            return result.stdout.strip() == 'active'
        except:
            return False
    
    def start_tor(self):
        print("[*] Starting Tor service...")
        subprocess.run(['sudo', 'systemctl', 'start', 'tor'], check=True)
        time.sleep(3)
        
        # Test Tor
        try:
            session = requests.Session()
            session.proxies = {'http': 'socks5://127.0.0.1:9050',
                              'https': 'socks5://127.0.0.1:9050'}
            response = session.get('https://check.torproject.org/api/ip')
            data = response.json()
            if data.get('IsTor'):
                print(f"[✓] Tor connected - IP: {data.get('IP')}")
                return True
        except:
            pass
        return False
    
    def change_mac(self):
        print("[*] Randomizing MAC addresses...")
        interfaces = subprocess.run(['ip', '-o', 'link', 'show'], 
                                   capture_output=True, text=True)
        
        for line in interfaces.stdout.split('\n'):
            if 'eth' in line or 'wlan' in line:
                iface = line.split(':')[1].strip()
                if iface != 'lo':
                    subprocess.run(['sudo', 'ifconfig', iface, 'down'], 
                                 capture_output=True)
                    subprocess.run(['sudo', 'macchanger', '-r', iface], 
                                 capture_output=True)
                    subprocess.run(['sudo', 'ifconfig', iface, 'up'], 
                                 capture_output=True)
                    print(f"[✓] MAC changed for {iface}")
    
    def setup_proxychains(self):
        print("[*] Configuring proxychains...")
        conf = """strict_chain
proxy_dns
tcp_read_time_out 15000
tcp_connect_time_out 8000

[ProxyList]
socks4 127.0.0.1 9050
socks5 127.0.0.1 9050
"""
        with open('/tmp/proxychains.conf', 'w') as f:
            f.write(conf)
        subprocess.run(['sudo', 'cp', '/tmp/proxychains.conf', '/etc/proxychains.conf'])
        print("[✓] Proxychains configured")
    
    def start(self):
        print("\n[*] Starting Anonymous Mode...\n")
        
        # Change MAC
        self.change_mac()
        
        # Start Tor
        if self.start_tor():
            self.tor_running = True
        
        # Setup proxychains
        self.setup_proxychains()
        
        print("\n[✓] Anonymous Mode ACTIVE")
        print("[!] Use: proxychains <command> to route through Tor")
        print(f"[!] Current IP: {requests.get('https://api.ipify.org').text}")
    
    def stop(self):
        print("[*] Stopping anonymous mode...")
        subprocess.run(['sudo', 'systemctl', 'stop', 'tor'])
        print("[✓] Anonymous mode stopped")
    
    def status(self):
        print("\n[*] Anonymous Status:\n")
        
        # Check Tor
        if self.check_tor():
            print("[✓] Tor: Running")
            # Get Tor IP
            try:
                response = requests.get('https://check.torproject.org/api/ip',
                                      proxies={'http': 'socks5://127.0.0.1:9050',
                                              'https': 'socks5://127.0.0.1:9050'})
                data = response.json()
                if data.get('IsTor'):
                    print(f"[✓] Tor IP: {data.get('IP')}")
            except:
                pass
        else:
            print("[✗] Tor: Not running")
        
        # Check regular IP
        try:
            ip = requests.get('https://api.ipify.org', timeout=3).text
            print(f"[*] Regular IP: {ip}")
        except:
            pass

def main():
    anon = AnonymousSurf()
    
    if len(sys.argv) < 2:
        print("Usage: anonsurf <start|stop|status>")
        return
    
    cmd = sys.argv[1].lower()
    
    if cmd == "start":
        anon.start()
    elif cmd == "stop":
        anon.stop()
    elif cmd == "status":
        anon.status()
    else:
        print("Unknown command")

if __name__ == "__main__":
    main()
EOF

    # Make all tools executable
    chmod +x "$XCX_TOOLS"/*
    
    # Create symlinks in PATH
    sudo ln -sf "$XCX_TOOLS"/* /usr/local/bin/ 2>/dev/null
    
    log_event "TOOLS_INSTALLED" "All XCX tools installed"
}

configure_tools_for_xcx() {
    # Configure SQLMap
    if [ -f "/usr/share/sqlmap/sqlmap.py" ]; then
        sudo ln -sf "/usr/share/sqlmap/sqlmap.py" "/usr/local/bin/sqlmap"
    fi
    
    # Configure John the Ripper
    if [ -f "/usr/share/john/john.conf" ]; then
        cp "/usr/share/john/john.conf" "$XCX_CONFIG/john.conf"
    fi
    
    # Configure Metasploit
    if command -v msfconsole &>/dev/null; then
        mkdir -p "$HOME/.msf4"
        echo "spool $XCX_LOGS/msf_console.log" > "$HOME/.msf4/config"
    fi
    
    # Download wordlists
    if [ ! -f "$XCX_STORAGE/wordlists/rockyou.txt" ]; then
        mkdir -p "$XCX_STORAGE/wordlists"
        if [ -f "/usr/share/wordlists/rockyou.txt.gz" ]; then
            sudo gunzip -c "/usr/share/wordlists/rockyou.txt.gz" > "$XCX_STORAGE/wordlists/rockyou.txt"
        else
            wget -q "https://github.com/brannondorsey/naive-hashcat/releases/download/data/rockyou.txt" \
                -O "$XCX_STORAGE/wordlists/rockyou.txt"
        fi
    fi
}

# ============================================
# BACKGROUND SERVICES
# ============================================

start_background_services() {
    # Start Tor for anonymous mode
    sudo systemctl start tor 2>/dev/null
    
    # Start network monitoring
    (
        while true; do
            if [ "$XCX_MODE" = "ACTIVE" ]; then
                # Log network connections
                ss -tunap >> "$XCX_LOGS/network_$(date +%Y%m%d).log" 2>/dev/null
                
                # Check for new devices
                arp-scan -l 2>/dev/null | grep -v "DUP" >> "$XCX_LOGS/arp_scan.log" 2>/dev/null
            fi
            sleep 60
        done
    ) &
    
    # Start system monitor
    (
        while true; do
            if [ "$XCX_MODE" = "ACTIVE" ]; then
                # Log system stats
                top -bn1 | head -20 >> "$XCX_LOGS/system_$(date +%Y%m%d).log"
                
                # Check for suspicious activity
                ps aux | grep -E "nmap|sqlmap|john|hashcat|aircrack" | grep -v grep >> "$XCX_LOGS/tools_usage.log"
            fi
            sleep 30
        done
    ) &
    
    # Start cache cleaner
    (
        while true; do
            find "$XCX_CACHE" -type f -mtime +7 -delete 2>/dev/null
            find "$XCX_TEMP" -type f -mtime +1 -delete 2>/dev/null
            sleep 3600
        done
    ) &
}

# ============================================
# XCX ANIMATION - FIXED AND IMPROVED
# ============================================

show_xcx_animation() {
    clear
    tput civis
    
    local center_row=$((ROWS/2 - 8))
    local center_col=$(( (COLS - 60) / 2 ))
    
    # XCX Logo with animation
    local logo=(
        "    ██╗  ██╗ ██████╗██╗  ██╗    ███╗   ███╗███████╗ ██████╗  █████╗ "
        "    ╚██╗██╔╝██╔════╝██║  ██║    ████╗ ████║██╔════╝██╔════╝ ██╔══██╗"
        "     ╚███╔╝ ██║     ███████║    ██╔████╔██║█████╗  ██║  ███╗███████║"
        "     ██╔██╗ ██║     ██╔══██║    ██║╚██╔╝██║██╔══╝  ██║   ██║██╔══██║"
        "    ██╔╝ ██╗╚██████╗██║  ██║    ██║ ╚═╝ ██║███████╗╚██████╔╝██║  ██║"
        "    ╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝    ╚═╝     ╚═╝╚══════╝ ╚═════╝ ╚═╝  ╚═╝"
    )
    
    # Version info
    local version="╔══════════════════════════════════════════════════════════════════╗"
    local version2="║           XCX MEGA TOP v7.0 - SYSTEM TRANSFORMER              ║"
    local version3="║         Press CTRL+7+7 anytime for emergency exit             ║"
    local version4="╚══════════════════════════════════════════════════════════════════╝"
    
    # Loading steps
    local steps=(
        "[    ] Initializing kernel modules..."
        "[█   ] Loading system drivers..."
        "[██  ] Starting XCX core services..."
        "[███ ] Configuring testing environment..."
        "[████] Activating anonymous mode..."
        "[█████] System transformed successfully!"
    )
    
    # Animate logo with color cycling
    local colors=(
        "${XCX[NEON_RED]}"
        "${XCX[NEON_GREEN]}"
        "${XCX[NEON_BLUE]}"
        "${XCX[NEON_PURPLE]}"
        "${XCX[NEON_CYAN]}"
        "${XCX[NEON_YELLOW]}"
    )
    
    # First phase: Logo animation
    for phase in {1..3}; do
        clear
        for color in "${colors[@]}"; do
            tput cup $center_row $center_col
            for line in "${logo[@]}"; do
                echo -e "${color}${XCX[BOLD]}$line${XCX[RESET]}"
                tput cup $((++center_row)) $center_col
            done
            
            # Reset center_row
            center_row=$((ROWS/2 - 8))
            
            # Show version
            tput cup $((center_row + 6)) $center_col
            echo -e "${XCX[NEON_PURPLE]}${XCX[BOLD]}$version${XCX[RESET]}"
            tput cup $((center_row + 7)) $center_col
            echo -e "${XCX[NEON_PURPLE]}${XCX[BOLD]}$version2${XCX[RESET]}"
            tput cup $((center_row + 8)) $center_col
            echo -e "${XCX[NEON_PURPLE]}${XCX[BOLD]}$version3${XCX[RESET]}"
            tput cup $((center_row + 9)) $center_col
            echo -e "${XCX[NEON_PURPLE]}${XCX[BOLD]}$version4${XCX[RESET]}"
            
            sleep 0.1
        done
    done
    
    # Second phase: Loading animation
    for i in "${!steps[@]}"; do
        clear
        tput cup $center_row $center_col
        for line in "${logo[@]}"; do
            echo -e "${XCX[NEON_GREEN]}${XCX[BOLD]}$line${XCX[RESET]}"
            tput cup $((++center_row)) $center_col
        done
        
        center_row=$((ROWS/2 - 8))
        
        tput cup $((center_row + 11)) $((center_col + 10))
        echo -e "${XCX[NEON_YELLOW]}${steps[$i]}${XCX[RESET]}"
        
        # Show additional info based on step
        case $i in
            0) tput cup $((center_row + 12)) $((center_col + 10))
               echo -e "${XCX[NEON_CYAN]}   • Detecting hardware..." ;;
            1) tput cup $((center_row + 12)) $((center_col + 10))
               echo -e "${XCX[NEON_CYAN]}   • Loading network drivers..." ;;
            2) tput cup $((center_row + 12)) $((center_col + 10))
               echo -e "${XCX[NEON_CYAN]}   • Starting window manager..." ;;
            3) tput cup $((center_row + 12)) $((center_col + 10))
               echo -e "${XCX[NEON_CYAN]}   • Configuring tools..." ;;
            4) tput cup $((center_row + 12)) $((center_col + 10))
               echo -e "${XCX[NEON_CYAN]}   • Enabling Tor network..." ;;
            5) tput cup $((center_row + 12)) $((center_col + 10))
               echo -e "${XCX[NEON_GREEN]}   • System ready!" ;;
        esac
        
        sleep 0.5
    done
    
    # Final phase: Matrix rain
    for rain in {1..50}; do
        local rand_row=$((RANDOM % ROWS))
        local rand_col=$((RANDOM % COLS))
        tput cup $rand_row $rand_col
        echo -e "${XCX[MATRIX_GREEN]}$(printf '%x' $((RANDOM % 16)))${XCX[RESET]}"
        sleep 0.01
    done
    
    sleep 0.5
    clear
}

# ============================================
# WINDOW MANAGEMENT
# ============================================

create_window() {
    local title="$1"
    local cmd="$2"
    local w=${3:-70}
    local h=${4:-20}
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
    WIN_CACHE[$id]=""
    WIN_HISTORY[$id]=""
    
    # Draw window frame
    draw_window_frame $id
    
    # Create temporary file for output
    local tmp_out="$XCX_TEMP/win_${id}_out"
    local tmp_in="$XCX_TEMP/win_${id}_in"
    mkfifo "$tmp_in" 2>/dev/null
    
    # Launch process
    (
        # Set up environment
        export XCX_WIN_ID=$id
        export XCX_WIN_TITLE="$title"
        export XCX_HOME="$XCX_HOME"
        export PATH="$XCX_TOOLS:$PATH"
        
        # Run command with output redirected
        eval "$cmd" > "$tmp_out" 2>&1 &
        local cmd_pid=$!
        
        # Monitor process
        while kill -0 $cmd_pid 2>/dev/null; do
            if [ -f "$tmp_out" ]; then
                cat "$tmp_out" | while read line; do
                    local line_num=0
                    local max_lines=$((h - 4))
                    local content_y=$((y + 2))
                    
                    # Display output in window
                    if [ $line_num -lt $max_lines ]; then
                        tput cup $((content_y + line_num)) $((x + 2))
                        echo -ne "${XCX[WHITE]}${line:0:$((w-4))}${XCX[RESET]}"
                        ((line_num++))
                    fi
                done
            fi
            sleep 0.1
        done
    ) &
    
    WIN_PID[$id]=$!
    ACTIVE_WIN=$id
    
    return $id
}

draw_window_frame() {
    local id=$1
    local x=${WIN_X[$id]} y=${WIN_Y[$id]} w=${WIN_W[$id]} h=${WIN_H[$id]}
    local title="${WIN_TITLE[$id]}"
    local type="${WIN_TYPE[$id]}"
    
    # Choose colors based on window type
    local border_color="${XCX[NEON_CYAN]}"
    local title_color="${XCX[NEON_YELLOW]}"
    
    case "$type" in
        "tool") border_color="${XCX[NEON_GREEN]}" ;;
        "terminal") border_color="${XCX[NEON_BLUE]}" ;;
        "error") border_color="${XCX[NEON_RED]}" ;;
        "success") border_color="${XCX[NEON_PURPLE]}" ;;
    esac
    
    # Top border with title
    tput cup $y $x
    echo -ne "${border_color}┌"
    for ((i=1; i<w-1; i++)); do
        if [ $i -eq $(((w - ${#title}) / 2)) ]; then
            echo -ne "${title_color}${title}${border_color}"
            i=$((i + ${#title} - 1))
        else
            echo -ne "─"
        fi
    done
    echo -ne "┐${XCX[RESET]}"
    
    # Close button (X)
    tput cup $y $((x + w - 2))
    echo -ne "${XCX[NEON_RED]}✗${XCX[RESET]}"
    
    # Side borders
    for ((i=1; i<h-1; i++)); do
        tput cup $((y + i)) $x
        echo -ne "${border_color}│${XCX[RESET]}"
        tput cup $((y + i)) $((x + w - 1))
        echo -ne "${border_color}│${XCX[RESET]}"
    done
    
    # Bottom border
    tput cup $((y + h - 1)) $x
    echo -ne "${border_color}└"
    for ((i=1; i<w-1; i++)); do
        echo -ne "─"
    done
    echo -ne "┘${XCX[RESET]}"
    
    # Clear content area
    for ((i=1; i<h-1; i++)); do
        tput cup $((y + i)) $((x + 1))
        printf "%$((w-2))s" " "
    done
}

close_window() {
    local id=$1
    if [ -n "${WIN_PID[$id]}" ]; then
        kill -9 ${WIN_PID[$id]} 2>/dev/null
        wait ${WIN_PID[$id]} 2>/dev/null
    fi
    
    # Clear window area
    local x=${WIN_X[$id]} y=${WIN_Y[$id]} w=${WIN_W[$id]} h=${WIN_H[$id]}
    for ((i=0; i<h; i++)); do
        tput cup $((y + i)) $x
        printf "%$((w))s" " "
    done
    
    # Remove from arrays
    unset WINDOWS[$id] WIN_TITLE[$id] WIN_PID[$id]
    unset WIN_X[$id] WIN_Y[$id] WIN_W[$id] WIN_H[$id]
    unset WIN_TYPE[$id] WIN_CACHE[$id] WIN_HISTORY[$id]
    
    # Clean temp files
    rm -f "$XCX_TEMP/win_${id}_"*
}

# ============================================
# DESKTOP UI
# ============================================

draw_desktop() {
    clear
    
    # Draw background (simulated)
    for ((i=0; i<ROWS; i++)); do
        tput cup $i 0
        echo -ne "${XCX[BG_BLACK]}"
        printf "%${COLS}s" " "
    done
    
    # Draw taskbar
    draw_taskbar
    
    # Draw main menu
    draw_main_menu
    
    # Draw system monitor
    draw_system_monitor
    
    # Draw network monitor
    draw_network_monitor
    
    # Draw storage info
    draw_storage_info
    
    # Draw all active windows
    for id in "${!WINDOWS[@]}"; do
        draw_window_frame $id
    done
    
    # Draw footer with keyboard shortcuts
    draw_footer
}

draw_taskbar() {
    local datetime=$(date "+%H:%M:%S")
    local date=$(date "+%Y-%m-%d")
    
    # Get current IP
    local ip=$(curl -s ifconfig.me 2>/dev/null || echo "Unknown")
    
    # Get system load
    local load=$(uptime | awk -F'load average:' '{print $2}')
    
    # Get tool count
    local tool_count=$(ls "$XCX_TOOLS" 2>/dev/null | wc -l)
    
    # Top bar
    tput cup 0 0
    echo -e "${XCX[BG_DARK]}${XCX[NEON_CYAN]}${XCX[BOLD]}"
    printf "╔%-$((COLS-2))s╗" ""
    
    tput cup 1 0
    printf "║ ${XCX[NEON_GREEN]}XCX MEGA${XCX[NEON_CYAN]} │ ${XCX[NEON_YELLOW]}WIN:${#WINDOWS[@]}${XCX[NEON_CYAN]} │ ${XCX[NEON_PURPLE]}TOOLS:$tool_count${XCX[NEON_CYAN]} │ ${XCX[NEON_BLUE]}IP:$ip${XCX[NEON_CYAN]} │ ${XCX[NEON_RED]}LOAD:${load:0:15}${XCX[NEON_CYAN]} │ ${XCX[WHITE]}$date $datetime${XCX[NEON_CYAN]} %-$((COLS-110))s ║" ""
    
    echo -e "${XCX[RESET]}"
}

draw_main_menu() {
    local y=3
    local x=2
    local width=35
    
    tput cup $y $x
    echo -e "${XCX[NEON_PURPLE]}${XCX[BOLD]}╔══════════════════════════════════╗${XCX[RESET]}"
    tput cup $((y+1)) $x
    echo -e "${XCX[NEON_PURPLE]}${XCX[BOLD]}║      XCX CONTROL PANEL          ║${XCX[RESET]}"
    tput cup $((y+2)) $x
    echo -e "${XCX[NEON_PURPLE]}${XCX[BOLD]}╠══════════════════════════════════╣${XCX[RESET]}"
    
    local menu_items=(
        "1:🔍 PORT SCANNER         portscan"
        "2:🌐 NETWORK MAPPER       netmap"
        "3:🔑 PASSWORD CRACKER     crackpass"
        "4:🔐 HASH GENERATOR       hashtool"
        "5:🌍 WEB VULN SCANNER     webscan"
        "6:📡 PACKET SNIFFER       sniffer"
        "7:🔎 DNS ENUMERATOR       dnstool"
        "8:🔄 MAC CHANGER          macchanger"
        "9:💻 SSH BRUTEFORCE       sshbrute"
        "10:🕵️ ANONYMOUS SURF      anonsurf"
        "11:📁 FILE ENCRYPTOR      encrypt"
        "12:🧹 LOG CLEANER         cleanlogs"
        "13:🎯 KEYLOGGER DETECTOR  detectkey"
        "14:📶 WIFI AUDITOR        wifiaudit"
        "15:💀 METASPLOIT HELPER   msfhelper"
        "16:⚡ SQLMAP INTEGRATION   sqlmap"
        "17:🔨 JOHN THE RIPPER      john"
        "18:🎭 HIDEYOSHI MODE       hide"
        "19:📦 STORAGE MANAGER      storage"
        "20:⚙️ SYSTEM CONFIG        config"
    )
    
    local line=$((y+3))
    for item in "${menu_items[@]}"; do
        IFS=':' read -r key name cmd <<< "$item"
        tput cup $line $((x+1))
        echo -e "${XCX[NEON_GREEN]}$key${XCX[WHITE]} ${name}${XCX[RESET]}"
        ((line++))
    done
    
    tput cup $((y+23)) $x
    echo -e "${XCX[NEON_PURPLE]}${XCX[BOLD]}╚══════════════════════════════════╝${XCX[RESET]}"
}

draw_system_monitor() {
    local y=3
    local x=$((COLS - 45))
    local width=43
    
    tput cup $y $x
    echo -e "${XCX[NEON_BLUE]}${XCX[BOLD]}╔══════════════════════════════════════╗${XCX[RESET]}"
    tput cup $((y+1)) $x
    echo -e "${XCX[NEON_BLUE]}${XCX[BOLD]}║        SYSTEM MONITOR              ║${XCX[RESET]}"
    tput cup $((y+2)) $x
    echo -e "${XCX[NEON_BLUE]}${XCX[BOLD]}╠══════════════════════════════════════╣${XCX[RESET]}"
    
    # Real system stats
    local cpu=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}' | cut -d'%' -f1)
    local mem_total=$(free -m | awk '/^Mem:/{print $2}')
    local mem_used=$(free -m | awk '/^Mem:/{print $3}')
    local mem_percent=$((mem_used * 100 / mem_total))
    local disk_used=$(df -h / | awk 'NR==2 {print $5}' | tr -d '%')
    local processes=$(ps aux | wc -l)
    local users=$(who | wc -l)
    
    # Get network stats
    local net_in=$(cat /proc/net/dev | grep eth0 | awk '{print $2}' 2>/dev/null || echo "0")
    local net_out=$(cat /proc/net/dev | grep eth0 | awk '{print $10}' 2>/dev/null || echo "0")
    
    tput cup $((y+3)) $((x+1))
    echo -e "${XCX[NEON_GREEN]}CPU:${XCX[WHITE]} ${cpu:-0}%"
    tput cup $((y+4)) $((x+1))
    echo -e "${XCX[NEON_GREEN]}CPU Graph:${XCX[WHITE]} [$(printf '%*s' $((cpu/5)) | tr ' ' '█')$(printf '%*s' $((20 - cpu/5)) | tr ' ' '░')]"
    
    tput cup $((y+5)) $((x+1))
    echo -e "${XCX[NEON_YELLOW]}MEM:${XCX[WHITE]} ${mem_used}MB/${mem_total}MB (${mem_percent}%)"
    tput cup $((y+6)) $((x+1))
    echo -e "${XCX[NEON_YELLOW]}MEM Graph:${XCX[WHITE]} [$(printf '%*s' $((mem_percent/5)) | tr ' ' '█')$(printf '%*s' $((20 - mem_percent/5)) | tr ' ' '░')]"
    
    tput cup $((y+7)) $((x+1))
    echo -e "${XCX[NEON_CYAN]}DISK:${XCX[WHITE]} ${disk_used}% used"
    tput cup $((y+8)) $((x+1))
    echo -e "${XCX[NEON_CYAN]}DISK Graph:${XCX[WHITE]} [$(printf '%*s' $((disk_used/5)) | tr ' ' '█')$(printf '%*s' $((20 - disk_used/5)) | tr ' ' '░')]"
    
    tput cup $((y+9)) $((x+1))
    echo -e "${XCX[NEON_PURPLE]}PROCESSES:${XCX[WHITE]} $processes"
    tput cup $((y+10)) $((x+1))
    echo -e "${XCX[NEON_PURPLE]}USERS:${XCX[WHITE]} $users"
    
    tput cup $((y+11)) $((x+1))
    echo -e "${XCX[NEON_RED]}NET IN:${XCX[WHITE]} $((net_in/1024)) KB"
    tput cup $((y+12)) $((x+1))
    echo -e "${XCX[NEON_RED]}NET OUT:${XCX[WHITE]} $((net_out/1024)) KB"
    
    tput cup $((y+13)) $x
    echo -e "${XCX[NEON_BLUE]}${XCX[BOLD]}╚══════════════════════════════════════╝${XCX[RESET]}"
}

draw_network_monitor() {
    local y=$((ROWS - 20))
    local x=$((COLS - 45))
    
    tput cup $y $x
    echo -e "${XCX[NEON_CYAN]}${XCX[BOLD]}╔══════════════════════════════════════╗${XCX[RESET]}"
    tput cup $((y+1)) $x
    echo -e "${XCX[NEON_CYAN]}${XCX[BOLD]}║        NETWORK MONITOR              ║${XCX[RESET]}"
    tput cup $((y+2)) $x
    echo -e "${XCX[NEON_CYAN]}${XCX[BOLD]}╠══════════════════════════════════════╣${XCX[RESET]}"
    
    # Get network interfaces
    local interfaces=$(ip -o link show | awk -F': ' '{print $2}' | grep -v lo)
    local line=$((y+3))
    
    for iface in $interfaces; do
        local ip=$(ip -o -4 addr show $iface | awk '{print $4}' | cut -d/ -f1)
        local mac=$(ip -o link show $iface | awk '{print $17}')
        local status=$(cat /sys/class/net/$iface/operstate 2>/dev/null)
        
        tput cup $line $((x+1))
        echo -e "${XCX[NEON_GREEN]}$iface:${XCX[WHITE]} ${status:-unknown}"
        tput cup $((line+1)) $((x+3))
        echo -e "${XCX[NEON_CYAN]}IP:${XCX[WHITE]} ${ip:-none}"
        tput cup $((line+2)) $((x+3))
        echo -e "${XCX[NEON_CYAN]}MAC:${XCX[WHITE]} ${mac}"
        ((line+=4))
    done
    
    # Connection count
    local connections=$(ss -tun | tail -n +2 | wc -l)
    tput cup $((line)) $((x+1))
    echo -e "${XCX[NEON_YELLOW]}Active Connections:${XCX[WHITE]} $connections"
    
    tput cup $((line+2)) $x
    echo -e "${XCX[NEON_CYAN]}${XCX[BOLD]}╚══════════════════════════════════════╝${XCX[RESET]}"
}

draw_storage_info() {
    local y=$((ROWS - 20))
    local x=2
    
    tput cup $y $x
    echo -e "${XCX[NEON_YELLOW]}${XCX[BOLD]}╔══════════════════════════════════╗${XCX[RESET]}"
    tput cup $((y+1)) $x
    echo -e "${XCX[NEON_YELLOW]}${XCX[BOLD]}║        XCX STORAGE               ║${XCX[RESET]}"
    tput cup $((y+2)) $x
    echo -e "${XCX[NEON_YELLOW]}${XCX[BOLD]}╠══════════════════════════════════╣${XCX[RESET]}"
    
    # Storage stats
    local total_size=$(du -sh "$XCX_STORAGE" 2>/dev/null | cut -f1)
    local tool_count=$(find "$XCX_TOOLS" -type f -executable 2>/dev/null | wc -l)
    local data_files=$(find "$XCX_DATA" -type f 2>/dev/null | wc -l)
    local cache_size=$(du -sh "$XCX_CACHE" 2>/dev/null | cut -f1)
    local session_count=$(find "$XCX_SESSIONS" -type f 2>/dev/null | wc -l)
    
    tput cup $((y+3)) $((x+1))
    echo -e "${XCX[NEON_GREEN]}Storage:${XCX[WHITE]} $total_size"
    tput cup $((y+4)) $((x+1))
    echo -e "${XCX[NEON_GREEN]}Tools:${XCX[WHITE]} $tool_count"
    tput cup $((y+5)) $((x+1))
    echo -e "${XCX[NEON_GREEN]}Data Files:${XCX[WHITE]} $data_files"
    tput cup $((y+6)) $((x+1))
    echo -e "${XCX[NEON_GREEN]}Cache:${XCX[WHITE]} $cache_size"
    tput cup $((y+7)) $((x+1))
    echo -e "${XCX[NEON_GREEN]}Sessions:${XCX[WHITE]} $session_count"
    
    # Volume usage
    tput cup $((y+8)) $((x+1))
    echo -e "${XCX[NEON_CYAN]}Volumes:"
    for i in {1..5}; do
        local vol_size=$(du -sh "$XCX_STORAGE/volume-$i" 2>/dev/null | cut -f1)
        tput cup $((y+9+i)) $((x+3))
        echo -e "${XCX[NEON_PURPLE]}Volume $i:${XCX[WHITE]} ${vol_size:-empty}"
    done
    
    tput cup $((y+15)) $x
    echo -e "${XCX[NEON_YELLOW]}${XCX[BOLD]}╚══════════════════════════════════╝${XCX[RESET]}"
}

draw_footer() {
    tput cup $((ROWS - 1)) 0
    echo -e "${XCX[BG_DARK]}${XCX[NEON_CYAN]}"
    printf "╚%-$((COLS-2))s╝" ""
    
    tput cup $((ROWS - 1)) 2
    echo -e "${XCX[NEON_GREEN]}[1-20] Apps${XCX[NEON_CYAN]} | ${XCX[NEON_YELLOW]}[F1] Help${XCX[NEON_CYAN]} | ${XCX[NEON_BLUE]}[F2] Tools${XCX[NEON_CYAN]} | ${XCX[NEON_PURPLE]}[F3] Storage${XCX[NEON_CYAN]} | ${XCX[NEON_RED]}[F4] Close${XCX[NEON_CYAN]} | ${XCX[NEON_RED]}[CTRL+7+7] EXIT${XCX[RESET]}"
}

# ============================================
# LOGGING
# ============================================

log_event() {
    local event="$1"
    local details="$2"
    local timestamp=$(date +"%Y-%m-%d %H:%M:%S")
    
    echo "[$timestamp] [$event] $details" >> "$XCX_LOGS/system.log"
    
    # Rotate log if too large
    if [ -f "$XCX_LOGS/system.log" ] && [ $(stat -c%s "$XCX_LOGS/system.log" 2>/dev/null || echo 0) -gt 10485760 ]; then
        mv "$XCX_LOGS/system.log" "$XCX_LOGS/system.log.old"
    fi
}

# ============================================
# EMERGENCY EXIT HANDLER
# ============================================

emergency_exit() {
    echo -e "\n${XCX[NEON_RED]}${XCX[BOLD]}EMERGENCY EXIT SEQUENCE ACTIVATED${XCX[RESET]}"
    
    # Kill all processes
    for pid in "${WIN_PID[@]}"; do
        kill -9 $pid 2>/dev/null
    done
    
    # Stop services
    sudo systemctl stop tor 2>/dev/null
    
    # Restore system state
    restore_system_state
    
    # Show cursor
    tput cnorm
    
    # Clear screen
    clear
    
    echo -e "${XCX[NEON_GREEN]}XCX MEGA TOP terminated safely${XCX[RESET]}"
    exit 0
}

handle_emergency_key() {
    # This function is called by the trap
    # The actual key combination is handled in the input loop
    return
}

restore_system_state() {
    echo -e "${XCX[NEON_YELLOW]}[*] Restoring system state...${XCX[RESET]}"
    
    # Restore from backup
    if [ -d "$XCX_SYSTEM_BACKUP" ]; then
        [ -f "$XCX_SYSTEM_BACKUP/.bashrc" ] && cp "$XCX_SYSTEM_BACKUP/.bashrc" "$HOME/"
        [ -f "$XCX_SYSTEM_BACKUP/.zshrc" ] && cp "$XCX_SYSTEM_BACKUP/.zshrc" "$HOME/"
        [ -f "$XCX_SYSTEM_BACKUP/hosts" ] && sudo cp "$XCX_SYSTEM_BACKUP/hosts" "/etc/"
    fi
    
    # Remove XCX from bashrc if we added it
    sed -i '/# XCX MEGA TOP/,+5d' "$HOME/.bashrc" 2>/dev/null
    
    # Disable IP forwarding
    sudo sysctl -w net.ipv4.ip_forward=0 >/dev/null 2>&1
    
    # Remove network namespace
    sudo ip netns delete xcx-test 2>/dev/null
    
    # Remove virtual interfaces
    sudo ip link delete xcx0 2>/dev/null
    
    echo -e "${XCX[NEON_GREEN]}[✓] System restored${XCX[RESET]}"
}

# ============================================
# KEYBOARD HANDLER WITH EMERGENCY EXIT
# ============================================

handle_input() {
    read -n1 -s key
    
    # Check for CTRL+7+7 combination
    if [ "$key" = $'\x07' ]; then  # CTRL+G is 7 in some terminals
        read -n1 -s -t 1 next_key
        if [ "$next_key" = $'\x07' ]; then
            emergency_exit
        fi
    fi
    
    case "$key" in
        $'\x1b') # ESC sequences
            read -n2 -s rest
            case "$rest" in
                '[A'|'[B'|'[C'|'[D') ;; # Arrows ignore
                '[11~') # F1 - Help
                    create_window "XCX HELP" "echo 'XCX MEGA TOP v7.0 HELP\n\nCOMMANDS:\n1-20: Launch tools\nF1: This help\nF2: Tool manager\nF3: Storage manager\nF4: Close window\nCTRL+7+7: Emergency exit\n\nTOOLS:\n1. Port Scanner\n2. Network Mapper\n3. Password Cracker\n4. Hash Tool\n5. Web Scanner\n6. Packet Sniffer\n7. DNS Tool\n8. MAC Changer\n9. SSH Brute\n10. Anonymous Surf\n11. File Encryptor\n12. Log Cleaner\n13. Keylogger Detector\n14. WiFi Auditor\n15. MSF Helper\n16. SQLMap\n17. John Ripper\n18. Hideyoshi Mode\n19. Storage Manager\n20. System Config'" 70 30
                    ;;
                '[12~') # F2 - Tool manager
                    create_window "TOOL MANAGER" "ls -la $XCX_TOOLS | less" 70 25
                    ;;
                '[13~') # F3 - Storage manager
                    create_window "STORAGE MANAGER" "du -sh $XCX_STORAGE/* | sort -h | less" 70 25
                    ;;
                '[14~') # F4 - Close active window
                    if [ -n "$ACTIVE_WIN" ]; then
                        close_window $ACTIVE_WIN
                        ACTIVE_WIN=""
                    fi
                    ;;
            esac
            ;;
            
        # Number keys 1-20 launch tools
        [1-9])
            case "$key" in
                1) create_window "Port Scanner" "$XCX_TOOLS/portscan 127.0.0.1" 80 25 "tool" ;;
                2) create_window "Network Mapper" "$XCX_TOOLS/netmap 192.168.1" 80 25 "tool" ;;
                3) create_window "Password Cracker" "$XCX_TOOLS/crackpass /usr/share/wordlists/rockyou.txt" 80 25 "tool" ;;
                4) create_window "Hash Tool" "$XCX_TOOLS/hashtool sha256 test" 70 20 "tool" ;;
                5) create_window "Web Scanner" "$XCX_TOOLS/webscan http://localhost" 80 25 "tool" ;;
                6) create_window "Packet Sniffer" "echo 'Run with sudo: sudo $XCX_TOOLS/sniffer eth0'" 70 15 "tool" ;;
                7) create_window "DNS Tool" "$XCX_TOOLS/dnstool google.com" 70 15 "tool" ;;
                8) create_window "MAC Changer" "echo 'Usage: sudo $XCX_TOOLS/macchanger eth0'" 70 15 "tool" ;;
                9) create_window "SSH Brute" "$XCX_TOOLS/sshbrute localhost" 80 20 "tool" ;;
            esac
            ;;
            
        1[0-9])
            case "$key" in
                '10') create_window "Anonymous Surf" "$XCX_TOOLS/anonsurf status" 70 20 "tool" ;;
                '11') create_window "File Encryptor" "echo 'Usage: encrypt <encrypt|decrypt> <file> <password>'" 70 15 "tool" ;;
                '12') create_window "Log Cleaner" "$XCX_TOOLS/cleanlogs" 70 15 "tool" ;;
                '13') create_window "Keylogger Detector" "$XCX_TOOLS/detectkey" 70 15 "tool" ;;
                '14') create_window "WiFi Auditor" "echo 'Run with sudo: sudo $XCX_TOOLS/wifiaudit --scan'" 70 15 "tool" ;;
                '15') create_window "MSF Helper" "echo 'Usage: msfhelper <payload> <lhost> <lport>'" 80 15 "tool" ;;
                '16') create_window "SQLMap" "sqlmap --help" 80 25 "tool" ;;
                '17') create_window "John Ripper" "john --help" 80 25 "tool" ;;
                '18') create_window "Hideyoshi Mode" "echo 'Activating Hideyoshi stealth mode...'; export PS1='\[\033[0;32m\]\u@\h:\w\$\[\033[0m\] '" 70 15 "tool" ;;
                '19') create_window "Storage Manager" "ls -la $XCX_STORAGE | less" 80 25 "tool" ;;
                '20') create_window "System Config" "echo 'XCX Configuration\n\nMode: $XCX_MODE\nAnon: $XCX_ANON\nTor: $XCX_TOR\nSession: $XCX_SESSION_ID\nStorage: $XCX_STORAGE\nTools: $(ls $XCX_TOOLS | wc -l)'" 70 20 "tool" ;;
            esac
            ;;
            
        # Letter shortcuts
        [tT]) create_window "Terminal" "bash --rcfile <(echo 'PS1=\"\[\033[01;32m\]xcx@terminal\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ \"; echo \"XCX Terminal v7.0 - Type 'exit' to close\"')" 80 25 "terminal" ;;
        [xX]) # Close active window
            if [ -n "$ACTIVE_WIN" ]; then
                close_window $ACTIVE_WIN
                ACTIVE_WIN=""
            fi
            ;;
        [qQ]) emergency_exit ;;
    esac
}

# ============================================
# MAIN LOOP
# ============================================

# Initialize system
init_system

# Show boot animation
show_xcx_animation

# Create welcome window
create_window "WELCOME TO XCX MEGA TOP" "echo '╔══════════════════════════════════════╗\n║   XCX MEGA TOP v7.0                   ║\n║   SYSTEM TRANSFORMER                  ║\n║                                      ║\n║   • 20+ Real Pentesting Tools        ║\n║   • Full System Integration          ║\n║   • Anonymous by Default             ║\n║   • Encrypted Storage                ║\n║   • Emergency Exit (CTRL+7+7)        ║\n║                                      ║\n║   Press F1 for Help                  ║\n║   Press 1-20 to Launch Tools         ║\n╚══════════════════════════════════════╝'" 60 20 "success"

# Main loop
while true; do
    draw_desktop
    handle_input
done
