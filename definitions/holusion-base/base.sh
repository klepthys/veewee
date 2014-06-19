# Update the box
# Makes sure boot finished before beginning
sleep 50
apt-get -y update
while fuser /var/lib/dpkg/lock >/dev/null 2>&1 ; do
  echo "apt-get still locked. Waiting..."
  sleep 10
done
#Libssl is problematic due to updates caused by heartbleed bug
apt-get -y install linux-headers-$(uname -r) build-essential libssl1.0.0 zlib1g-dev libreadline-gplv2-dev sudo curl unzip
apt-get -y libssl-dev

#Everything here will probably be already installed but it doesn't hurt to check...
export DEBIAN_FRONTEND=noninteractive

# Set up sudo
echo 'vagrant ALL=NOPASSWD:ALL' > /etc/sudoers.d/vagrant

# Tweak sshd to prevent DNS resolution (speed up logins)
echo 'UseDNS no' >> /etc/ssh/sshd_config

# Remove 5s grub timeout to speed up booting
#Should be done by default install...
cat <<EOF > /etc/default/grub
# If you change this file, run 'update-grub' afterwards to update
# /boot/grub/grub.cfg.

GRUB_DEFAULT=0
GRUB_TIMEOUT=0
GRUB_DISTRIBUTOR=`lsb_release -i -s 2> /dev/null || echo Debian`
GRUB_CMDLINE_LINUX_DEFAULT="quiet"
GRUB_CMDLINE_LINUX="debian-installer=en_US"
EOF

update-grub
