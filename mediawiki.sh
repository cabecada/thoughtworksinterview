
apt install software-properties-common 
add-apt-repository ppa:ondrej/php
add-apt-repository ppa:ondrej/apache2
apt-get update
apt install apache2
apt install php7.3 php7.3-mysql libapache2-mod-php7.3 php7.3-xml php7.3-mbstring php7.3-apcu php7.3-intl  php7.3-gd php7.3-cli php7.3-curl
php -v
apt install mariadb-server
mysql_secure_installation
mysql -u root -p
cd /var/www/html/
wget https://releases.wikimedia.org/mediawiki/1.32/mediawiki-1.32.1.tar.gz
tar xf mediawiki-1.32.1.tar.gz 
mv mediawiki-1.32.1 mediawiki
