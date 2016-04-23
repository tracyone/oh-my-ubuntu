# This is The Ubuntu Way

Make sure your ubuntu connect to the internet then run:

```bash
./oh-my-ubuntu.sh ./config/ubuntu_16.04.ini
```

It will install all my favorite softwares automatically specified by `.config/ubuntu_16.04.ini`

You can modify `./config/ubuntu_16.04.ini` according to your actual environment.

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
