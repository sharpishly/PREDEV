#pragma once
#include <string>
#include <vector>

class PenetrationModel {
public:
    // Return true if `nmap` binary is available in PATH.
    static bool isNmapInstalled();

    // Run a raw nmap invocation with args (e.g. {"-sn", "192.168.1.0/24"})
    // Returns combined stdout+stderr output.
    static std::string runNmap(const std::vector<std::string>& args);

    // High-level helpers (each returns the nmap output for that scan)
    static std::string scanPing(const std::string& target);     // -sn (ping/host discovery)
    static std::string scanQuick(const std::string& target);    // -T4 -F (quick/full-port)
    static std::string scanVersion(const std::string& target);  // -sV (service/version)
    static std::string scanOS(const std::string& target);       // -O (OS detection) — may require root

    // Run a short sequence of scans and return a combined report (labelling sections)
    static std::string basicReport(const std::string& target);
};
