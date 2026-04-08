#!/bin/bash

domain=$1

mkdir -p recon/$domain
cd recon/$domain

echo "[+] Subdomain Enumeration"
subfinder -d $domain -all -recursive -o subs.txt
amass enum -passive -d $domain >> subs.txt
assetfinder --subs-only $domain >> subs.txt

cat subs.txt | sort -u > final-subs.txt

echo "[+] Probing Live Hosts"
httpx -l final-subs.txt -silent -title -tech-detect -status-code -o live.txt

echo "[+] Crawling URLs"
cat live.txt | waybackurls > wayback.txt
cat live.txt | gau >> wayback.txt

cat wayback.txt | sort -u > final-urls.txt

echo "[+] Extracting Parameters"
cat final-urls.txt | grep "=" > params.txt

echo "[+] JS Files"
cat final-urls.txt | grep ".js" > js.txt
