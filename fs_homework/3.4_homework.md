###Домашнее задание к занятию "3.5. Файловые системы"

1. Прочитал.
2. Так как hardlink это ссылка на тот же самый файл и имеет тот же inode то права будут одни и теже.
3. 
```
    Disk /dev/vdb: 2.45 GiB, 2621440000 bytes, 5120000 sectors
    Units: sectors of 1 * 512 = 512 bytes
    Sector size (logical/physical): 512 bytes / 512 bytes
    I/O size (minimum/optimal): 512 bytes / 512 bytes


    Disk /dev/vdc: 2.45 GiB, 2621440000 bytes, 5120000 sectors
    Units: sectors of 1 * 512 = 512 bytes
    Sector size (logical/physical): 512 bytes / 512 bytes
    I/O size (minimum/optimal): 512 bytes / 512 bytes
```
4. 
```
    Command (m for help): p
    Disk /dev/vdb: 2.45 GiB, 2621440000 bytes, 5120000 sectors
    Units: sectors of 1 * 512 = 512 bytes
    Sector size (logical/physical): 512 bytes / 512 bytes
    I/O size (minimum/optimal): 512 bytes / 512 bytes
    Disklabel type: gpt
    Disk identifier: 72FEAC42-2B22-1C49-AA7B-6B5CC12B4999

    Device       Start     End Sectors  Size Type
    /dev/vdb1     2048 4196351 4194304    2G Linux filesystem
    /dev/vdb2  4196352 5119966  923615  451M Linux filesystem
```

```
    Command (m for help): p
    Disk /dev/vdc: 2.45 GiB, 2621440000 bytes, 5120000 sectors
    Units: sectors of 1 * 512 = 512 bytes
    Sector size (logical/physical): 512 bytes / 512 bytes
    I/O size (minimum/optimal): 512 bytes / 512 bytes
    Disklabel type: gpt
    Disk identifier: 58F6EB5D-55D0-3A4E-A90A-074CD34215A4

    Device       Start     End Sectors  Size Type
    /dev/vdc1     2048 4196351 4194304    2G Linux filesystem
    /dev/vdc2  4196352 5119966  923615  451M Linux filesystem
```
5. 
```
    root@netology:/home/netology# sfdisk -d /dev/vdb | sfdisk --force /dev/vdc
    Checking that no-one is using this disk right now ... OK

    Disk /dev/vdc: 2.45 GiB, 2621440000 bytes, 5120000 sectors
    Units: sectors of 1 * 512 = 512 bytes
    Sector size (logical/physical): 512 bytes / 512 bytes
    I/O size (minimum/optimal): 512 bytes / 512 bytes

    >>> Script header accepted.
    >>> Script header accepted.
    >>> Script header accepted.
    >>> Script header accepted.
    >>> Script header accepted.
    >>> Script header accepted.
    >>> Created a new GPT disklabel (GUID: 01C316CD-D820-2A4E-8191-7D7908711955).
    /dev/vdc1: Created a new partition 1 of type 'Linux filesystem' and of size 2 GiB.
    /dev/vdc2: Created a new partition 2 of type 'Linux filesystem' and of size 451 MiB.
    /dev/vdc3: Done.

    New situation:
    Disklabel type: gpt
    Disk identifier: 01C316CD-D820-2A4E-8191-7D7908711955

    Device       Start     End Sectors  Size Type
    /dev/vdc1     2048 4196351 4194304    2G Linux filesystem
    /dev/vdc2  4196352 5119966  923615  451M Linux filesystem

    The partition table has been altered.
    Calling ioctl() to re-read partition table.
    Syncing disks.
```
6. 
```
    root@netology:/home/netology# mdadm --detail /dev/md0
    /dev/md0:
               Version : 1.2
         Creation Time : Mon Oct 24 12:57:31 2022
            Raid Level : raid1
            Array Size : 2094080 (2045.00 MiB 2144.34 MB)
         Used Dev Size : 2094080 (2045.00 MiB 2144.34 MB)
          Raid Devices : 2
         Total Devices : 2
           Persistence : Superblock is persistent

           Update Time : Mon Oct 24 12:57:41 2022
                 State : clean 
        Active Devices : 2
       Working Devices : 2
        Failed Devices : 0
         Spare Devices : 0

    Consistency Policy : resync

                  Name : netology:0  (local to host netology)
                  UUID : 6b66f3d8:59d6536a:42056bce:b6025f5a
                Events : 17

        Number   Major   Minor   RaidDevice State
           0     252       17        0      active sync   /dev/vdb1
           1     252       33        1      active sync   /dev/vdc1
```
7. 
```
    root@netology:/home/netology# mdadm --detail /dev/md1
    /dev/md1:
               Version : 1.2
         Creation Time : Mon Oct 24 12:59:37 2022
            Raid Level : raid0
            Array Size : 918528 (897.00 MiB 940.57 MB)
          Raid Devices : 2
         Total Devices : 2
           Persistence : Superblock is persistent
    
           Update Time : Mon Oct 24 12:59:37 2022
                 State : clean 
        Active Devices : 2
       Working Devices : 2
        Failed Devices : 0
         Spare Devices : 0
    
                Layout : -unknown-
            Chunk Size : 512K
    
    Consistency Policy : none
    
                  Name : netology:1  (local to host netology)
                  UUID : 1da665e7:37d1bad5:9076b2d8:6e659229
                Events : 0
    
        Number   Major   Minor   RaidDevice State
           0     252       18        0      active sync   /dev/vdb2
           1     252       34        1      active sync   /dev/vdc2
```
8. 
```
    root@netology:/home/netology# pvscan 
      PV /dev/vda3   VG ubuntu-vg       lvm2 [<9.11 GiB / 0    free]
      PV /dev/md0                       lvm2 [<2.00 GiB]
      PV /dev/md1                       lvm2 [897.00 MiB]
      Total: 3 [11.98 GiB] / in use: 1 [<9.11 GiB] / in no VG: 2 [2.87 GiB]
```
9. 
```
    root@netology:/home/netology# vgcreate RAID_test /dev/md0 /dev/md1
      Volume group "RAID_test" successfully created
    root@netology:/home/netology# pvs
      PV         VG        Fmt  Attr PSize   PFree  
      /dev/md0   RAID_test lvm2 a--   <2.00g  <2.00g
      /dev/md1   RAID_test lvm2 a--  896.00m 896.00m
      /dev/vda3  ubuntu-vg lvm2 a--   <9.11g      0
```
10. 
```
    root@netology:/home/netology# lvcreate -L 100M RAID_test /dev/md1
      Logical volume "lvol0" created.
    root@netology:/home/netology# vgs
      VG        #PV #LV #SN Attr   VSize  VFree
      RAID_test   2   1   0 wz--n-  2.87g 2.77g
      ubuntu-vg   1   1   0 wz--n- <9.11g    0 
    root@netology:/home/netology# lvs
      LV        VG        Attr       LSize   Pool Origin Data%  Meta%  Move Log Cpy%Sync Convert
      lvol0     RAID_test -wi-a----- 100.00m                                                    
      ubuntu-lv ubuntu-vg -wi-ao----  <9.11g
```
11. 
```
    root@netology:/home/netology# mkfs.ext4 /dev/RAID_test/lvol0
    mke2fs 1.45.5 (07-Jan-2020)
    Discarding device blocks: done                            
    Creating filesystem with 25600 4k blocks and 25600 inodes
    
    Allocating group tables: done                            
    Writing inode tables: done                            
    Creating journal (1024 blocks): done
    Writing superblocks and filesystem accounting information: done
```
12. 
```
    root@netology:/home/netology# mkdir /tmp/new
    root@netology:/home/netology# mount  /dev/RAID_test/lvol0 /tmp/new
```
13. 
```
    root@netology:/home/netology# wget https://mirror.yandex.ru/ubuntu/ls-lR.gz -O /tmp/new/test.gz
    --2022-10-24 13:21:39--  https://mirror.yandex.ru/ubuntu/ls-lR.gz
    Resolving mirror.yandex.ru (mirror.yandex.ru)... 213.180.204.183, 2a02:6b8::183
    Connecting to mirror.yandex.ru (mirror.yandex.ru)|213.180.204.183|:443... connected.
    HTTP request sent, awaiting response... 200 OK
    Length: 22354723 (21M) [application/octet-stream]
    Saving to: ‘/tmp/new/test.gz’
    
    /tmp/new/test.gz                                                                                100%[======================================================================================================================================================================================================================================================>]  21.32M  4.86MB/s    in 4.3s    
    
    2022-10-24 13:21:43 (4.96 MB/s) - ‘/tmp/new/test.gz’ saved [22354723/22354723]
    
    root@netology:/home/netology# ll /tmp/new/
    total 21856
    drwxr-xr-x  3 root root     4096 Oct 24 13:21 ./
    drwxrwxrwt 14 root root     4096 Oct 24 13:20 ../
    -rw-r--r--  1 root root 22354723 Oct 24 12:59 test.gz
```
14. 
```
    root@netology:/home/netology# lsblk 
    NAME                      MAJ:MIN RM  SIZE RO TYPE  MOUNTPOINT
    loop0                       7:0    0 61.9M  1 loop  /snap/core20/1328
    loop1                       7:1    0 63.2M  1 loop  /snap/core20/1623
    loop2                       7:2    0 67.2M  1 loop  /snap/lxd/21835
    loop3                       7:3    0 67.8M  1 loop  /snap/lxd/22753
    loop4                       7:4    0   48M  1 loop  /snap/snapd/17336
    loop5                       7:5    0   48M  1 loop  /snap/snapd/17029
    vda                       252:0    0   10G  0 disk  
    ├─vda1                    252:1    0    1M  0 part  
    ├─vda2                    252:2    0  907M  0 part  /boot
    └─vda3                    252:3    0  9.1G  0 part  
      └─ubuntu--vg-ubuntu--lv 253:0    0  9.1G  0 lvm   /
    vdb                       252:16   0  2.5G  0 disk  
    ├─vdb1                    252:17   0    2G  0 part  
    │ └─md0                     9:0    0    2G  0 raid1 
    └─vdb2                    252:18   0  451M  0 part  
      └─md1                     9:1    0  897M  0 raid0 
        └─RAID_test-lvol0     253:1    0  100M  0 lvm   /tmp/new
    vdc                       252:32   0  2.5G  0 disk  
    ├─vdc1                    252:33   0    2G  0 part  
    │ └─md0                     9:0    0    2G  0 raid1 
    └─vdc2                    252:34   0  451M  0 part  
      └─md1                     9:1    0  897M  0 raid0 
        └─RAID_test-lvol0     253:1    0  100M  0 lvm   /tmp/new
```
15. 
```
    root@netology:/home/netology# gzip -t /tmp/new/test.gz
    root@netology:/home/netology# echo $?
    0
```
16. 
```
    root@netology:/home/netology# pvmove /dev/md1
      /dev/md1: Moved: 88.00%
    root@netology:/home/netology# lsblk 
    NAME                      MAJ:MIN RM  SIZE RO TYPE  MOUNTPOINT
    loop0                       7:0    0 61.9M  1 loop  /snap/core20/1328
    loop1                       7:1    0 63.2M  1 loop  /snap/core20/1623
    loop2                       7:2    0 67.2M  1 loop  /snap/lxd/21835
    loop3                       7:3    0 67.8M  1 loop  /snap/lxd/22753
    loop4                       7:4    0   48M  1 loop  /snap/snapd/17336
    loop5                       7:5    0   48M  1 loop  /snap/snapd/17029
    vda                       252:0    0   10G  0 disk  
    ├─vda1                    252:1    0    1M  0 part  
    ├─vda2                    252:2    0  907M  0 part  /boot
    └─vda3                    252:3    0  9.1G  0 part  
      └─ubuntu--vg-ubuntu--lv 253:0    0  9.1G  0 lvm   /
    vdb                       252:16   0  2.5G  0 disk  
    ├─vdb1                    252:17   0    2G  0 part  
    │ └─md0                     9:0    0    2G  0 raid1 
    │   └─RAID_test-lvol0     253:1    0  100M  0 lvm   /tmp/new
    └─vdb2                    252:18   0  451M  0 part  
      └─md1                     9:1    0  897M  0 raid0 
    vdc                       252:32   0  2.5G  0 disk  
    ├─vdc1                    252:33   0    2G  0 part  
    │ └─md0                     9:0    0    2G  0 raid1 
    │   └─RAID_test-lvol0     253:1    0  100M  0 lvm   /tmp/new
    └─vdc2                    252:34   0  451M  0 part  
      └─md1                     9:1    0  897M  0 raid0
```
17. 
```
    root@netology:/home/netology# mdadm /dev/md0 --fail /dev/vdb1
    mdadm: set /dev/vdb1 faulty in /dev/md0
    root@netology:/home/netology# mdadm -D /dev/md0
    /dev/md0:
               Version : 1.2
         Creation Time : Mon Oct 24 12:57:31 2022
            Raid Level : raid1
            Array Size : 2094080 (2045.00 MiB 2144.34 MB)
         Used Dev Size : 2094080 (2045.00 MiB 2144.34 MB)
          Raid Devices : 2
         Total Devices : 2
           Persistence : Superblock is persistent
    
           Update Time : Mon Oct 24 13:47:43 2022
                 State : clean, degraded 
        Active Devices : 1
       Working Devices : 1
        Failed Devices : 1
         Spare Devices : 0
    
    Consistency Policy : resync
    
                  Name : netology:0  (local to host netology)
                  UUID : 6b66f3d8:59d6536a:42056bce:b6025f5a
                Events : 19
    
        Number   Major   Minor   RaidDevice State
           -       0        0        0      removed
           1     252       33        1      active sync   /dev/vdc1
    
           0     252       17        -      faulty   /dev/vdb1
```
18. 
```
    [ 3590.363848] md/raid1:md0: Disk failure on vdb1, disabling device.
                   md/raid1:md0: Operation continuing on 1 devices.
```
19. 
```
    root@netology:/home/netology# gzip -t /tmp/new/test.gz
    root@netology:/home/netology# echo $?
    0
```
