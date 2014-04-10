# Update the box
# Make sure firstboot script have had time to run
sleep 30

#Everything here will probably be already installed but it doesn't hurt to check...
apt-get -y update
apt-get -y install linux-headers-$(uname -r) build-essential
apt-get -y install zlib1g-dev libssl-dev libreadline-gplv2-dev sudo
apt-get -y install curl unzip

