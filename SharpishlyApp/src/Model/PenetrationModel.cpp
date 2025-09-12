#include "PenetrationModel.h"
#include <cstdio>
#include <array>
#include <sstream>
#include <iostream>

// Helper: run a shell command and capture output (stdout + stderr)
static std::string runCommandCapture(const std::string& cmd) {
    std::array<char, 4096> buffer;
    std::string result;
    // use shell to allow redirection; we redirect stderr to stdout
    std::string full = cmd + " 2>&1";
    FILE* pipe = popen(full.c_str(), "r");
    if (!pipe) {
        return "ERROR: failed to run command: " + cmd + "\n";
    }
    while (fgets(buffer.data(), static_cast<int>(buffer.size()), pipe) != nullptr) {
        result += buffer.data();
    }
    int rc = pclose(pipe);
    std::ostringstream oss;
    oss << result;
    oss << "\n[exit=" << rc << "]";
    return oss.str();
}

bool PenetrationModel::isNmapInstalled() {
    // Use command -v for POSIX shells
    FILE* pipe = popen("command -v nmap >/dev/null 2>&1 && echo yes || echo no", "r");
    if (!pipe) return false;
    char buf[16] = {0};
    fgets(buf, sizeof(buf), pipe);
    pclose(pipe);
    std::string s(buf);
    return s.find("yes") != std::string::npos;
}

std::string PenetrationModel::runNmap(const std::vector<std::string>& args) {
    if (!isNmapInstalled()) {
        return "nmap is not installed on this system.\n";
    }
    std::ostringstream cmd;
    cmd << "nmap";
    for (const auto& a : args) {
        // basic escaping: wrap arguments in single quotes, replace single quote inside (rare for our use)
        std::string safe = a;
        // If argument contains a single-quote, we fallback to double quotes (best-effort)
        if (safe.find('\'') != std::string::npos && safe.find('"') == std::string::npos) {
            cmd << " \"" << safe << "\"";
        } else {
            cmd << " '" << safe << "'";
        }
    }
    return runCommandCapture(cmd.str());
}

std::string PenetrationModel::scanPing(const std::string& target) {
    return runNmap({ "-sn", target });
}

std::string PenetrationModel::scanQuick(const std::string& target) {
    // T4 = faster timing, -F = fast scan of fewer ports
    return runNmap({ "-T4", "-F", target });
}

std::string PenetrationModel::scanVersion(const std::string& target) {
    // Service/version detection can be intrusive; may require privileges
    return runNmap({ "-sV", target });
}

std::string PenetrationModel::scanOS(const std::string& target) {
    // OS detection typically requires root / elevated privileges
    return runNmap({ "-O", target });
}

std::string PenetrationModel::basicReport(const std::string& target) {
    std::ostringstream out;
    out << "=== Basic Penetration Report for: " << target << " ===\n\n";

    out << ">>> 1) Ping / host discovery (-sn)\n";
    out << scanPing(target) << "\n\n";

    out << ">>> 2) Quick port scan (-T4 -F)\n";
    out << scanQuick(target) << "\n\n";

    out << ">>> 3) Service/version detection (-sV)\n";
    out << scanVersion(target) << "\n\n";

    // OS detection may require sudo — detect and warn
    out << ">>> 4) OS detection (-O) — may require root privileges\n";
    out << scanOS(target) << "\n\n";

    out << "=== End of Report ===\n";
    return out.str();
}
