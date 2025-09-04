#ifndef POSTGRESCONTROLLER_H
#define POSTGRESCONTROLLER_H

#include <string>

class PostgresController {
public:
    static std::string index();
    static std::string create();
    static std::string read();
    static std::string update();
    static std::string remove(); // renamed from delete (reserved keyword)
};

#endif
