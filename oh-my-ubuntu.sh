#!/bin/bash
# author:tracyone,tracyone@live.cn
# ./oh-my-ubuntu.sh <path of ini file>
# Core theory:git can read or write standard ini file easily.
# For example:
# read :git config section.key
# write :git config section.key value 

shopt -s expand_aliases
read -p "请输入您的密码:" mypasswd
alias sudo="echo "${mypasswd}" | sudo -S"

LOG_FILE="omu.log"
# 设置分隔符为换行符号
OLD_IFS="$IFS" 
IFS=$'\x0A' 
rm -f ${LOG_FILE}


# {{{ function definition

# $1:software list to install..
function AptSingleInstall()
{
    IFS=" "
    for i in $1
    do
        sudo apt-get install $i --allow-unauthenticated -y || echo -e "apt-get install failed : $i\n" >> ${LOG_FILE}
    done
    IFS=${OLD_IFS}
}

function AptInstall()
{
	read -n1 -p "Install $1 ?(y/n)" ans
	if [[ $ans =~ [Yy] ]]; then
		sudo apt-get install $1 --allow-unauthenticated -y || AptSingleInstall "$1"
	else
		echo -e  "\nAbort install\n"
	fi
	sleep 2
}

# $1:section.key
function Readinit()
{
    echo 0;
}

# }}}

if [[ $# -eq 1 ]]; then
	if [[ ! -f $1 ]]; then
		echo -e "\nFile $1 not exist!\n"
		exit 3
	fi
	GIT_CONFIG="$1"
else
	echo -e "\nWrong usage!!\n"
	echo -e "\n./oh-my-ubuntu.sh <path of ini file>\n"
	exit 3
fi
echo -e "\nUse Config file: ${GIT_CONFIG}\n"
export GIT_CONFIG

which git > /dev/null
if [[ $? -ne 0 ]]; then
    echo -e "Install git ..."
	sudo apt-get update
	sudo apt-get install git -y
	if [[ $? -ne 0 ]]; then
		echo -e "\nInstall git failed\n"
		exit 3
	fi
fi

ppa_list=$(git config --get-all repo.ppa)
echo "adding ppa ..."
for i in ${ppa_list}; do
    if [[ $i != "" ]]; then
        echo -e "\nadd ppa $i\n"
        sudo add-apt-repository -y $i || echo -e "apt-add-repository failed : $i\n" >> ${LOG_FILE}
        sleep 1
    fi
done

sudo dpkg --add-architecture i386
echo "更新源...."
sudo apt-get update
echo "更新系统..."
sudo apt-get upgrade -y

deb_list=$(git config --get-all apt.packages)
for i in ${deb_list}; do
	if [[ $i != "" ]]; then
		echo -e "\ninstall software  $i\n"
        sleep 1
        AptInstall $i
        sleep 1
	fi
done

echo "清除工作...."
sudo apt-get autoremove -y
sudo apt-get autoclean
sudo apt-get clean

# vim: set ft=sh fdm=marker foldlevel=0 foldmarker&: 
