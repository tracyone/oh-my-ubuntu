
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

**Easy to use**.


Make sure your ubuntu connect to the internet then run:

```bash
./oh-my-ubuntu.sh -f ./config/ubuntu_16.04.ini
```

It will ask you whether prompt or not, if you choose `y`, then all the software will install **automatically**.

If you choose `n`, then you can confirm every item before it start install.

It will install all my favorite softwares specified by `.config/ubuntu_16.04.ini`

You can modify `./config/ubuntu_16.04.ini` according to your actual environment. see [INI file format](#ini-file-format).

# Feature

1. You can install software by apt, download deb packags from internet and build from source.**oh-my-ubuntu** will deal with every error situation property(ie. dependent packags error)

2. You can maintain source code easliy through **oh-my-ubuntu**,before install software from source code,**oh-my-ubuntu** will detect whether the directory of specified source is exist in `${SRC_DIR}`,if yes,**oh-my-ubuntu** will try to update it then install.

3. You only need to input passwd **one time** and it will never invaild until the end of **oh-my-ubuntu** process.

# Usage

```bash
./oh-my-ubuntu.sh [-f <path of ini file>] [-a all|ppa|apt|download|build] [-h]"
```

`-f`: specified the path of ini file

`-h`: Show the usage of oh-my-ubuntu

`-a`: You can execute one of following function alone.


1. ppa:      add ppa then update apt source
2. apt:      Install packags through `apt-ght install`
3. download: Download deb file from internet then install.
3. build:    build and install software from source code (Currently only support get source code from git server like github or gitlab)

You can call `./oh-my-ubuntu.sh` without any argument:

Default argument of `-f` option is `config/ubuntu_16.04.ini`。

Default argument of `-a` option is `all`.

All the source code will install to the path specified by variable `SRC_DIR` (Default is `${HOME}/Work/Source`).

If the source code is aleady exist, then oh-my-ubuntu will try to update it then install.

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
