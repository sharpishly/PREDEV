Perfect ✅

Here’s your **commit-ready `docs/ROADMAP.md`** file — cleaned, structured, and ready to drop straight into your repository.
You can save it as:
`~/Documents/PREDEV/docs/ROADMAP.md`
and commit with:

```bash
git add docs/ROADMAP.md
git commit -m "Updated ROADMAP with milestones, priorities, and tangible outcomes"
git push
```

---

### 📘 **docs/ROADMAP.md**

```markdown
# PREDEV and SharpishlyApp Roadmap

This roadmap defines milestones and tangible outcomes for **PREDEV** — the environment synchronization and provisioning platform — and its reference implementation, **SharpishlyApp**, a C++ MVC framework.  
It includes all related technologies (Ansible, Docker, AI-assisted scaffolding, and JavaScript Game Engine).

---

## ✅ Completed

| Area | Task | Outcome |
|------|------|----------|
| Core | Basic CMake and `run.sh` setup | PREDEV builds and runs automatically on Ubuntu 22.04+ |
| Architecture | MVC scaffolding (Controllers, Models, Views) | Functional separation of business, logic, and presentation |
| Networking | Minimal HTTP server (port 1966) | Serves HTML output via `127.0.0.1:1966` |
| Security | Nmap integration | Host discovery, port scan, and service detection implemented |
| Automation | Scaffold and delete MVC scripts | Developers can generate and remove controllers/models easily |
| HostsSync MVC | `/etc/hosts` synchronization | Syncs hostnames between Docker and local machine |
| PreFlight MVC | Initial provisioning and checks | Ensures environment consistency before deployment |
| DatabaseIDE MVC | MySQL auto-config setup | MySQL Workbench, SQLyog, phpMyAdmin preconfigured via Docker |
| Refactor | Centralized `registerRoutes()` in main.cpp | Simplified route management |
| Game Engine | Basic HTML5/JS scaffold | Renders canvas + player interaction demo (Phase 1 complete) |

---

## 🛠 In Progress

| Area | Task | Expected Outcome | Target |
|------|------|------------------|--------|
| DatabaseIDE MVC | Auto-detect MySQL containers in docker-compose | Full database auto-configuration | Q4 2025 |
| PreFlight MVC | Drift detection for `/etc/hosts` | Detect and warn on mismatched hosts | Q4 2025 |
| Git MVC | Add push, pull, commit, checkout commands | Complete Git integration into SharpishlyApp | Q4 2025 |
| DockerSync MVC | Prefix-safe duplication of configs | Local ↔ production sync of Docker and Nginx files | Q4 2025 |
| Game Engine (Phase 2) | Textured rotating cube + camera control | Demonstrate 3D rendering pipeline in browser | Q4 2025 |

---

## 📌 Planned

### 🔺 High Priority

| Area | Task | Tangible Outcome | Notes |
|------|------|------------------|-------|
| MySQL Controllers | Full Docker-integrated DB layer | Persist game + app data | Links to DatabaseIDE MVC |
| DockerSync MVC | Automate environment sync | Unified Docker workflow | Auto-generated from `run.sh` |
| Permissions MVC | Manage ownership for `/src/View/www` | Prevent runtime permission issues | |
| HTML/CSS/JS MVC | Serve static assets via HTTP server | `/css/styles.css`, `/js/app.js` externally loaded | Fix long-standing inline issue |
| PreFlight MVC | Full provisioning validation | Detect missing deps or service conflicts | |
| Deployment MVC | `.github/workflows/deploy.yml` | Automated build + deploy with GitHub Actions | Includes test + minify |
| Game Engine (Phase 3) | Physics and AI simulation | Interactive physics environment in browser | To integrate with C++ backend |

---

### ⚙️ Medium Priority

| Area | Task | Outcome | Timeline |
|------|------|----------|----------|
| DevOps Tools MVC | Debugging, monitoring, security, logs | Production observability stack | Q1 2026 |
| Advanced Git MVC | Branching strategies | Auto PR + merge support | Q1 2026 |
| Monitoring/Debugging | Centralized logs + error detection | Single dashboard for diagnostics | Q1 2026 |
| SSL Certificates | Auto-rotate self-signed or Certbot | HTTPS-ready deployment | Q1 2026 |
| Roadmap Auto-Update | Generate ROADMAP.md via commits | Automated doc sync with Git history | Q1 2026 |

---

### 🔮 Future Exploration

| Area | Task | Description / Goal |
|------|------|--------------------|
| USB Functionality | Expose USB device features for SharpishlyApp |
| Game Engine Expansion | Integrate with WebAssembly for 3D graphics |
| Node.js, Python, React.js | Add multi-language integration |
| Threats Database | Combine Nmap + C++ server for security reporting |
| Docling PDF Reader | Add server-side document parsing |
| WiFi Control | Expose adapter scanning and connection features |
| Recruitment Suite | Build CRM + CMS across web, mobile, desktop |
| Project Management Integration | Connect with Jira, Trello, Asana |
| Machine Learning | Hiring algorithms, deployment pipelines, feedback |
| Webcam & Facial Recognition | For recruitment user verification |
| AI Scaffolding | Generate new MVCs automatically |
| Real-Time Dashboards | Live visualization of app metrics |
| GitHub Actions | Minify JS, run unit tests, build verification |
| CYBERDECK | Hardware + software research integration |
| CSV Grants | Generate funding eligibility lists |
| Pricing Structure | Define SaaS subscription tiers |
| Security Architecture | Comprehensive app + infra design |
| Godaddy Integration | Email + domain API setup |
| Office Space Ops | Exchange Quay / Didsbury co-working management |
| iTunes / Audacity | Media library + editing integrations |
| Google Analytics | Site metrics + traffic analysis |
| Certbot + Disaster Recovery | Local + remote backup automation |
| Workflow Documentation | Define dev → stage → prod flow |
| Environment Simplification | Streamline `env.php` |
| PhD Notes | Academic documentation & research linkage |

---

## 🧭 Priority Order (as of October 2025)

| Rank | Focus Area | Status |
|------|-------------|--------|
| 1️⃣ | Game Engine (JS/C++/WebAssembly) | In Progress |
| 2️⃣ | Docker & Ansible Integration | Upcoming |
| 3️⃣ | GitHub Actions (CI/CD, Minify, Test) | Planned |
| 4️⃣ | DatabaseIDE + MySQL Integration | In Progress |
| 5️⃣ | HTML/CSS/JS MVC + Asset Loading Fix | Planned |
| 6️⃣ | Permissions MVC | Planned |
| 7️⃣ | PreFlight + Deployment MVC | Planned |
| 8️⃣ | Machine Learning Integration | Future |
| 9️⃣ | Recruitment + Webcam | Future |
| 🔟 | Cyberdeck + Security Architecture | Future |

---

## 🧪 Tangible Milestones

| Milestone | Deliverable | Target Date |
|------------|-------------|--------------|
| Game Engine Phase 2 | Textured rotating cube (JS only) | Dec 2025 |
| Game Engine Phase 3 | Physics + AI engine integration | Feb 2026 |
| Docker Automation | Auto-compose generation from `run.sh` | Dec 2025 |
| GitHub Actions CI | Unit testing + JS minification | Jan 2026 |
| Ansible Rollout | Provision C++ app inside Docker | Jan 2026 |
| HTML/CSS/JS Fix | Full static asset serving from /www | Nov 2025 |

---

## 🧩 Notes

- **AI Collaboration**: Ongoing partnership with ChatGPT + Grok.ai for code review and documentation.  
- **Testing & Validation**: CI/CD pipelines will auto-run preflight builds once Docker and GitHub Actions are stable.  
- **Accessibility Focus**: All outputs designed for browser compatibility and developer self-hosting.
```

Perfect — here’s the **updated `docs/ROADMAP.md`** that aligns with your current progress, repository structure, and the new Docker milestone.

This file is formatted for direct commit under:
📁 `docs/ROADMAP.md`
🪶 Commit message suggestion:

> `#16 Updated ROADMAP — Phase 1 Completed (Docker success, Game Engine live, Phase 2 prep)`

---

# **ROADMAP**

> **Project:** SharpishlyApp (PREDEV Framework)
> **Last Updated:** October 2025
> **Maintained by:** Sharpishly / Paul A. McIntosh
> **AI Assistants:** ChatGPT (OpenAI) · Grok.ai

---

## 🧭 **Overview**

**SharpishlyApp** is the testbed implementation of **PREDEV**, a next-generation developer automation and deployment framework.
It combines **C++**, **JavaScript**, **Docker**, and **Ansible** to build self-contained, reproducible environments — from local prototypes to production.

Each phase introduces a key layer of automation, AI-assisted DevOps, and modular architecture.

---

## ✅ **Phase 1 — Foundation Complete**

### 🔹 Goal

Establish a self-contained environment to compile, serve, and deploy SharpishlyApp using **C++ MVC**, **HTML/JS**, and **Docker**.

### 🔹 Key Deliverables

| Component                  | Status     | Description                                                 |
| -------------------------- | ---------- | ----------------------------------------------------------- |
| C++ MVC Framework          | 🟢 Done    | Core HTTP server with routes and response handling          |
| Game Engine (JS)           | 🟢 Done    | Vanilla JS app rendering test element via `app.get()`       |
| Static File Routing        | 🟡 Partial | Inline JS/CSS functional; hybrid mode operational           |
| Docker Environment         | 🟢 Done    | LEMP stack (Nginx, PHP-FPM, MySQL, Postgres)                |
| SSL Certificate Automation | 🟢 Done    | Auto-cert generation via `certgen` service                  |
| Monitoring                 | 🟢 Done    | Portainer + Glances active                                  |
| Database Interfaces        | 🟢 Done    | Adminer GUI working with both MySQL & Postgres              |
| Documentation              | 🟢 Done    | Updated README + inline dev notes                           |
| Version Control            | 🟢 Done    | Branching structure: `feature/provisioning-deployment` live |

### 🔹 Outcome

> All containers build and run successfully.
> SSL certificates generate automatically.
> The stack achieves full **local production parity** under Docker Compose v2.

---

## 🚧 **Phase 2 — Application Integration**

### 🔹 Goal

Connect the C++ backend, PHP frontend, and databases within Dockerized services.
Add support for HTTPS and real-time status monitoring.

### 🔹 Planned Tasks

| Task                            | Outcome                                       | Deadline        |
| ------------------------------- | --------------------------------------------- | --------------- |
| Integrate Nginx ↔ PHP-FPM       | PHP scripts render via Nginx reverse proxy    | ⏳ October 2025  |
| Configure DB access from PHP    | Confirm connections to MySQL/Postgres via PDO | ⏳ October 2025  |
| Enable HTTPS for sharpishly.dev | Self-signed SSL working in browser            | ⏳ October 2025  |
| Implement `/debug/` logging     | PHP + Nginx errors log to mounted volume      | ⏳ October 2025  |
| Add Docker health dashboards    | Portainer graphs and Glances widgets tuned    | ⏳ October 2025  |
| Prepare for Ansible playbook    | Docker stack provisioned automatically        | ⏳ November 2025 |

---

## 🧱 **Phase 3 — Automation and CI/CD**

### 🔹 Goal

Bridge **run.sh**, **Docker Compose**, and **GitHub Actions** to create a zero-click build pipeline.

### 🔹 Planned Tasks

* GitHub Actions workflow for:

  * 🧪 Unit + Integration testing
  * 🧼 Minification (CSS/JS)
  * 🐳 Docker image build and push
* Ansible playbooks for:

  * Automated environment setup
  * Remote deployment via SSH
* Continuous deployment trigger from `main`

### 🔹 Expected Outcome

> Developers can spin up a production-ready Sharpishly environment with one command or Git push.

---

## 🧠 **Phase 4 — Intelligence & Tooling**

### 🔹 Goal

Introduce AI-driven optimization and dynamic system feedback.

### 🔹 Future Integrations

* Grok.ai or ChatGPT integration for:

  * Inline code scaffolding
  * Context-aware deployment help
* Real-time log summarization via AI agent
* Security audit suggestions (AI-based)
* AI-driven test case generation

---

## 💼 **Business & Research Initiatives**

| Initiative                             | Description                                                 | Status         |
| -------------------------------------- | ----------------------------------------------------------- | -------------- |
| **Apple Scheme (Black Entrepreneurs)** | Identify funding and mentorship programs for Sharpishly Ltd | 🚧 Research    |
| **Funding CSV Generator**              | Automate scraping of available grants and output to CSV     | 🚧 Development |
| **Pricing Structure for Sharpishly**   | Define pricing tiers for internal SaaS modules              | 🚧 Drafting    |
| **Security Architecture**              | Document encryption, auth, and DevSecOps layers             | 🚧 In Progress |

---

## 🔐 **Security Architecture (Planned)**

| Layer       | Component                      | Description                              |
| ----------- | ------------------------------ | ---------------------------------------- |
| SSL/TLS     | certgen + Nginx                | Self-signed or Let’s Encrypt integration |
| Network     | UFW / Docker network isolation | Limits service exposure                  |
| Application | Authentication                 | Planned for Sharpishly portal            |
| Monitoring  | Glances + Portainer            | Continuous uptime and anomaly tracking   |

---

## 🎮 **Game Engine Roadmap**

| Phase | Language              | Focus                                             | Status     |
| ----- | --------------------- | ------------------------------------------------- | ---------- |
| 1     | JavaScript            | Async `app.get()` response + `<canvas>` rendering | ✅ Done     |
| 2     | C++ + WebAssembly     | 3D cube demo (textured, rotating)                 | 🚧 Planned |
| 3     | AI-enhanced rendering | Integrate AI logic for in-game decisioning        | 🕒 Future  |
| 4     | Physics & ECS System  | Sharpishly Game Framework v1                      | 🕒 Future  |

---

## 📆 **Timeline Summary**

| Phase | Description                    | Status         | Target       |
| ----- | ------------------------------ | -------------- | ------------ |
| 1     | Base Framework + Dockerization | ✅ Complete     | Oct 2025     |
| 2     | Service Integration + HTTPS    | 🚧 In Progress | Oct–Nov 2025 |
| 3     | Automation (CI/CD + Ansible)   | ⏳ Upcoming     | Dec 2025     |
| 4     | AI Tooling + Advanced Features | 🕒 Future      | 2026         |

---

## 🏁 **Next Milestone**

> **Phase 2 – Nginx ↔ PHP-FPM Integration + HTTPS Validation**

* [ ] Connect PHP container to Nginx proxy
* [ ] Test local HTTPS via `https://sharpishly.dev`
* [ ] Validate DB connection from PHP (MySQL + Postgres)
* [ ] Create debug logs in `/debug/` volume
* [ ] Verify container health via Portainer dashboard


