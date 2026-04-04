# 🐉 Kali Installation Checklist  
### Based on Hacker101 Resources  
*(Mapped directly to the tools and categories listed on the Hacker101 Resources page.)*

This checklist helps you build a complete, professional bug bounty and penetration‑testing environment on Kali Linux.

---

## ✅ 1. Tools Already Installed in Kali  
These tools appear on the Hacker101 Resources page and come pre‑installed in Kali:

- **Burp Suite Community Edition**
- **Dirb**
- **Nikto**
- **sqlmap**
- **WhatWeb**
- **Wfuzz**
- **WPScan**
- **Hydra**
- **Wireshark**
- **Nmap**
- **Metasploit Framework**
- **OpenVAS / Greenbone**
- **John the Ripper**
- **Ettercap**

✔ No installation needed.

---

## 📦 2. Tools to Install via `apt`  
These tools are referenced in the Hacker101 resource categories and exist in Kali’s official repositories.

| Tool | Install Command |
|------|-----------------|
| Amass | `sudo apt install amass` |
| Masscan | `sudo apt install masscan` |
| MassDNS | `sudo apt install massdns` |
| Aquatone | `sudo apt install aquatone` |
| EyeWitness | `sudo apt install eyewitness` |
| mitmproxy | `sudo apt install mitmproxy` |
| Recon‑ng | `sudo apt install recon-ng` |
| Knockpy | `sudo apt install knockpy` |
| Radare2 | `sudo apt install radare2` |
| QEMU | `sudo apt install qemu-system` |
| Binwalk | `sudo apt install binwalk` |
| AFL (American Fuzzy Lop) | `sudo apt install afl` |

✔ Safe, stable, and maintained.

---

## 🛠️ 3. Tools to Install from GitHub  
These tools appear in the Hacker101 categories but require manual installation.

### **Recon & Enumeration**
- Subfinder  
- Assetfinder  
- Findomain (local version)  
- dnsgen  
- dnscan  
- dngrep  
- shuffledns  
- httprobe  
- httpx  
- waybackurls  
- gau (getallurls)  
- meg  
- virtual-host-discovery  
- subjack  
- sublert  
- sublist3r  
- teh_s3_bucketeers  
- lazys3  
- lazyrecon  
- recon_profile  
- reconftw  
- osmedeus  
- reconness  

### **Fuzzing & Scanning**
- ffuf  
- nuclei  
- wapiti  
- jok3r  

### **GitHub Monitoring**
- gitGraber  
- commit-stream  
- shhgit  

### **JavaScript / URL Analysis**
- JSParser  
- unfurl  

### **Mobile / Reverse Engineering**
- jadx  
- frida  
- dex2jar  
- MobSF  

Typical installation pattern:

```bash
git clone <repo>
cd <tool>
sudo ./install.sh
