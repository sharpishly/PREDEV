
#ifndef EXECCOMMAND_H
#define EXECCOMMAND_H
// /**
//  * @file execCommand.h
//  * @brief Utility function to execute shell commands
//  */
#include <string>
#include <array>
#include <memory>
#include <stdexcept>
#include <cstdio>

/**
 * @brief Executes a shell command and returns its output
 * @param cmd The command to execute
 * @return The command's output as a string
 * @throws std::runtime_error if popen() fails
 */
inline std::string execCommand(const std::string& cmd) {
    std::array<char,128> buffer;
    std::string result;
    std::unique_ptr<FILE, decltype(&pclose)> pipe(popen(cmd.c_str(),"r"),pclose);
    if(!pipe) throw std::runtime_error("popen() failed!");
    while(fgets(buffer.data(),buffer.size(),pipe.get())!=nullptr) result+=buffer.data();
    return result;
}
#endif

