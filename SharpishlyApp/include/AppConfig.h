#pragma once
#include <string>
#include <vector>

struct AppConfig {
    std::string certsDir = "certs";
    std::string crtFile = "certs/sharpishly.dev.crt";
    std::string keyFile = "certs/sharpishly.dev.key";
    std::string domain = "sharpishly.dev";
    std::vector<std::string> hostnames = {
        "sharpishly.dev", "dev.sharpishly.dev",
        "docs.sharpishly.dev", "live.sharpishly.dev",
        "py.sharpishly.dev"
    };
};
