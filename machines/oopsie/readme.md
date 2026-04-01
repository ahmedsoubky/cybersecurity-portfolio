1. Machine Name:
Oopsie

2. Overview:
Oopsie is a very easy Linux machine that highlights the impact of information disclosure and broken access control in web applications. Website enumeration reveals a guest login with manipulatable cookies and user IDs allowing escalation to an admin role and access to a file upload feature. A PHP reverse shell is then uploaded to gain an initial foothold. Further enumeration exposes hardcoded credentials enabling lateral movement to another user. Finally, privilege escalation is achieved by abusing a misconfigured SUID binary through PATH hijacking.

3. Difficulty:
Very easy

4. OS: Linux

5. IP:
10.10.X.X

6. Skills:
nmap, reverse shell, upload vulnerabilities
