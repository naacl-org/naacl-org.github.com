# Instructions to set up ElectAssist on a web server

This assumes a bare bones CentOS 6 install.

## Set up packages on CentOS 6

    sudo yum check-update
    sudo yum install git
    sudo yum install screen
    sudo yum groupinstall "Development tools"
    sudo yum install zlib-devel bzip2-devel openssl-devel ncurses-devel sqlite-devel readline-devel tk-devel
    sudo yum install mod_ssl openssl
    sudo yum install mod_perl

## Generate self-signed certificate

    # Generate private key 
    openssl genrsa -out ca.key 1024 

    # Generate CSR 
    openssl req -new -key ca.key -out ca.csr

    # Generate Self Signed Key
    openssl x509 -req -days 365 -in ca.csr -signkey ca.key -out ca.crt

    # Copy the files to the correct locations
    sudo cp ca.crt /etc/pki/tls/certs
    sudo cp ca.key /etc/pki/tls/private/ca.key
    sudo cp ca.csr /etc/pki/tls/private/ca.csr

## Update the Apache SSL configuration file

    sudo vi +/SSLCertificateFile /etc/httpd/conf.d/ssl.conf
    # Change the paths to match where the Certificate and Key files are stored:
    SSLCertificateFile /etc/pki/tls/certs/ca.crt
    SSLCertificateKeyFile /etc/pki/tls/private/ca.key

## Enable CGI execution

    sudo vi /etc/httpd/conf/httpd.conf

1. Add ExecCGI to Options of Directory "/var/www/html"
2. Add: AddHandler cgi-script .cgi
3. More steps for mod_perl (copy here from httpd.conf later)

## Check permissions

    sudo chown -R apache:apache /home/anoop/ElectAssist-2014

## Restart httpd

    # Quit and save the file and then restart Apache
    sudo /etc/init.d/httpd restart

## Restart the web server gracefully in case of reboots

    sudo crontab -e
    # edit the crontab file to look like the following:
    # make sure the web server keeps running
    0,15,30,45 * * * * /usr/sbin/apachectl graceful >> /dev/null

# Set up ElectAssist

Email Ulrich Germann <ulrich.germann@gmail.com> to obtain ElectAssist. You will get a tarball ElectAssist-x.y.tgz. These instructions are for version 1.5.

The manual is in ElectAssist/admin/ElectAssist-Manual.html

The following steps can be used to set up ElectAssist running as root (not recommended unless you are on a VM).

1. login as the user (here we assume root) as whom the web server will be running

    sudo bash
    cd $HOME
    tar zxvf ElectAssist-1.5.tgz

2. create a directory for the current year

    cp -r ElectAssist ElectAssist-201x

3. Create files for the election: ElectionParameters.pm and ballot-201x.html based on the files in elections/2014/ElectAssist-files in the naacl github repository.

