
```

       _                                       _                 _         
  ___ | |__        _ __ ___  _   _       _   _| |__  _   _ _ __ | |_ _   _ 
 / _ \| '_ \ _____| '_ ` _ \| | | |_____| | | | '_ \| | | | '_ \| __| | | |
| (_) | | | |_____| | | | | | |_| |_____| |_| | |_) | |_| | | | | |_| |_| |
 \___/|_| |_|     |_| |_| |_|\__, |      \__,_|_.__/ \__,_|_| |_|\__|\__,_|
                             |___/                                         
```


# This is The Ubuntu Way

A software-install shell script for **Ubuntu** that is:

**Customizable**

and

**Easy to use**


Make sure your ubuntu connect to the internet then run:

```bash
./oh-my-ubuntu.sh -f ./config/ubuntu_16.04.ini
```

It will ask you whether prompt or not,if you choose `y`,then all the software will install **automatically**.

If you choose `n`,then you can confirm every item before it start install.

It will install all my favorite softwares specified by `.config/ubuntu_16.04.ini`

You can modify `./config/ubuntu_16.04.ini` according to your actual environment. see [INI file formate](#ini-file-format)

# Usage

```bash
./oh-my-ubuntu.sh [-f <path of ini file>] [-a all|ppa|apt|download|build]"
```

`-f`:specified the path of ini file

`-a`:You can execute one of following function alone.

1. ppa:add ppa 
2. apt:Install packags through `apt-ght install`
3. download:Download deb file from internet then install.
3. build:build and install software from source code (Currently only support get source code from git server like github or gitlab)

You can call `./oh-my-ubuntu.sh` without any argument:

Default argument of `-f` option is `config/ubuntu_16.04.ini`。

Default argument of `-a` option is `all`.

## INI file format

I use **git** to read or write standard ini file.

**For example**

- read :git config section.key
- write :git config section.key value 

---

In section `repo`,add your favorite ppa:

```ini
 ppa = ppa:neovim-ppa/unstable
```

In section `apt`,add your favorite packags separated by space

```ini
 packages = virtualbox virtualbox-guest-additions-iso vde2
```

In section `download`,add the deb file download url:

```ini
 url = http://download.teamviewer.com/download/teamviewer_i386.deb
```


In section `build`,There are three string separated by comma that assigned to key `gitsrc`.

- The url of software's in git server,
- Dependence packags that can be installed by `apt-get install`. **[optional]**
- Install command

```ini
 gitsrc=https://github.com/ggreer/the_silver_searcher.git , automake pkg-config libpcre3-dev zlib1g-dev liblzma-dev , ./build.sh && sudo make install
```

## Best Partiton Scheme for Ubuntu

1. 由于不可能是多系统`/boot`和`/`和`/usr`，这三个目录将在同个分区中。

2. 由于我是8GB内存，所以不准备开swap。

3. /opt用原笔记本hdd的分区

4. /home也用原笔记本的分区

5. 删除原笔记本hdd的/usr和/和swap和/boot，这样共空出310GB的空间，将给windows使用。

6. 4k对齐，我们直接用gparted分区按默认将整个分区格式化即可，默认前面留得空间是4k对齐的。

7. 分区表类型我们选mbr，因为我的笔记本式支持的这种分区表支持的，而且gpt的优点对于这个硬盘来说和分区方案来说等于没有。

8. 制作系统启动U盘，使用ubuntu自带的**启动盘创建器**

#  Things to do after installing Ubuntu

1. 安装显卡驱动，本笔记本（y400）是nvidia gt650m直接在**附加驱动**里面更新即可。在次之前必须先执行`sudo apt-get update`
                    
