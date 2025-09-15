Changelog
All notable changes to PREDEV and SharpishlyApp are documented here.
[Unreleased]
In Progress

Extending DatabaseIDE MVC to auto-detect MySQL containers from docker-compose.
Adding PreFlight drift detection for /etc/hosts synchronization.
Preparing Git MVC for push, pull, commit, and checkout operations.
Preparing DockerSync MVC for safe duplication of docker-compose, Dockerfiles, and nginx configs.

[0.2.1] - 2025-09-05
Changed

Refactored main.cpp to use a centralized registerRoutes() helper for route definitions, reducing repetition and keeping the main function clean.

[0.2.0] - 2025-09-12
Added

Nmap penetration testing integration for host discovery, port scanning, and service detection.
Threats database scaffold (planned task).
Game Engine scaffold for future extensibility.
Scaffold and delete scripts for MVC components.
Extended ROADMAP.md with integrations (Docling, WiFi, Recruitment, Project Management, ML).
HostsSync MVC to synchronize /etc/hosts between Docker host and development machine.
Drift detection for host differences (local vs remote).
Backup and restore system for local and remote /etc/hosts.
Dry-run mode for HostsSync operations.
Roadmap tracking via ROADMAP.md.

Changed

Improved run.sh with safety measures for duplicating docker-compose.yml, Dockerfile, and nginx configs with environment prefixes.

Fixed

Corrected Controller include path errors to resolve compilation issues when accessing Model/View headers.

[0.1.0] - 2025-08-30
Added

Initial project scaffolding with CMake and run.sh.
MVC structure (Controller, Model, View).
Minimal HTTP server using C++ standard library, listening on 127.0.0.1:1966.
Home, Docs, and Provision controllers with corresponding views.
