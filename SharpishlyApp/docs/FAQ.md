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

### How do I install the prerequisites on Ubuntu?
Run the following commands to install the required tools:
```bash
sudo apt update
sudo apt install -y cmake g++ make curl git docker.io docker-compose
```
Ensure Docker is running:
```bash
sudo systemctl start docker
sudo systemctl enable docker
```

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
│   │   └── www/          # Web assets (e.g., css, js, index.html, partials)
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
- **Web Assets**: The `src/View/www` directory contains web assets like `index.html`, `css`, `js`, and `partials` for future HTML/CSS/JS rendering.
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

### What does the `run.sh` script do?
The `run.sh` script automates setup tasks, including:
- Allowing port 1966 via `ufw`.
- Stopping Nginx to avoid port conflicts.
- Setting permissions for the `src/View/www` directory.
- Building and running the SharpishlyApp application.

## Licensing and Attribution

### What is the license for PREDEV?
PREDEV is licensed under the MIT License, allowing free use, modification, and distribution. Attribution to the repository and ChatGPT scaffolding is appreciated.

### Why is attribution to ChatGPT included?
ChatGPT (OpenAI) was used to scaffold the initial code and structure of PREDEV and SharpishlyApp. Acknowledging this ensures transparency about the project’s origins.

## Troubleshooting

### Why isn’t the HTTP server responding?
- Ensure the application is running (`./SharpishlyApp`).
- Verify the server is listening on `127.0.0.1:1966` using `curl http://127.0.0.1:1966`.
- Check for port conflicts (e.g., another service using port 1966) with:
  ```bash
  sudo netstat -tuln | grep 1966
  ```
- Ensure `ufw` allows port 1966:
  ```bash
  sudo ufw allow 1966
  sudo ufw status
  ```
- Confirm all prerequisites (CMake, g++, Docker, etc.) are installed.

### Why does `run.sh` fail with "No such file or directory" for `SharpishlyApp/build`?
This error occurs if the `build` directory does not exist. Create it manually before running the script:
```bash
mkdir -p SharpishlyApp/build
```
Alternatively, modify `run.sh` to create the directory automatically by adding before the `cd` command:
```bash
mkdir -p SharpishlyApp/build
```

### Why does `run.sh` fail with "cmake: command not found"?
This error indicates that CMake is not installed or not in your PATH. Install CMake:
```bash
sudo apt update
sudo apt install -y cmake
```
Verify the installation:
```bash
cmake --version
```

### Why does `run.sh` fail with "make: *** No targets specified and no makefile found"?
This error occurs if CMake did not generate a Makefile, likely because `cmake ..` failed. Ensure:
- You are in the `build` directory when running `cmake ..`.
- CMake is installed (see above).
- All dependencies (e.g., g++ >= 13) are installed:
  ```bash
  sudo apt install -y g++
  g++ --version
  ```
Run `cmake ..` manually in the `build` directory and check for errors.

### Why does `run.sh` fail with "./SharpishlyApp: Is a directory"?
This error suggests that `SharpishlyApp` is being interpreted as a directory instead of an executable. Possible causes:
- The build process failed, so the `SharpishlyApp` binary was not created.
- A directory named `SharpishlyApp` exists in the `build` directory, conflicting with the expected binary.
To resolve:
1. Check if the binary exists:
   ```bash
   ls -l SharpishlyApp/build
   ```
2. If a directory named `SharpishlyApp` exists, remove or rename it:
   ```bash
   rm -rf SharpishlyApp/build/SharpishlyApp
   ```
3. Re-run the build process:
   ```bash
   cd SharpishlyApp/build
   cmake ..
   make
   ```
4. Verify the binary exists before running:
   ```bash
   ls -l SharpishlyApp
   ```

### What should I do if the build fails?
- Verify that all prerequisites are installed and meet the required versions.
- Ensure you’re in the `build` directory when running `cmake ..` and `make`.
- Check error messages for missing dependencies or incorrect configurations.
- Run `cmake ..` and `make` manually to debug specific errors.
- Consult the repository’s issue tracker for similar problems or file a new issue.

### Why are permissions incorrect for the `src/View/www` directory?
The `run.sh` script sets read/write/execute permissions for the user on `src/View/www`. If permissions issues persist:
- Verify the permissions:
  ```bash
  ls -l SharpishlyApp/src/View/www
  ```
- Manually set permissions if needed:
  ```bash
  sudo chmod -R u+rwX SharpishlyApp/src/View/www
  ```
- Ensure the user running the script has sufficient privileges.

### How do I report bugs or suggest features?
File an issue on the repository with a clear description of the bug or feature request. Include relevant logs, steps to reproduce, and any proposed solutions.