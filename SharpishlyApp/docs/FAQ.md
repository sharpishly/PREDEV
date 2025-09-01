# SharpishlyApp FAQ

This FAQ addresses common questions developers might have about SharpishlyApp, a C++ MVC application framework designed for learning and experimentation, scaffolded with ChatGPT assistance.

## Why build a C++ MVC framework when modern frameworks like Django, Spring, or Node.js exist?
SharpishlyApp is an educational and experimental platform to explore modern C++ (C++17) in a structured MVC architecture, integrating DevOps practices and Docker. It’s not intended to compete with production frameworks but to serve as a learning tool for C++ developers interested in web and DevOps workflows.

## Why use C++ for a web application framework instead of more common languages like Python or JavaScript?
C++ offers high performance and fine-grained control, making it a valuable case study for systems-level programming in web contexts. The project demonstrates how C++ can handle web server tasks while teaching developers about its integration with modern tools like Docker.

## Why rely on ChatGPT for scaffolding instead of writing it from scratch?
ChatGPT accelerates initial setup, allowing focus on iterative refinement and learning. The AI-generated base is a starting point, with human review and customization ensuring quality, as noted in the project’s disclaimer.

## Why focus on Dockerized environments for a learning project?
Docker ensures consistent local and production environments, teaching developers about containerization and DevOps practices. The `local-` and `production-` prefixes help explore environment-specific configurations in a safe, reproducible way.

## Why implement a minimal HTTP server instead of using existing ones like Nginx or Apache?
The built-in HTTP server (on `127.0.0.1:1966`) is a pedagogical tool to understand low-level HTTP handling in C++. It’s extensible to support HTML/CSS/JS, providing hands-on experience with server mechanics.

## Why prioritize features like HostsSync MVC or PreFlight MVC over core functionality like database integration?
Features like HostsSync and PreFlight MVC teach advanced DevOps concepts (e.g., environment synchronization, provisioning checks), which are critical for real-world deployments. Database integration is planned but secondary to establishing a robust DevOps foundation.

## Why target Linux (Ubuntu) specifically for this project?
Linux (Ubuntu) is widely used in development and production environments, offering a stable platform for C++ compilation, Docker, and DevOps tools. It simplifies setup for a consistent learning experience.

## Why is the project described as ‘not production-ready’ yet includes production-focused features like SSL and deployment workflows?
The production features are part of the roadmap to teach developers about hardening applications for real-world use. The disclaimer emphasizes that it’s a learning tool, requiring human review before production deployment.

## Why include planned features like Git MVC or DatabaseIDE MVC instead of focusing on a complete core framework first?
The roadmap reflects a comprehensive learning platform, covering Git workflows, database IDE integration, and more. These features simulate a full development lifecycle, helping developers understand both coding and operational aspects.

## Why use an MIT license for an experimental project?
The MIT license encourages open collaboration and reuse, aligning with the project’s educational goal. It allows developers to experiment, modify, and share derivatives while giving credit to the original work.

---

For more details, see the [README.md](../README.md), [ROADMAP.md](../docs/ROADMAP.md), or [CHANGELOG.md](../docs/CHANGELOG.md). If you have further questions or want to contribute, check the project repository or reach out!