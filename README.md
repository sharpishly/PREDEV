# PREDEV

PREDEV is a developer-first platform designed to **remove the need for custom shell scripts** when deploying projects between different environments, even on the same machine.  

The goal is to make environment setup and synchronization seamless by automating common developer pain points:
- Removing the need to write scripts that change **file & folder permissions/ownership**.
- Handling **git submodule** checkouts for specific branches automatically.
- Managing **SSH public & private keys** setup across environments.
- Enabling **true synchronization between environments** (local, staging, production).
- Helping **new developers** set up a project without fuss.
- Treating shell scripts as **AI prompts** that can be executed as tasks inside PREDEV (future goal).

This project is intended to simplify developer onboarding, ensure consistent environments, and eliminate the drift that occurs when scripts are manually written and modified by each contributor.

---

## Reference Implementation: SharpishlyApp

![Build](https://img.shields.io/badge/build-passing-brightgreen)
![License](https://img.shields.io/badge/license-MIT-blue)
![Docker](https://img.shields.io/badge/docker-ready-blue)
![C++](https://img.shields.io/badge/C++-17-orange)

**SharpishlyApp** is the first reference implementation of PREDEV —  
a **C++ MVC application framework** scaffolded with the assistance of **ChatGPT (OpenAI)**.  

It is designed as a learning and experimentation platform for modern software development practices, combining **C++**, **Docker**, and **DevOps** workflows into one integrated environment.

---

## 📌 Features

- **C++ MVC Structure**
  - `Model` — for database interaction and business logic.
  - `View` — HTTP server and rendering layer.
  - `Controller` — application logic and orchestration.

- **Built-in HTTP Server**
  - Minimal standard library HTTP server (listening on `127.0.0.1:1966`).
  - Responds with plain text (extensible to HTML/CSS/JS views).

- **Dockerized Setup**
  - Local and production environments.
  - Safe duplication of configs (`local-`, `production-` prefixes).
  - Supports extensions with `docker-compose.yml`.

- **Planned DevOps Tools**
  - Debugging, monitoring, security, logging integrations.
  - Automatic provisioning and pre-flight checks.

- **Roadmap**
  - See [ROADMAP.md](docs/ROADMAP.md) for detailed project goals and milestones.

---

## 🚀 Getting Started

### Prerequisites
- **Linux (Ubuntu recommended)**
- **CMake (>= 3.10)**
- **GNU C++ Compiler (g++ >= 13)**
- **Docker & Docker Compose**
- `make`, `curl`, `git`

### Build Instructions
```bash
# Clone the repository
git clone <your-repo-url>
cd PREDEV

# Create build directory
mkdir -p build && cd build

# Configure project
cmake ..

# Compile
make

# Run
./SharpishlyApp
```

Visit in browser or with curl:
```bash
curl http://127.0.0.1:1966
```

You should see:
```
Hello from C++ MVC!
```

---

## 📂 Project Structure

```
PREDEV/
├── CMakeLists.txt         # Build configuration
├── run.sh                 # Build & run helper
├── src/
│   ├── main.cpp           # Entry point
│   ├── Controller/        # Controllers
│   ├── Model/             # Models
│   ├── View/              # Views (includes HttpServer)
│
├── include/               # Headers
├── docs/
│   ├── ROADMAP.md         # Planned features & milestones
│   ├── CHANGELOG.md       # Version history
│
├── docker/
│   ├── local-Dockerfile
│   ├── production-Dockerfile
│   ├── local-docker-compose.yml
│   ├── production-docker-compose.yml
│
└── README.md              # This file
```

---

## 🛠 Roadmap & Development

- [x] Scaffold project with CMake + C++17
- [x] Minimal HTTP server (View)
- [ ] MVC for Docker file protections (`local-`, `production-`)
- [ ] Pre-flight checks for provisioning
- [ ] Git integration (commit, push, pull controllers)
- [ ] Database integration (MySQL, phpMyAdmin, SQLyog, etc.)
- [ ] Debug/monitoring/security DevOps tools
- [ ] HTML/CSS/JS rendering with templates
- [ ] Multi-environment synchronization (`/etc/hosts` automation)
- [ ] Deployment workflow (`.github/workflows/deploy.yml`)

See full [ROADMAP.md](docs/ROADMAP.md).

---

## ⚠️ Disclaimer

This project was scaffolded and iteratively built with **ChatGPT (OpenAI)**.  
While the base code and structure were generated with AI assistance, all final integration, testing, and production hardening should be carefully reviewed by human developers.  

This repository is intended as an **educational, experimental, and prototyping framework**, not production-ready software (yet).

---

## 📜 License

MIT License — feel free to use, modify, and distribute.  
Attribution to this repository and **ChatGPT scaffolding** is appreciated.
