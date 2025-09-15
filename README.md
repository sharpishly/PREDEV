PREDEV
PREDEV is a developer-first platform designed to eliminate custom shell scripts for deploying projects across environments (local, staging, production), even on the same machine. It automates tasks like file/folder permissions, git submodule checkouts, SSH key setup, and environment synchronization to simplify developer onboarding and ensure consistency.
SharpishlyApp is the reference implementation of PREDEV—a C++ MVC application framework scaffolded with assistance from ChatGPT (OpenAI). It serves as a learning and experimentation platform for modern software development practices, integrating C++, Docker, and DevOps workflows.

📌 Features

C++ MVC Structure
Model: Handles database interactions and business logic.
View: Manages HTTP server and rendering (includes src/View/www for web assets like index.html, css, js).
Controller: Orchestrates application logic.


Built-in HTTP Server
Minimal server listening on 127.0.0.1:1966, responding with plain text.
Extensible to support HTML/CSS/JS views (see Extending the HTTP Server).


Dockerized Setup
Supports local- and production- prefixed configurations for development and production environments.
Extensible via docker-compose.yml (see Docker Setup).


Planned DevOps Tools
Debugging, monitoring, security, and logging integrations.
Automatic provisioning and pre-flight checks.


Roadmap
See docs/ROADMAP.md for detailed goals and milestones.




🚀 Getting Started
Prerequisites

Operating System: Linux (Ubuntu 22.04 or later recommended).
Tools:
CMake (>= 3.10)
GNU C++ Compiler (g++ >= 13; see FAQ.md for older Ubuntu versions)
Docker & Docker Compose
make, curl, git



Install prerequisites on Ubuntu:
sudo apt update
sudo apt install -y cmake g++ make curl git docker.io docker-compose
sudo systemctl start docker
sudo systemctl enable docker

Build Instructions

Clone the repository:git clone https://github.com/<username>/PREDEV.git
cd PREDEV


Create and navigate to the build directory:mkdir -p build && cd build


Configure the project:cmake ..


Compile:make


Run the application:./SharpishlyApp


Test the HTTP server:curl http://127.0.0.1:1966

Expected output: Hello from C++ MVC!

For automated setup, use the run.sh script (see Using run.sh).
Using run.sh
The run.sh script automates setup tasks:

Allows port 1966 via ufw.
Stops Nginx to avoid port conflicts.
Sets permissions for src/View/www.
Builds and runs SharpishlyApp.

Run it from the project root:
./run.sh

If errors occur, see Troubleshooting in FAQ.md.
Docker Setup
To run SharpishlyApp in Docker:

Build and start the local environment:docker-compose -f docker/local-docker-compose.yml up --build


Test the server:curl http://127.0.0.1:1966




local-docker-compose.yml is for development with debugging enabled.
production-docker-compose.yml is optimized for production use.

See Docker Issues in FAQ.md for troubleshooting.
Extending the HTTP Server
To add a new route (e.g., /about):

Edit src/main.cpp and add to registerRoutes():routes.push_back({"/about", [](const std::string& request) {
    return "HTTP/1.1 200 OK\r\nContent-Type: text/plain\r\n\r\nWelcome to About!";
}});


Rebuild and run:cd build && cmake .. && make && ./SharpishlyApp


Test:curl http://127.0.0.1:1966/about



To serve HTML from src/View/www:

Add index.html to src/View/www.
Modify the route handler to read and serve the file (planned for future releases).


📂 Project Structure
PREDEV/
├── CMakeLists.txt          # Build configuration
├── run.sh                 # Automates build, permissions, and run
├── src/                   # Source code
│   ├── main.cpp           # Entry point with route registration
│   ├── Controller/        # Application logic
│   ├── Model/             # Database and business logic
│   ├── View/              # HTTP server and rendering
│   │   └── www/          # Web assets (index.html, css, js, partials)
├── include/               # Header files
├── docs/                  # Documentation
│   ├── ROADMAP.md        # Planned features and milestones
│   ├── CHANGELOG.md       # Version history
│   ├── FAQ.md             # Frequently asked questions
│   ├── index.md           # Documentation overview
├── docker/                # Docker configurations
│   ├── local-Dockerfile   # Development Dockerfile
│   ├── production-Dockerfile # Production Dockerfile
│   ├── local-docker-compose.yml # Development compose
│   ├── production-docker-compose.yml # Production compose
└── README.md              # Project overview


🛠 Contributing
Contributions are welcome! Please read CONTRIBUTING.md for guidelines on submitting issues, pull requests, and updating documentation.

⚠️ AI Scaffolding Details
SharpishlyApp was scaffolded with assistance from ChatGPT (OpenAI) for initial code structure (e.g., main.cpp, MVC scaffolding) and documentation drafts. All AI-generated code is manually reviewed for correctness and security by human developers. This project remains experimental and should not be used in production without thorough testing.

📜 License
MIT License—free to use, modify, and distribute. Attribution to this repository and ChatGPT scaffolding is appreciated.