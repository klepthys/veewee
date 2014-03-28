#!/bin/sh
set -e
if [ -d $WORKSPACE ] ; then
	echo "changing current working directory to : $WORKSPACE"
	cd $WORKSPACE
fi
#Need to check if a rebuild is necessary.
if [ -z $1 ] ; then
	echo "Need definition name as arg #1, got : $1"
	exit 1
elif [ ! -d "definitions/$1" ] ; then
	echo "definitions/$1 does not exist. Exiting"
	exit 1
else
	echo "building for definition : $1"
	DEFINITION=$1
fi

if [ $USE_XVNC = true ] ; then
	#Check for Xvnc
	 [ -z `which Xvnc` ] || XVNC=Xvnc
	 [ -z `which Xvnc4` ] || XVNC=Xvnc4
	[ ! -f "ephemeral-x.sh" ] || wget -O ephemeral-x.sh https://raw.github.com/jordansissel/xdotool/master/t/ephemeral-x.sh
	echo "XVNC exec used  : $XVNC"
else
	echo "not trying to use a GUI : set USE_XVNC to true to enable it"
fi

# Run inside Xvnc if possible. This lets us observe the installation process
# if it's broken.
if [ ! -z $XVNC ] ; then
	echo "building box $DEFINITION with xvnc"
	echo "using \"holobox\" as VNC password"
	yes "holobox" | vncpasswd notsosecret
    XVNCFLAGS="-geometry 1024x768 -AcceptKeyEvents=off -AcceptPointerEvents=off -AcceptCutText=off -SendCutText=off -PasswordFile=notsosecret"
	 sh ephemeral-x.sh -x "$XVNC $XVNCFLAGS" bundle exec veewee vbox build "$DEFINITION" --force --auto
else
	echo "building box $DEFINITION in nogui mode"
	bundle exec veewee vbox build "$DEFINITION" --force --auto --nogui
fi
echo "validating box. Seems to be not failing as it should in case of error."

#bundle exec veewee vbox validate 'holusion-base'

bundle exec veewee vbox export $DEFINITION --force

