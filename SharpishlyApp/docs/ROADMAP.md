# SharpishlyApp Roadmap

## ✅ Completed

- **Basic CMake + build.sh setup**
- **Basic MVC structure created** (Controller, Model, View)
- **Minimal HttpServer** (C++ standard library, port 1966)
- **Roadmap tracking system (MVC)**
- **HostsSync MVC** (sync /etc/hosts between Docker host and dev machine)
- **PreFlight MVC skeleton** (provisioning/safety checks before changes)
- **DatabaseIDE MVC** (setup MySQL Workbench, SQLyog, phpMyAdmin)
- **Auto-detect MySQL credentials from Docker container**
- **Route Registration Refactor** (moved all routes into `registerRoutes()` helper for cleaner main.cpp)

---

## 🛠 In Progress

- Extend **DatabaseIDE MVC** to auto-detect MySQL containers from docker-compose
- Add **PreFlight drift detection** for /etc/hosts sync (warn if local and remote differ)
- Prepare **Git MVC** (push, pull, commit, checkout)
- Prepare **DockerSync MVC** (sync local vs production docker-compose, dockerfiles, nginx configs)

---

## 📌 Todo / Planned

- **Controllers & Models for MySQL** (inside Docker)
- **DockerSync MVC** (safe duplication + prefixing of docker-compose.yml, Dockerfile, nginx configs)
- **Permissions MVC** (manage file/folder ownership: www-data, etc.)
- **DevOps Tools MVC** (debugging, monitoring, security tools in docker-compose local)
- **HTML/CSS/JS MVC** (views, templates, partials, {{{smarty}}})
- **PreFlight MVC full implementation** (detect potential issues before provisioning changes)
- **DatabaseIDE MVC** -- automatically configure IDEs with connection profiles
- **Advanced Git MVC** (branching strategies, feature vs production flows)
- **Monitoring/Debugging MVC** (centralized logging, error detection, security scans)
- **Deployment MVC** (sync across environments via .github/workflows)
- **Production-ready SSL handling** (cert generation & rotation)
- **Roadmap auto-export/update system** (ROADMAP.md maintained in repo)
