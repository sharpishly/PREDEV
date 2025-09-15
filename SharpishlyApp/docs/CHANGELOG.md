# Changelog

## \[Unreleased\]

-   Planned: Permissions MVC (file/folder ownership, www-data, etc.)
-   Planned: DevOps Tools MVC (debugging, monitoring, security)
-   Planned: Git MVC (push, pull, commit, checkout)
-   Planned: DockerSync MVC (safe duplication and prefixing of Docker
    configs)
-   Planned: DatabaseIDE MVC (auto-configure IDEs: MySQL Workbench,
    SQLyog, phpMyAdmin)
-   Planned: PreFlight MVC (provision checks and drift detection)
-   Planned: HTML/CSS/JS MVC (templates, partials, smarty-style
    rendering)
-   Planned: Deployment MVC (.github/workflows syncing across
    environments)
-   Planned: Advanced monitoring, debugging & SSL

## \[0.2.0\] - 2025-08-31

### Added

-   HostsSync MVC to synchronize /etc/hosts between Docker host and
    development machine
-   Drift detection for host differences (local vs remote)
-   Backup & restore system for local and remote /etc/hosts
-   Dry-run mode for HostsSync operations
-   Integrated Roadmap tracking via ROADMAP.md

### Changed

-   Expanded build.sh safety measures (duplication of
    docker-compose.yml, Dockerfile, nginx with environment prefixes)

## \[0.1.0\] - 2025-08-30

### Added

-   Initial project scaffolding (CMake, build.sh)
-   MVC structure (Controller, Model, View)
-   Minimal HttpServer (C++ standard library, listens on 127.0.0.1:1966)

## [0.2.1] - 2025-09-05

### Changed
- Refactored `main.cpp` to use a centralized `registerRoutes()` helper for route definitions.
  - Reduced repetition by storing routes in a vector of path/handler pairs.
  - Keeps main function clean while maintaining identical behavior.


  # 📜 Changelog

## [Unreleased]
- Planned: USB, WiFi, Recruitment software, ML integrations.

## [0.2.0] - 2025-09-12
### Added
- Nmap penetration testing integration.
- Threats database (planned task).
- Game Engine scaffold.
- Scaffold & delete scripts for MVC.
- Extended ROADMAP.md with new integrations (Docling, WiFi, Recruitment, Project Management, ML).

### Fixed
- Controller include path errors for models/views.
- Build system CMake updates for new scaffolds.

## [0.1.0] - 2025-09-05
### Added
- Initial MVC scaffolding.
- Base HTTP server + router.
- Home, Docs, Provision controllers + views.


