Contributing to PREDEV
Thank you for your interest in contributing to PREDEV and its reference implementation, SharpishlyApp! This document outlines how to contribute effectively.
Getting Started

Read the Documentation:
README.md: Project overview and setup instructions.
ROADMAP.md: Planned features and priorities.
FAQ.md: Common questions and troubleshooting.


Set Up the Environment:
Follow the setup instructions in README.md.
Ensure prerequisites (CMake, g++ >= 13, Docker, etc.) are installed.


Check Open Issues:
Browse the repository’s issue tracker for bugs or feature requests.
Propose new issues with clear descriptions and reproduction steps.



Submitting Changes

Fork and Clone:git clone https://github.com/<your-username>/PREDEV.git
cd PREDEV


Create a Branch:
Use descriptive names (e.g., feature/add-git-mvc, fix/http-server-crash).

git checkout -b feature/your-feature-name


Make Changes:
Follow the project structure in README.md.
Ensure code aligns with C++17 standards and existing MVC patterns.
Update documentation as needed (see Updating Documentation).


Test Your Changes:
Build and run:./run.sh
curl http://127.0.0.1:1966


Test Docker setups:docker-compose -f docker/local-docker-compose.yml up --build




Commit Changes:
Use clear commit messages (e.g., “Add Git MVC for push/pull operations”).

git commit -m "Your commit message"


Submit a Pull Request:
Push your branch:git push origin feature/your-feature-name


Open a pull request with:
A clear title and description.
References to related issues (e.g., “Fixes #123”).
Updates to CHANGELOG.md and ROADMAP.md.





Updating Documentation

CHANGELOG.md: Add entries under [Unreleased] for new features or fixes. Use “Added,” “Changed,” or “Fixed” prefixes.
ROADMAP.md: Mark completed tasks with ✅ and move planned tasks to [Unreleased] in CHANGELOG.md.
FAQ.md: Add troubleshooting tips for new issues encountered.
Ensure all documentation is version-controlled and reflects code changes.

Code Style

Follow C++17 standards.
Use consistent naming (e.g., CamelCase for classes, snake_case for variables).
Add comments for complex logic in src/ files.
Ensure src/View/www assets (e.g., index.html) are portable and secure.

Reporting Bugs

File an issue with:
A clear title (e.g., “HTTP server crashes on invalid route”).
Steps to reproduce, expected behavior, and actual behavior.
Logs or error messages (e.g., output from cmake .. or ./SharpishlyApp).



Suggesting Features

Check ROADMAP.md to avoid duplicates.
File an issue with:
Feature description and use case.
Alignment with PREDEV’s goals (e.g., environment synchronization).
Proposed implementation (if applicable).



License
Contributions are licensed under the MIT License. See README.md for details. Attribution to ChatGPT scaffolding is appreciated for AI-generated code.