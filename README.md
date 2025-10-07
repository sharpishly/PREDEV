Excellent — this is a solid and comprehensive `README.md` foundation.
Before I finalize the updated version for your repo, I’ll incorporate the **latest project developments** since your last documentation update, including:

✅ Game Engine (HTML5 + JS)
✅ Auto-dependency install in `run.sh`
✅ Ansible + Docker integration plans
✅ Upcoming GitHub Actions (minify/test/build)
✅ Expanded ROADMAP (business + security + AI)
✅ Use of hybrid inline/external assets (temporary CSS/JS fix)

---

Here’s your **updated and modernized `README.md`**, ready for commit (`#15 Updated README with Game Engine, DevOps, and automation features`):

---

# **PREDEV**

**PREDEV** is a developer-first automation and deployment framework designed to eliminate the need for repetitive shell scripts when deploying or running applications across environments (local, staging, production)—even on the same machine.

It automates permission management, submodule syncing, SSH setup, and Docker orchestration—streamlining onboarding, ensuring consistency, and enabling self-hosted DevOps workflows.

**SharpishlyApp** is the *reference implementation* of PREDEV — a C++ MVC web framework scaffolded with help from **ChatGPT (OpenAI)**.
It serves as a testbed for modern software practices integrating **C++**, **Docker**, **Ansible**, **HTML5/JS**, and **GitHub Actions**.

---

## 🚀 **Features**

### 🧩 C++ MVC Framework

* **Model** — database and business logic
* **View** — inbuilt HTTP server serving HTML/CSS/JS
* **Controller** — application orchestration and routing

### 🌐 Built-in HTTP Server

* Lightweight server listening on **127.0.0.1:1966**
* Supports HTML/CSS/JS via `src/View/www`
* Extensible to full static/dynamic web serving

### 🧱 Game Engine (Phase 1)

* Written in **vanilla JavaScript** (no external libs)
* Renders a **real-time interactive canvas** (rotating cube / player demo)
* Demonstrates SharpishlyApp’s async JS calls via `app.get()`
* Future phases: C++ + WebAssembly integration for 3D graphics

### 🐳 Dockerized Setup

* Modular environment with **local** and **production** `docker-compose.yml`
* Can be started automatically using **Ansible playbooks**
* Future versions will build from **run.sh → docker-compose.yml → GitHub Actions CI**

### ⚙️ Automated Build (`run.sh`)

* Checks and installs dependencies (`cmake`, `make`, `g++`, `ufw`)
* Opens port `1966` and stops Nginx to avoid conflicts
* Compiles, builds, and runs SharpishlyApp
* Will soon generate Docker builds automatically

### 🧠 AI Integration

* Documentation, scaffolding, and CI tasks supported by **ChatGPT (OpenAI)** and **Grok.ai**
* GitHub Actions planned for minification, linting, and unit tests

---

## 🧭 **Roadmap**

See [docs/ROADMAP.md](docs/ROADMAP.md) for detailed technical, business, and security goals.
Key highlights include:

* Game Engine Phase 1–3 (JS → C++ → WebAssembly)
* Docker & Ansible integration
* GitHub Actions for JS/CSS minification + tests
* Security architecture & business development (Apple Scheme, funding CSV)
* CYBERDECK project integration

---

## 🧰 **Getting Started**

### Prerequisites

* **OS:** Ubuntu 22.04 or newer
* **Tools:**

  * CMake ≥ 3.10
  * GNU g++ ≥ 13
  * Docker & Docker Compose
  * make, curl, git

```bash
sudo apt update
sudo apt install -y cmake g++ make curl git docker.io docker-compose
sudo systemctl enable --now docker
```

---

### Build & Run (Manual)

```bash
git clone https://github.com/sharpishly/PREDEV.git
cd PREDEV
mkdir -p build && cd build
cmake ..
make
./SharpishlyApp
curl http://127.0.0.1:1966
```

Expected output:

```
Hello from C++ MVC!
```

---

### Build & Run (Automated)

Use the included `run.sh` script:

```bash
./run.sh
```

It will:

* Auto-install missing dependencies
* Configure permissions
* Build SharpishlyApp
* Launch on port **1966**

---

### Docker Setup

To run inside Docker:

```bash
docker-compose -f docker/local-docker-compose.yml up --build
curl http://127.0.0.1:1966
```

* `local-docker-compose.yml`: development setup
* `production-docker-compose.yml`: optimized build
* Future: `docker-compose.yml` auto-generated from `run.sh`

---

## 🧠 **Extending the Framework**

### Adding a New Route

In `src/main.cpp`:

```cpp
routes.push_back({"/about", [](const std::string& req) {
  return "HTTP/1.1 200 OK\r\nContent-Type: text/plain\r\n\r\nWelcome to About!";
}});
```

Then rebuild:

```bash
cd build && cmake .. && make && ./SharpishlyApp
```

---

### Serving HTML / JS / CSS

Static files are located in:

```
src/View/www/
```

Currently, inline CSS/JS is used for testing; hybrid external support is in progress.

Future versions will automatically serve files from:

```
/css/styles.css
/js/app.js
```

---

## 🧩 **Project Structure**

```
PREDEV/
├── CMakeLists.txt
├── run.sh
├── src/
│   ├── main.cpp
│   ├── Controller/
│   ├── Model/
│   ├── View/
│   │   └── www/
│   │       ├── index.html
│   │       ├── css/
│   │       ├── js/
│   │       └── partials/
├── include/
├── docs/
│   ├── ROADMAP.md
│   ├── CHANGELOG.md
│   ├── FAQ.md
│   └── index.md
├── docker/
│   ├── local-docker-compose.yml
│   ├── production-docker-compose.yml
│   ├── local-Dockerfile
│   └── production-Dockerfile
└── README.md
```

---

## ⚡ **Contributing**

Contributions are welcome!
Follow standard GitHub Flow — feature branches, pull requests, and well-documented commits.

---

## ⚠️ **AI Scaffolding Notice**

Parts of this project were scaffolded using ChatGPT (OpenAI) and Grok.ai to accelerate code generation and documentation.
All AI outputs are manually validated by developers for correctness, maintainability, and security.

---

## 📜 **License**

**MIT License** — free to use, modify, and distribute.
Attribution to **Sharpishly** and **ChatGPT scaffolding** appreciated.

---

### 🔖 Next Planned Update

* Integrate `run.sh` → `docker-compose.yml`
* Implement GitHub Actions for linting/minification
* Add game engine visual demo (rotating cube)
* Begin Ansible provisioning rollout

---

Would you like me to:

1. Format this into Markdown and produce a **ready-to-commit file** (`README.md`),
2. Or first insert it into your **docs/ROADMAP.md** as a synced “Summary & Context” section before committing?
