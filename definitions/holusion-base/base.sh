# Update the box
# Makes sure boot finished before beginning
sleep 50
WAITLINE="Waiting for firstboot to complete."
echo -ne "$WAITLINE\r"
while [ ! -f /etc/firstBoot_OK ] ;
do
  WAITLINE="$WAITLINE."
  echo -ne "$WAITLINE\r"
  sleep 10

done
echo "firstboot completed"
#Redoundant update as of now, but better update twice than not
apt-get -y update
#Everything here will probably be already installed but it doesn't hurt to check...
export DEBIAN_FRONTEND=noninteractive
#Libssl is problematic due to updates caused by heartbleed bug
apt-get -y install linux-headers-$(uname -r) build-essential libssl1.0.0 zlib1g-dev libreadline-gplv2-dev sudo curl unzip
apt-get -y libssl-dev



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
