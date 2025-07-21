#This script uses the openssl command-line tool to generate private keys and non-person entity certificates for four servers. 
#It generates a private key for each server using the genpkey command, creates a certificate signing request (CSR) using the 
#req command, and finally creates the non-person entity certificate using the x509 command. The script also cleans up the 
#intermediate CSR files at the end.

#!/bin/bash

# Variables for certificate information
domain1="server1.example.com"
domain2="server2.example.com"
domain3="server3.example.com"
domain4="server4.example.com"

# Create private keys for each server
openssl genpkey -algorithm RSA -out $domain1.key
openssl genpkey -algorithm RSA -out $domain2.key
openssl genpkey -algorithm RSA -out $domain3.key
openssl genpkey -algorithm RSA -out $domain4.key

# Create certificate signing request (CSR) for each server
openssl req -new -key $domain1.key -out $domain1.csr -subj "/CN=$domain1"
openssl req -new -key $domain2.key -out $domain2.csr -subj "/CN=$domain2"
openssl req -new -key $domain3.key -out $domain3.csr -subj "/CN=$domain3"
openssl req -new -key $domain4.key -out $domain4.csr -subj "/CN=$domain4"

# Create non-person entity certificates for each server
openssl x509 -req -days 365 -in $domain1.csr -signkey $domain1.key -out $domain1.crt
openssl x509 -req -days 365 -in $domain2.csr -signkey $domain2.key -out $domain2.crt
openssl x509 -req -days 365 -in $domain3.csr -signkey $domain3.key -out $domain3.crt
openssl x509 -req -days 365 -in $domain4.csr -signkey $domain4.key -out $domain4.crt

# Clean up intermediate files
rm $domain1.csr $domain2.csr $domain3.csr $domain4.csr
