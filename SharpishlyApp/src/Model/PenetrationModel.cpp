#include "PenetrationModel.h"

std::vector<std::string> PenetrationModel::getAvailableTools() {
    return {
        "Nmap - Network exploration",
        "Nikto - Web server scanner",
        "Metasploit - Exploitation framework",
        "sqlmap - SQL injection tool",
        "Hydra - Login brute forcing"
    };
}
