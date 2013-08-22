sudo cp sources.list.d/*.list /etc/apt/sources.list.d/
wget -O - http://deb.opera.com/archive.key | sudo apt-key add -
sudo apt-get update
sudo apt-get install aptitude
cat packages.list | sudo xargs aptitude -y --without-recommends install
