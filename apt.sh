sudo sh -c 'echo "deb http://deb.opera.com/opera/ stable non-free" >> /etc/apt/sources.list.d/opera.list'
wget -O - http://deb.opera.com/archive.key | sudo apt-key add -

sudo sh -c 'echo "deb http://repository.spotify.com stable non-free" >> /etc/apt/sources.list.d/spotify.list'
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 94558F59

sudo apt-get update
sudo apt-get install aptitude

cat packages.list | sudo xargs aptitude -y --without-recommends install
