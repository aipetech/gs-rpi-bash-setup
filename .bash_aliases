alias ll='ls -lha'
alias l='ls -CF'
alias lan-scan="nmap $(ip addr show $(ip route | awk '/default/ {print $5}') | awk '/inet / {print $2}' | awk -F'/' '{print $1}' | awk -F'.' '{print $1"."$2"."$3".-"}')"
