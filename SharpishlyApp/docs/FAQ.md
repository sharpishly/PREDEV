# PREDEV FAQ for Developers

## General Questions

### What is PREDEV?
PREDEV is a developer-first platform that eliminates the need for custom shell scripts when deploying projects across different environments (local, staging, production). It automates tasks like file/folder permissions, git submodule checkouts, SSH key setup, and environment synchronization to simplify developer onboarding and ensure consistency.

### What is the purpose of the SharpishlyApp?
SharpishlyApp is the reference implementation of PREDEV, a C++ MVC application framework designed for learning and experimentation. It integrates C++, Docker, and DevOps workflows, scaffolded with assistance from ChatGPT (OpenAI).

### Is PREDEV production-ready?
No, PREDEV and SharpishlyApp are experimental and educational tools, not yet production-ready. Developers should thoroughly review and test the code before considering production use.

## Setup and Installation

### What are the prerequisites for running PREDEV?
- **Operating System**: Linux (Ubuntu recommended)
- **Tools**: CMake (>= 3.10), GNU C++ Compiler (g++ >= 13), Docker, Docker Compose, `make`, `curl`, `git`

### How do I build and run SharpishlyApp?
1. Clone the repository:
   ```bash
   git clone <your-repo-url>
   cd PREDEV
   ```
2. Create and navigate to the build directory:
   ```bash
   mkdir -p build && cd build
   ```
3. Configure the project with CMake:
   ```bash
   cmake ..
   ```
4. Compile the project:
   ```bash
   make
   ```
5. Run the application:
   ```bash
   ./SharpishlyApp
   ```
6. Test the HTTP server by visiting `http://127.0.0.1:1966` in a browser or using:
   ```bash
   curl http://127.0.0.1:1966
   ```
   Expected output: `Hello from C++ MVC!`

### What does the HTTP server do?
The built-in HTTP server in SharpishlyApp listens on `127.0.0.1:1966` and responds with plain text. It is extensible to support HTML/CSS/JS views in the future.

## Project Structure and Features

### What is the project structure of PREDEV?
```
PREDEV/
├── CMakeLists.txt          # Build configuration
├── run.sh                 # Build & run helper script
├── src/                   # Source code
│   ├── main.cpp           # Entry point
│   ├── Controller/        # Controllers
│   ├── Model/            # Models
│   ├── View/             # Views (includes HttpServer)
├── include/              # Header files
├── docs/                 # Documentation
│   ├── ROADMAP.md        # Planned features & milestones
│   ├── CHANGELOG.md      # Version history
├── docker/               # Docker configurations
│   ├── local-Dockerfile
│   ├── production-Dockerfile
│   ├── local-docker-compose.yml
│   ├── production-docker-compose.yml
└── README.md             # Project overview
```

### What are the key features of SharpishlyApp?
- **C++ MVC Structure**: Separates concerns into Model (database/business logic), View (HTTP server/rendering), and Controller (application logic).
- **Dockerized Setup**: Supports local and production environments with `local-` and `production-` prefixed configurations.
- **HTTP Server**: Minimal server responding on `127.0.0.1:1966` with plain text output.
- **Planned Features**: Includes DevOps tools, database integration, and multi-environment synchronization (see [ROADMAP.md](docs/ROADMAP.md)).

### How does PREDEV handle environment synchronization?
PREDEV aims to automate synchronization tasks like file permissions, SSH key setup, and git submodule checkouts. Future goals include `/etc/hosts` automation and true multi-environment synchronization.

## Development and Contribution

### How can I contribute to PREDEV?
- Check the [ROADMAP.md](docs/ROADMAP.md) for planned features and milestones.
- Review open issues or propose new ones in the repository.
- Submit pull requests with clear descriptions of changes.
- Ensure code aligns with the MIT License and includes attribution to ChatGPT scaffolding where applicable.

### What is the roadmap for PREDEV?
Key planned features include:
- MVC for Docker file protections
- Pre-flight checks for provisioning
- Git integration (commit, push, pull controllers)
- Database integration (MySQL, phpMyAdmin, SQLyog, etc.)
- HTML/CSS/JS rendering with templates
- Deployment workflows (e.g., `.github/workflows/deploy.yml`)
See [ROADMAP.md](docs/ROADMAP.md) for details.

### Was PREDEV entirely written by humans?
No, PREDEV and SharpishlyApp were scaffolded with assistance from ChatGPT (OpenAI). While AI helped generate the base code and structure, human developers should review and harden the code for production use.

## Docker and DevOps

### How does Docker work with PREDEV?
PREDEV includes Docker configurations for local and production environments:
- `local-Dockerfile` and `local-docker-compose.yml` for development.
- `production-Dockerfile` and `production-docker-compose.yml` for production.
These files ensure consistent setups and support extensions via `docker-compose.yml`.

### What DevOps tools are planned?
Future integrations include debugging, monitoring, security, and logging tools, along with automatic provisioning and pre-flight checks. See [ROADMAP.md](docs/ROADMAP.md) for more details.

## Licensing and Attribution

### What is the license for PREDEV?
PREDEV is licensed under the MIT License, allowing free use, modification, and distribution. Attribution to the repository and ChatGPT scaffolding is appreciated.

### Why is attribution to ChatGPT included?
ChatGPT (OpenAI) was used to scaffold the initial code and structure of PREDEV and SharpishlyApp. Acknowledging this ensures transparency about the project’s origins.

## Troubleshooting

### Why isn’t the HTTP server responding?
- Ensure the application is running (`./SharpishlyApp`).
- Verify the server is listening on `127.0.0.1:1966` using `curl http://127.0.0.1:1966`.
- Check for port conflicts or firewall restrictions.
- Confirm all prerequisites (CMake, g++, Docker, etc.) are installed.

### What should I do if the build fails?
- Verify that all prerequisites are installed and meet the required versions.
- Ensure you’re in the `build` directory when running `cmake ..` and `make`.
- Check error messages for missing dependencies or incorrect configurations.
- Consult the repository’s issue tracker for similar problems or file a new issue.

### How do I report bugs or suggest features?
File an issue on the repository with a clear description of the bug or feature request. Include relevant logs, steps to reproduce, and any proposed solutions.