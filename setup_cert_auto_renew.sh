#!/bin/bash
# setup_cert_auto_renew.sh
# Purpose: Automate SSL renewal using Ansible and monthly cron scheduling

set -e

BASE_DIR="$HOME/Documents/PREDEV"
ANSIBLE_DIR="$BASE_DIR/ansible"
LOG_DIR="$BASE_DIR/logs"
LINE="--------------"

echo "$LINE Starting Ansible SSL Auto-Renew Setup"

# 1️⃣ Create directories
echo "$LINE Creating directories..."
mkdir -p "$ANSIBLE_DIR/roles/cert_renew/tasks"
mkdir -p "$LOG_DIR"

# 2️⃣ Create inventory.yml (if missing)
if [ ! -f "$ANSIBLE_DIR/inventory.yml" ]; then
  echo "$LINE Creating ansible/inventory.yml..."
  cat > "$ANSIBLE_DIR/inventory.yml" <<'EOF'
all:
  hosts:
    sharpishly:
      ansible_host: 192.168.0.11
      ansible_user: tardis
      become: yes
EOF
else
  echo "$LINE inventory.yml already exists. Skipping."
fi

# 3️⃣ Create playbook_cert.yml (if missing)
if [ ! -f "$ANSIBLE_DIR/playbook_cert.yml" ]; then
  echo "$LINE Creating ansible/playbook_cert.yml..."
  cat > "$ANSIBLE_DIR/playbook_cert.yml" <<'EOF'
---
- hosts: sharpishly
  become: yes
  roles:
    - cert_renew
EOF
else
  echo "$LINE playbook_cert.yml already exists. Skipping."
fi

# 4️⃣ Create a placeholder cert_renew role (if missing)
if [ ! -f "$ANSIBLE_DIR/roles/cert_renew/tasks/main.yml" ]; then
  echo "$LINE Creating ansible role: cert_renew..."
  cat > "$ANSIBLE_DIR/roles/cert_renew/tasks/main.yml" <<'EOF'
---
- name: Placeholder certificate renewal role
  debug:
    msg: "Certificate renewal would occur here."
EOF
else
  echo "$LINE cert_renew role already exists. Skipping."
fi

# 5️⃣ Create or update monthly cron job
echo "$LINE Setting up crontab entry..."
CRON_JOB="@monthly ansible-playbook -i $ANSIBLE_DIR/inventory.yml $ANSIBLE_DIR/playbook_cert.yml >> $LOG_DIR/cert_renew.log 2>&1"

# Check if already exists
(crontab -l 2>/dev/null | grep -F "$CRON_JOB") && FOUND=true || FOUND=false

if [ "$FOUND" = false ]; then
  (crontab -l 2>/dev/null; echo "$CRON_JOB") | crontab -
  echo "$LINE Cron job added successfully."
else
  echo "$LINE Cron job already exists. No change made."
fi

# 6️⃣ Final message
echo "$LINE Setup complete!"
echo "➡ Monthly SSL renewal playbook will run automatically."
echo "➡ Logs will be stored in: $LOG_DIR/cert_renew.log"
echo "➡ You can test manually with:"
echo "   ansible-playbook -i $ANSIBLE_DIR/inventory.yml $ANSIBLE_DIR/playbook_cert.yml"
