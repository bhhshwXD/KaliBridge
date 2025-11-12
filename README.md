<h1 align="center">⚙️ KALI REPOSITORY INSTALLER FOR DEBIAN-BASED & UBUNTU-BASED SYSTEMS</h1>
<p align="center">
  A simple Bash script to <b>add or remove the official Kali Linux repository</b> on any Debian-based or Ubuntu-based distribution 🐉  
  Safe, clean, and comes with automatic GPG key setup and Pin-Priority configuration.
</p>

<p align="center">
  <a href="https://saweria.co/AZKINGG"><img src="https://img.shields.io/badge/💰%20Support%20on-Saweria-orange?style=for-the-badge" alt="Saweria"></a>
  <a href="https://instagram.com/backtrack.deb"><img src="https://img.shields.io/badge/📸%20Instagram-@backtrack.deb-pink?style=for-the-badge&logo=instagram&logoColor=white" alt="Instagram"></a>
  <a href="https://github.com/bhhshwXD"><img src="https://img.shields.io/badge/💻%20GitHub-bhhshwXD-black?style=for-the-badge&logo=github" alt="GitHub"></a>
</p>

---

## 🧠 What Does This Script Do?

This script lets you **safely add or remove the official Kali Linux repository** on any **Debian-based or Ubuntu-based system** —  
such as Debian, Ubuntu, Linux Mint, Pop!\_OS, Zorin OS, Elementary OS, MX Linux, and others —  
without manually editing your APT configuration.

- If the Kali repo **does not exist**, it will be **added automatically**.  
- If the Kali repo **already exists**, it will be **removed cleanly**.  

One script, two functions 🔄

---

## ⚠️ IMPORTANT WARNING

> 🚫 **DO NOT use this script on non-Debian-based systems!**  
> This script is intended **only for Debian or Ubuntu and their derivatives**.  
>  
> Do **NOT** use it on Arch Linux, Fedora, Void, openSUSE, or other non-APT-based systems.  
>  
> Running this script outside supported systems can cause **serious errors or system damage**.  
>  
> The script automatically checks for `apt` — if not found, it will safely stop and warn you.

---

## ✨ Key Features

✅ Automatically add or remove the Kali Linux repository  
✅ Import the official Kali GPG key  
✅ Create a safe Pin-Priority file (priority 50)  
✅ Cleanly remove all related configurations  

---

## ⚙️ Installation & Usage

Clone the repository and run the script:

```bash
git clone https://github.com/bhhshwXD/KaliBrigde.git
cd kali-repo-installer
chmod +x kali-repo.sh
sudo ./kali-repo.sh
