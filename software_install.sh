#!/bin/bash
# author:tracyone,tracyone@live.cn

shopt -s expand_aliases
read -p "请输入您的密码:" mypasswd
alias sudo="echo "${mypasswd}" | sudo -S"

# 判断是32位还是64位系统
MACHINE_TYPE=`uname -m`
if [ ${MACHINE_TYPE} == 'x86_64' ]; then
  is_64=1
else
  is_64=0
fi

# {{{ function definition
function AptInstall()
{
	read -n1 -p "Install $1 ?(y/n)" ans
	if [[ $ans =~ [Yy] ]]; then
		sudo apt-get install $1 --allow-unauthenticated -y || AptSignelInstall "$1"
	else
		echo -e  "\nAbort install\n"
	fi
	sleep 2
}

# $1:software list to install..
function AptSingleInstall()
{
for i in $1
do
	sudo apt-get install $i --allow-unauthenticated -y
done
}
# }}}



if [[ -d ~/Work ]]; then
	mkdir -p ~/Work
fi
cd ~/Work

echo "添加仓库------------------------------------"
echo "添加 git 仓库..."
sudo add-apt-repository -y ppa:git-core/ppa
echo "添加 pidgin 仓库..."
sudo add-apt-repository -y ppa:lainme/pidgin-lwqq 
echo "添加 skype 仓库..."
sudo add-apt-repository -y "deb http://archive.canonical.com/ $(lsb_release -sc) partner"
echo "添加darktable 仓库..."
sudo add-apt-repository -y ppa:pmjdebruijn/darktable-release
sudo add-apt-repository -y ppa:pmjdebruijn/darktable-release-plus
echo "添加防止黑屏的软件的ppa..."
sudo add-apt-repository ppa:caffeine-developers/ppa -y
echo "添加RabbitCvs 仓库..."
sudo add-apt-repository ppa:rabbitvcs/ppa -y
echo "添加Nodejs的仓库..."
sudo apt-add-repository ppa:chris-lea/node.js -y
echo "添加nitroshare仓库..."
sudo add-apt-repository ppa:george-edison55/nitroshare -y
echo "添加屏幕录像仓库..."
sudo add-apt-repository ppa:maarten-baert/simplescreenrecorder -y
echo "wireshark仓库..."
sudo add-apt-repository ppa:dreibh/ppa -y
echo "uGet仓库..."
sudo sudo add-apt-repository ppa:plushuang-tw/uget-stable -y
echo "macubuntu主题仓库..."
sudo add-apt-repository ppa:noobslab/themes -y
echo "wiznote的仓库..."
sudo add-apt-repository ppa:wiznote-team -y
echo "Mutate仓库..."
sudo add-apt-repository ppa:mutate/ppa -y
echo "Support i386 architecture"

sudo dpkg --add-architecture i386

echo "更新源...."
sudo apt-get update

echo "更新系统..."
sudo apt-get upgrade -y

echo "安装和配置 git svn等版本管理工具...."
AptInstall "git gitk git-gui git-svn tig"

echo "安装RabbitCVS的依赖..."
AptInstall "python-nautilus python-configobj python-gtk2 python-glade2 python-svn python-dbus python-dulwich subversion meld"

echo "安装RabbitCVS ..."
AptInstall "rabbitvcs-cli  rabbitvcs-core rabbitvcs-gedit rabbitvcs-nautilus3" 

echo "安装compiz特效管理..."
AptInstall "compiz-plugins compiz-plugins-extra compizconfig-settings-manager "

echo "安装 qt4..."
AptInstall "libqt4-dev libqt4-dbg libqt4-gui libqt4-sql qt4-dev-tools qt4-doc qt4-designer qt4-qtconfig qtcreator"

echo "安装java和java运行环境..."
AptInstall "openjdk-7-jdk"

echo "openssh..."
AptInstall "openssh-server"

echo "安装CodeBlock..."
AptInstall "codeblocks g++ wx-common libwxgtk3.0-0 build-essential  wxformbuilder codeblocks-dbg codeblocks-contrib wx3.0-headers  wx3.0-i18n"

echo "安装gimp,Inkscape等图形软件..."
AptInstall "gimp Inkscape Dia darktable"

echo "安装 fcitx 输入法..."
AptInstall "fcitx fcitx-config-gtk fcitx-sunpinyin fcitx-googlepinyin fcitx-module-cloudpinyin"

AptInstall "caffeine openshot keepass2 simplescreenrecorder wireshark aria2 unity-tweak-tool xdotool"

echo "主题相关..."
AptInstall "^mac-ithemes-v[0-9] ^mac-icons-v[0-9]"

echo "安装搜狗输入法..."
if [[ is_64 == 1 ]]; then
	wget -c "http://pinyin.sogou.com/linux/download.php?f=linux&bit=64"  -O sogoupinyin.deb
else
	wget -c "http://pinyin.sogou.com/linux/download.php?f=linux&bit=32"  -O sogoupinyin.deb
fi
sudo dpkg -i sogoupinyin.deb&& rm sogoupinyin.deb

echo "安装VirtualBox"
AptInstall "virtualbox virtualbox-guest-additions-iso vde2"

echo "安装 pidgin ... "
AptInstall "libpurple0 pidgin pidgin-lwqq" 

echo "安装goldendict wiznote等..."
AptInstall "goldendict goldendict-wordnet wiznote"

echo "安装nautils相关..."
AptInstall "nautilus-open-terminal nautilus-actions "

echo "安装其它杂七杂八.."
AptInstall "unrar p7zip-full zhcon xbacklight shutter wmctrl curl mutate"
AptInstall "lm-sensors"
AptInstall "hddtemp"
AptInstall "grive-tools"
AptInstall "gparted vlc skype dconf-editor dconf-cli"
echo "exfat support ..."
AptInstall "exfat-utils"

echo "安装一些趣味命令行"
AptInstall "sl cmatrix oneko libaa-bin toilet cowsay xcowsay xeyes"

AptInstall "nodejs-legacy"
sudo npm install -g hexo

AptInstall "python-software-properties"

echo "嵌入式开发.."
AptInstall "putty"
AptInstall "openbsd-inetd tftp-hpa tftpd-hpa"
AptInstall "nfs-kernel-server"
AptInstall "minicom"
AptInstall "bison flex mtd-utils cmake"
echo "设置tftp..."
mkdir ~/Work/tftpboot
chmod 777 ~/Work/tftpboot
echo -e "RUN_DAEMON=\"yes\"" > tftpd-hpa
echo -e "OPTIONS=\"-l -s -c /home/$(whoami)/Work/tftpboot\"" >> tftpd-hpa
echo -e "TFTP_USERNAME=\"root\"" >> tftpd-hpa
echo -e "TFTP_DIRECTORY=\"/home/$(whoami)/Work/tftpboot\"" >> tftpd-hpa
echo -e "TFTP_ADDRESS=\"0.0.0.0:69\"" >> tftpd-hpa
echo -e "TFTP_OPTIONS=\"--secure\"" >> tftpd-hpa
sudo mv tftpd-hpa /etc/default/tftpd-hpa
sudo service tftpd-hpa restart
echo "设置nfs..."
mkdir ~/Work/nfsroot
chmod 777 ~/Work/nfsroot
echo -e "/home/$(whoami)/Work/nfsroot *(rw,no_root_squash,no_all_squash,sync)" >  exports
sudo mv exports /etc/
sudo exportfs -av
sudo service nfs-kernel-server restart 

echo "安装zsh,tmux等并配置..."
if [[ ! -d "dotfiles" ]];then
   git clone https://github.com/tracyone/dotfiles
fi
cd dotfile;./install.sh;cd -

echo "Install steam..."
AptInstall "steam steam-launcher"

echo "Install chromium and Pepper Flash Player"
AptInstall "chromium-browser"
AptInstall "pepperflashplugin-nonfree"
sudo update-pepperflashplugin-nonfree --install



echo "安装字体...需要很长时间请耐心等待..."
if [[ ! -d "program_font" ]];then
   git clone https://github.com/tracyone/program_font
fi
if [[  $? -eq 0 ]]; then
	sudo chmod -R a+x program_font/*
	sudo mkdir -p /usr/share/fonts/MyFonts
	mkdir ~/.fonts/
	cp ./program_font/* ~/.fonts/
	sudo cp ./program_font/* /usr/share/fonts/MyFonts
	sudo fc-cache -f -v
fi

echo "为gnome-terminal安装solarized主题"
git clone https://github.com/Anthony25/gnome-terminal-colors-solarized && cd gnome-terminal-colors-solarized && ./install.sh ; cd -

if [[ ! -d "vim_conf" ]]; then
	git clone https://github/tracyone/vim vim_conf
fi
if [[ $? -eq 0 ]]; then
	cd vim_conf ;./build_vim.sh all
	mkdir -p ~/.vim/autoload
	curl -fLo ~/.vim/autoload/plug.vim https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim && gvim -c :PlugInstall &
	cd -
fi

echo "避免ubuntu字体发虚..."
sudo apt-get remove fonts-arphic-ukai ttf-wqy-zenhei fonts-arphic-uming -y

echo "编译安装其它软件"
mkdir ~/Work/InstallPurpose
cd ~/Work/InstallPurpose
echo "编译安装ag.."
if [[ ! -d the_silver_searcher ]]; then
	git clone https://github.com/ggreer/the_silver_searcher
fi
AptInstall "automake pkg-config libpcre3-dev zlib1g-dev liblzma-dev"
cd the_silver_searcher && ./build.sh && sudo make install ;cd -

echo "清除工作...."
sudo apt-get autoremove -y
sudo apt-get autoclean
sudo apt-get clean
echo "温馨提示：电脑将在30分钟后关机.."
sudo shutdown -h 30

# vim: set ft=sh fdm=marker foldlevel=0 foldmarker&: 
