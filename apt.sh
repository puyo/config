sudo cp sources.list.d/*.list /etc/apt/sources.list.d/

wget -q http://wine.budgetdedicated.com/apt/387EE263.gpg -O- | sudo apt-key add -
sudo wget http://wine.budgetdedicated.com/apt/sources.list.d/jaunty.list -O /etc/apt/sources.list.d/winehq.list

sudo apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 0x1d7e9dd033e89ba781e32a24b9f1c432ae74ae63

wget -O - http://deb.opera.com/archive.key | sudo apt-key add -

sudo aptitude update
sudo aptitude safe-upgrade
cat package.list | sudo xargs aptitude -y install

sudo dontzap -d
