# 🧩 Project Shell Scripts Overview

This document lists all shell scripts currently used in the **PREDEV** project, their purpose, and planned migration paths.

---

## 🔧 Active Shell Scripts (Root Directory)

| Script | Purpose | Status | Planned Migration / Replacement |
|--------|----------|---------|---------------------------------|
| **ansible_setup.sh** | Initializes the Ansible environment and generates root CA certificates for local SSL setup. | ✅ Active | Replace with an Ansible role (`roles/cert_renew`) or Docker-managed SSL (e.g., Certbot container). |
| **setup_cert_auto_renew.sh** | Sets up a cron job to automatically renew SSL certificates via Ansible. | ✅ Active | Replace with a Docker/Ansible hybrid solution using `certbot` or built-in Nginx automation. |
| **run.sh** | Starts project containers and handles general development setup. | ✅ Active | Will remain until replaced by `make run` or integrated Ansible task. |
| **delete_scaffold_mvc.sh** | Removes previously generated MVC scaffolds. | ✅ Active | Retain as a developer utility. Potential future replacement: Python CLI or Make target. |
| **dir_list.sh** | Generates recursive directory listings for documentation or audit purposes. | ✅ Active | Optional; could be replaced with a Python utility or Ansible file audit task. |
| **install_doxygen.sh** | Installs and configures Doxygen documentation generator. | ✅ Active | Move to Ansible under `roles/documentation/` for reproducible setup. |
| **scaffold_mvc.sh** | Generates new MVC scaffolding for SharpishlyApp. | ✅ Active | Keep as-is for now; later integrate into project CLI tooling or Ansible. |

---

## 🧱 Migration Summary

- **To Migrate (Automation phase)**  
  `ansible_setup.sh`, `setup_cert_auto_renew.sh`, `install_doxygen.sh`  

- **To Keep (Developer Utilities)**  
  `run.sh`, `delete_scaffold_mvc.sh`, `dir_list.sh`, `scaffold_mvc.sh`  

---

## 📦 Next Steps
1. Create a dedicated Ansible role for SSL certificate generation and renewal.  
2. Replace standalone cron jobs with managed Docker or Ansible automation.  
3. Gradually port developer helper scripts into a `Makefile` or unified project CLI.  

---

*Last updated:* `$(date "+%Y-%m-%d")`  
*Maintainer:* **Sharpishly DevOps / PREDEV Team**
