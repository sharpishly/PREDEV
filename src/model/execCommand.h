#ifndef EXECCOMMAND_H
#define EXECCOMMAND_H
#include <string>
#include <array>
#include <memory>
#include <stdexcept>
#include <cstdio>

inline std::string execCommand(const std::string& cmd) {
    std::array<char,128> buffer;
    std::string result;
    std::unique_ptr<FILE, decltype(&pclose)> pipe(popen(cmd.c_str(),"r"),pclose);
    if(!pipe) throw std::runtime_error("popen() failed!");
    while(fgets(buffer.data(),buffer.size(),pipe.get())!=nullptr) result+=buffer.data();
    return result;
}
#endif
