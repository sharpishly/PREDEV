# Sharpishly Dev Dashboard

A **C++ MVC application** for managing Docker-based development environments, SSL certificates, and DevOps tasks across multiple environments (local, development, staging, production). Includes a **web dashboard** for real-time control and deployment.

---

## Features

### Dashboard
- Web-based interface at `http://localhost:8080`
- One-click **deploy** for each environment with real-time logs
- **Add, update, remove environments** from the dashboard
- Execute common DevOps tasks:
  - Generate self-signed SSL certificates
  - Cleanup Docker containers, images, volumes, networks
  - Update Git repository
  - Update `/etc/hosts` entries
  - Check Docker status

### Environment Management
- Multiple environments with individual Docker Compose files
- Port checks to prevent conflicts
- Branch management for each environment
- Automatic Git pull before deployment
- Logs streamed to dashboard

### MVC Structure
- **Model**: Manages environment data and system operations  
- **Controller**: Handles HTTP requests and invokes model functions  
- **View**: Web dashboard (`HTML`, `CSS`, `JavaScript`)  

---

## Project Structure


```
PREDEV/
├── generate_all.sh # Script to generate full project files
├── run.sh # Build and run the C++ server
├── CMakeLists.txt
├── src/
│ ├── main.cpp
│ ├── controller/
│ └── model/
└── www/
├── index.html
├── style.css
└── script.js
```


---

## Prerequisites

- **C++17 compiler** (tested with GCC 13+)
- **CMake** (>= 3.10)
- **Docker & Docker Compose**
- **Git**
- **Linux/macOS** (for system commands and port checks)
- Optional: `lsof` for port checking

---

## Setup

1. **Clone or create the project folder**:

```bash
mkdir PREDEV && cd PREDEV
chmod +x generate_all.sh
./generate_all.sh
./run.sh
````

Perfect! Here’s an enhanced **`README.md`** with **embedded screenshots placeholders** and step-by-step visuals to make it very beginner-friendly. You can later replace the placeholders with actual images from your running dashboard.

---

```markdown
# Sharpishly Dev Dashboard

A **C++ MVC application** for managing Docker-based development environments, SSL certificates, and DevOps tasks across multiple environments (local, development, staging, production). Includes a **web dashboard** for real-time control and deployment.

---

## Features

### Dashboard
- Web-based interface at `http://localhost:8080`
- One-click **deploy** for each environment with real-time logs
- **Add, update, remove environments** from the dashboard
- Execute common DevOps tasks:
  - Generate self-signed SSL certificates
  - Cleanup Docker containers, images, volumes, networks
  - Update Git repository
  - Update `/etc/hosts` entries
  - Check Docker status

### Environment Management
- Multiple environments with individual Docker Compose files
- Port checks to prevent conflicts
- Branch management for each environment
- Automatic Git pull before deployment
- Logs streamed to dashboard

### MVC Structure
- **Model**: Manages environment data and system operations  
- **Controller**: Handles HTTP requests and invokes model functions  
- **View**: Web dashboard (`HTML`, `CSS`, `JavaScript`)  

---

## Project Structure

```

PREDEV/
├── generate\_all.sh      # Script to generate full project files
├── run.sh               # Build and run the C++ server
├── CMakeLists.txt
├── src/
│   ├── main.cpp
│   ├── controller/
│   └── model/
└── www/
├── index.html
├── style.css
└── script.js

````

---

## Prerequisites

- **C++17 compiler** (tested with GCC 13+)
- **CMake** (>= 3.10)
- **Docker & Docker Compose**
- **Git**
- **Linux/macOS** (for system commands and port checks)
- Optional: `lsof` for port checking

---

## Setup

1. **Clone or create the project folder**:

```bash
mkdir PREDEV && cd PREDEV
````

2. **Generate all project files**:

```bash
chmod +x generate_all.sh
./generate_all.sh
```

3. **Build and run the server**:

```bash
./run.sh
```

Server will start at: `http://localhost:8080`

---

## Dashboard Usage

### Main DevOps Panel

![Dashboard Main Panel](screenshots/dashboard-main.png)
*Buttons for generating SSL, cleaning Docker, updating Git repo, checking Docker status, updating hosts.*

---

### Environment Management

![Environment Management](screenshots/environment-list.png)
*List of environments with branch, Docker Compose file, ports. Includes `Deploy` and `Remove` buttons.*

---

### Add / Update Environment

![Add Environment](screenshots/add-environment.png)
*Form to add a new environment or update an existing one.*

---

### Real-Time Deployment Logs

![Deployment Logs](screenshots/deploy-logs.png)
*Clicking `Deploy` streams logs in real-time to the dashboard.*

---

## Environment Deployment Workflow

1. Click **Deploy** → server checks:

   * Web port availability
   * API port availability
2. Switches to the environment’s branch
3. Pulls latest Git changes
4. Stops Docker containers, rebuilds, and starts them
5. Streams logs back to dashboard

---

## Development Notes

* Add new features by creating Models/Controllers and integrating into `AppController.cpp`
* View updates: modify `www/index.html`, `style.css`, `script.js`
* Docker Compose: each environment can have its own compose file
* Real-time logs: uses HTTP streaming to `<pre>` element in dashboard

---

## Security Notes

* Runs as the user who started the server
* Commands like `sudo systemctl stop nginx` require proper permissions
* Use caution when deploying in production

---

## License

MIT License

---

## Future Enhancements

* Inline editing for environment updates
* Role-based access control for dashboard
* Notifications when ports are in use or deployment fails
* Integration with CI/CD pipelines
* Screenshots auto-updated after deployment for live preview

---

### Screenshot Folder

* Place screenshots in `PREDEV/screenshots/`
* Example files:

  * `dashboard-main.png`
  * `environment-list.png`
  * `add-environment.png`
  * `deploy-logs.png`

```

---

This version makes your project **visually descriptive** for new developers, and gives a **step-by-step guide** to using the dashboard.  

I can also create a **`screenshots` folder with placeholder images** automatically via a script so you can directly run the project and replace them with actual snapshots.  

Do you want me to do that?
```
