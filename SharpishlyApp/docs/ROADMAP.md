PREDEV and SharpishlyApp Roadmap
This roadmap outlines planned features for PREDEV (the platform for environment synchronization) and SharpishlyApp (its C++ MVC reference implementation).
✅ Completed

Basic CMake and run.sh setup.
MVC scaffolding (Controllers, Models, Views).
Minimal HTTP server (C++ standard library, port 1966).
Nmap penetration testing integration (host discovery, port scanning, service detection).
Scaffold and delete scripts for MVC components.
HostsSync MVC: Synchronizes /etc/hosts between Docker host and development machine.
PreFlight MVC skeleton: Initial provisioning and safety checks.
DatabaseIDE MVC: Auto-configures MySQL Workbench, SQLyog, and phpMyAdmin with Docker-detected MySQL credentials.
Route registration refactor: Moved routes to registerRoutes() helper in main.cpp.
Basic Game Engine scaffold for future extensibility.

🛠 In Progress

DatabaseIDE MVC: Extend to auto-detect MySQL containers from docker-compose.yml.
PreFlight MVC: Add drift detection for /etc/hosts synchronization (warn if local and remote differ).
Git MVC: Support for push, pull, commit, and checkout operations.
DockerSync MVC: Safe duplication and prefixing of docker-compose.yml, Dockerfiles, and nginx configs.

📌 Planned
High Priority

Controllers & Models for MySQL: Integrate MySQL database support within Docker.
DockerSync MVC: Automate synchronization of local and production Docker configurations.
Permissions MVC: Manage file/folder ownership (e.g., www-data) for src/View/www.
HTML/CSS/JS MVC: Support Smarty-style templates, partials, and web rendering in src/View/www.
PreFlight MVC: Full implementation to detect provisioning issues before changes.
Deployment MVC: Sync environments via .github/workflows/deploy.yml.

Medium Priority

DevOps Tools MVC: Add debugging, monitoring, security, and logging tools to docker-compose.yml.
Advanced Git MVC: Support branching strategies and feature/production workflows.
Monitoring/Debugging MVC: Centralized logging, error detection, and security scans.
Production-ready SSL: Certificate generation and rotation for the HTTP server.
Roadmap Auto-Update: Automate updates to ROADMAP.md based on repository changes.

Future Exploration

USB Functionality: Expose USB device features for SharpishlyApp.
Game Engine: Extend with advanced rendering and interaction features.
Node.js, Python, React.js Integrations: Support additional languages/frameworks.
Threats Database: Integrate with Nmap for penetration testing reports.
Docling Integration: Add document processing capabilities.
WiFi Functionality: Expose WiFi adapter features.
Recruitment Software Suite: Build website, mobile, desktop, CRM, and CMS to demonstrate PREDEV’s multi-environment synchronization.
Project Management Integrations: Support Jira, Trello, and Asana.
Machine Learning: Implement hiring algorithms, deployment pipelines, and feedback loops.
Subtask: Add webcam access and facial recognition for recruitment features.


AI-Assisted Scaffolding: Use AI to generate boilerplate code for new MVC components.
Real-Time Monitoring Dashboards: Visualize system status and performance.
