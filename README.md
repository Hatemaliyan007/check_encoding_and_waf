Script Name:
check_encoding_and_waf.sh

Description:
This Bash script performs various checks on a given domain or list of domains. It verifies reachability, detects character encoding, identifies web technologies in use, and checks for the presence of a Web Application Firewall (WAF). Additionally, it uses Nmap to scan ports 80 and 443 for status and services.

Features:
Domain or List Input:

Accepts a single domain or a file containing a list of domains.
Reachability Check:

Verifies if the domain is accessible over HTTP (port 80) or HTTPS (port 443).
Encoding Detection:

Identifies the character encoding used by the domain.
Technology Identification:

Uses httpx to detect server information, web frameworks, and other technologies.
WAF Detection:

Leverages wafw00f to check for Web Application Firewalls.
Port Scanning:

Uses Nmap to check the status of ports 80 and 443 and identify the services running.
Colorized Output:

Results are displayed with colors to enhance readability:
✅ Green: Success or positive results.
❌ Red: Errors or issues.
ℹ️ Blue: Informational messages.
Usage:
bash
Copy code
./check_encoding_and_waf.sh -d <domain>
./check_encoding_and_waf.sh -l <list_file>
Options:
-d <domain>: Check a single domain (e.g., abuissa.com).
-l <list_file>: Check multiple domains from a file (one domain per line).
Examples:
Single Domain:
bash
Copy code
./check_encoding_and_waf.sh -d abuissa.com
List of Domains:
bash
Copy code
./check_encoding_and_waf.sh -l domains.txt
Where domains.txt contains:

Copy code
abuissa.com
desjardins.com
example.com
Requirements:
Dependencies:

curl: For checking HTTP/HTTPS connectivity and content.
httpx: For identifying technologies.
wafw00f: For WAF detection.
nmap: For scanning ports.
Environment:

Bash shell (recommended on Linux/macOS).
Permissions:

Ensure the script is executable:
bash
Copy code
chmod +x check_encoding_and_waf.sh
Output Explanation:
Reachability:

Indicates whether the domain is accessible via HTTP/HTTPS.
Example:
✅ Reachable: abuissa.com is reachable on port 443 (HTTPS).
❌ Not Reachable: abuissa.com is not reachable on port 80 (HTTP).
Encoding:

Shows detected encoding (e.g., UTF-8).
Technologies:

Lists detected server frameworks, CMS platforms, and plugins.
WAF Detection:

Indicates if a WAF is present and identifies its type.
Port Status:

Displays open or closed status for ports 80 and 443.
Troubleshooting:
Script not running: Ensure the script has executable permissions:

bash
Copy code
chmod +x check_encoding_and_waf.sh
Dependencies missing: Install missing tools using your package manager:

Example for macOS with Homebrew:
bash
Copy code
brew install curl nmap wafw00f
go install github.com/projectdiscovery/httpx/cmd/httpx@latest
Color Output Issues: Ensure your terminal supports ANSI color codes.

License:
This script is open-source and can be modified as needed. Attribution is appreciated but not required.

Author:
Hatem Aliyan
For questions or support, feel free to reach out.
