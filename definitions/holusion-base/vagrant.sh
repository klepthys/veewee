# Set up Vagrant.

date > /etc/vagrant_box_build_time

# Create the user vagrant with password vagrant
useradd -G sudo -p $(perl -e'print crypt("vagrant", "vagrant")') -m -s /bin/bash -N vagrant -d /home/vagrant

apt-get -y install curl

#Make sure sshd doesn't start before postinstall is finished!

sed -i '/# Required-Start:/c\#  Required-Start: $all' /etc/init.d/ssh

# Install vagrant keys
mkdir -pm 700 /vagrant/.ssh
curl -Lo /vagrant/.ssh/authorized_keys \
  'https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub'
chmod 0600 /vagrant/.ssh/authorized_keys
chown -R vagrant /vagrant/.ssh

# Customize the message of the day
echo 'Welcome to your Vagrant-built virtual machine.' > /var/run/motd

# Install NFS client
#apt-get -y install nfs-common
