# 🧠 Project: Local Repository Setup & MariaDB Installation Script

## 📘 Overview
This Bash script configures a **local YUM repository** on Red Hat Enterprise Linux and installs **MariaDB** from that repository.  
All operations are logged to `/var/log/local_repo.log`.

---

## ⚙️ Features
- Creates a local `.repo` configuration file
- Verifies the repository setup
- Installs MariaDB automatically
- Logs every action

---

## 🚀 Usage

1. Clone the repository:
   ```bash
   git clone https://github.com/<your-username>/local-repo-setup.git
   cd local-repo-setup
