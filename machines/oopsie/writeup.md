# Writeup – Oopsie

## Attack Path
1. Nmap scan
   ```bash
   nmap -sC -sV 10.129.16.117
   ```
2. Login using the provided link and overwrite cookies with admin settings
   Go to http://10.129.16.117/cdn-cgi/login/ in the browser. Navigate to Uploads. Use Firefox Inspect option to update the cookies to get admin access 
3. Request the shell in the browser and setup a listener
4. Activate the shell and login to robert super account
5. Change the execution path to tmp and update PATH variable
