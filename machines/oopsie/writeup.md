#### Writeup – Oopsie

## Attack Path
1. Nmap scan → Port 80
2. Login using the provided link and overwrite cookies with admin settings
3. Request the shell in the browser and setup a listener
4. Activate the shell and login to robert super account
5. Change the execution path to tmp and update PATH variable
