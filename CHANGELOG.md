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
