#!/data/data/com.termux/files/usr/bin/bash

#Setup
shopt -s expand_aliases
alias fx='echo -e'

#Greetings
echo
fx "\e[93mThis script will install Java in Termux."
fx "\e[93mLibraries compiled by \e[32mEFX-tv\e[93m, script written by \e[32mHax4us, EFX Tv \e[93mand \e[32mMasterDevX\e[93m."
echo

#Checking for existing Java installation
if [ -e $PREFIX/bin/java ]
then
	fx "\e[32mJava is already installed!"
	echo
	exit
else
	#Checking, whether is someone trying to cheat and simplyfy their installation it on Linux (i.e. x86 (not listad, as you can see) machine) using this script, which have no reason to work.
	case `dpkg --print-architecture` in
	aarch64)
		archname="aarch64"; tag="v8" ;;
	arm64)
		archname="aarch64"; tag="v8" ;;
	armhf)
		archname="arm"; tag="v8-151" ;;
	armv7l)
		archname="arm"; tag="v8-151" ;;
	arm)
		archname="arm"; tag="v8-151" ;;
	*)
		fx "\e[91mERROR: Unknown architecture."; echo; exit ;;
	esac
	
	#Actual installation
	fx "\e[32m[*] \e[34mDownloading JDK-8 (~70Mb) for ${archname}...  It will take some time"
  sleep 3
	wget https://github.com/Hax4us/java/releases/download/${tag}/jdk8_${archname}.tar.gz -q --show-progress
	
	fx "\e[32m[*] \e[34mMoving JDK to system..."
	mv jdk8_${archname}.tar.gz $PREFIX/share
	
	fx "\e[32m[*] \e[34mExtracting JDK..."
	cd $PREFIX/share
	tar -xhf jdk8_${archname}.tar.gz
	
	fx "\e[32m[*] \e[34mSeting-up %JAVA_HOME%..."
	export JAVA_HOME=$PREFIX/share/jdk8
	echo "export JAVA_HOME=$PREFIX/share/jdk8" >> $HOME/.profile
	
	fx "\e[32m[*] \e[34mCoping Java wrapper scripts to bin..."
	#I'm not 100% sure, but getting rid of bin contnent MAY cause some issues with %JAVA_HOME%, thus it's no longer moved - copied instead. Sorry to everyone short on storage.
	cp bin/* $PREFIX/bin
	
	fx "\e[32m[*] \e[34mCleaning up temporary files..."
	rm -rf $HOME/installjava
	rm -rf $PREFIX/share/jdk8_${archname}.tar.gz
	rm -rf $PREFIX/share/bin
	
	echo
	fx "\e[32mJava has been successfully installed!\e[39m"
	echo "Enjoy your day :) by EFX Tv"
	echo
fi
