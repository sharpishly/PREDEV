//
#ifndef EXEC_COMMAND_H
#define EXEC_COMMAND_H

#include <memory>
#include <array>
#include <cstdio>
#include <string>

inline std::string execCommand(const std::string& cmd) {
    using PipeDeleter = int(*)(FILE*);
    std::unique_ptr<FILE, PipeDeleter> pipe(popen(cmd.c_str(), "r"), pclose);

    if (!pipe) return "popen failed!";

    std::array<char, 128> buffer{};
    std::string result;
    while (fgets(buffer.data(), buffer.size(), pipe.get()) != nullptr) {
        result += buffer.data();
    }
    return result;
}

#endif // EXEC_COMMAND_H
