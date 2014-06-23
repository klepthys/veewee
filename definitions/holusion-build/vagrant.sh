# Set up Vagrant.

date > /etc/vagrant_box_build_time
HOME=/home/vagrant/
# Create the user vagrant with password vagrant
useradd -G sudo -p $(perl -e'print crypt("vagrant", "vagrant")') -m -s /bin/bash -N vagrant -d $HOME


# Install vagrant keys
mkdir -pm 700 $HOME/.ssh
curl -Lo $HOME/.ssh/authorized_keys \
  'https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub'
chmod 0600 $HOME/.ssh/authorized_keys
chown -R vagrant $HOME/.ssh

# Customize the message of the day
echo 'Welcome to your Vagrant-built virtual machine.' > /var/run/motd

# Install NFS client
#apt-get -y install nfs-common
