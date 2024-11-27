#!/bin/bash

# Function to print messages with color
print_color() {
    local color=$1
    local message=$2
    case "$color" in
        green) echo -e "\033[0;32m$message\033[0m" ;;  # Green
        red) echo -e "\033[0;31m$message\033[0m" ;;    # Red
        yellow) echo -e "\033[0;33m$message\033[0m" ;; # Yellow
        blue) echo -e "\033[0;34m$message\033[0m" ;;   # Blue
        *) echo "$message" ;;                          # Default (no color)
    esac
}

# Function to check if the domain is reachable over HTTP and HTTPS
check_connection() {
    local domain=$1

    print_color "blue" "Checking if $domain is reachable..."

    # Check port 80 (HTTP)
    if curl -Is "http://$domain" --max-time 10 | head -n 1 | grep -q "200 OK"; then
        print_color "green" "$domain is reachable on port 80 (HTTP)."
    else
        print_color "red" "$domain is not reachable on port 80 (HTTP)."
    fi

    # Check port 443 (HTTPS)
    if curl -Is "https://$domain" --max-time 10 | head -n 1 | grep -q "200 OK"; then
        print_color "green" "$domain is reachable on port 443 (HTTPS)."
    else
        print_color "red" "$domain is not reachable on port 443 (HTTPS)."
    fi
}

# Function to check for the encoding used by the domain
check_encoding() {
    local domain=$1

    print_color "blue" "Checking for encoding on $domain..."

    # Check encoding using curl
    encoding80=$(curl -s -I "http://$domain" | grep -i "Content-Type" | grep -i -Eo 'charset=[^;]*' || echo "No charset detected on port 80")
    encoding443=$(curl -s -I "https://$domain" | grep -i "Content-Type" | grep -i -Eo 'charset=[^;]*' || echo "No charset detected on port 443")

    if [[ "$encoding80" != "No charset detected on port 80" ]]; then
        print_color "yellow" "Encoding on port 80: $encoding80"
    else
        print_color "red" "$encoding80"
    fi

    if [[ "$encoding443" != "No charset detected on port 443" ]]; then
        print_color "yellow" "Encoding on port 443: $encoding443"
    else
        print_color "red" "$encoding443"
    fi
}

# Function to check for technologies used by the domain
check_technologies() {
    local domain=$1

    print_color "blue" "Detecting technologies used by $domain..."

    # Run WhatWeb to detect technologies
    tech=$(whatweb "$domain" --color=never)
    if [[ -z "$tech" ]]; then
        print_color "red" "Could not detect technologies for $domain."
    else
        print_color "yellow" "Technologies detected: $tech"
    fi
}

# Function to check for WAF using wafw00f and Nmap
check_waf() {
    local domain=$1

    print_color "blue" "Checking for WAF on $domain..."

    # Run wafw00f for WAF detection
    wafw00f "$domain" || print_color "red" "Could not detect a WAF for $domain using wafw00f."

    # Run Nmap for WAF detection on ports 80 and 443
    nmap -p 80,443 --script http-waf-detect "$domain" || print_color "red" "Could not detect a WAF for $domain using Nmap."
}

# Function to analyze the domain and perform all checks
analyze_domain() {
    local domain=$1

    # Check reachability
    check_connection "$domain"

    # Check encoding
    check_encoding "$domain"

    # Check for technologies
    check_technologies "$domain"

    # Check for WAF
    check_waf "$domain"
}

# Parse command-line options
while getopts "d:l:" opt; do
    case "$opt" in
        d)
            domain="$OPTARG"
            analyze_domain "$domain"
            ;;
        l)
            list_file="$OPTARG"
            if [[ -f "$list_file" ]]; then
                while IFS= read -r domain; do
                    analyze_domain "$domain"
                done < "$list_file"
            else
                print_color "red" "The file $list_file does not exist."
            fi
            ;;
        *)
            print_color "red" "Usage: $0 -d <domain> or $0 -l <list_file>"
            exit 1
            ;;
    esac
done

# If no option is provided
if [[ -z "$domain" && -z "$list_file" ]]; then
    print_color "red" "Usage: $0 -d <domain> or $0 -l <list_file>"
    exit 1
fi
