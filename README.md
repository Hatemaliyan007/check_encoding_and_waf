# README for `check_encoding_and_waf.sh`

---

## Script Name:
`check_encoding_and_waf.sh`

## Description:
This Bash script performs various checks on a given domain or list of domains. It verifies reachability, detects character encoding, identifies web technologies in use, and checks for the presence of a Web Application Firewall (WAF). Additionally, it uses Nmap to scan ports 80 and 443 for status and services.

---

## Features:
1. **Domain or List Input**:
   - Accepts a single domain or a file containing a list of domains.
   
2. **Reachability Check**:
   - Verifies if the domain is accessible over HTTP (port 80) or HTTPS (port 443).

3. **Encoding Detection**:
   - Identifies the character encoding used by the domain.

4. **Technology Identification**:
   - Uses **httpx** to detect server information, web frameworks, and other technologies.

5. **WAF Detection**:
   - Leverages **wafw00f** to check for Web Application Firewalls.

6. **Port Scanning**:
   - Uses **Nmap** to check the status of ports 80 and 443 and identify the services running.

7. **Colorized Output**:
   - Results are displayed with colors to enhance readability:
     - ✅ **Green**: Success or positive results.
     - ❌ **Red**: Errors or issues.
     - ℹ️ **Blue**: Informational messages.

---

## Usage:

```bash
./check_encoding_and_waf.sh -d <domain>
./check_encoding_and_waf.sh -l <list_file>
