Домашнее задание к занятию "3.3. Операционные системы. Лекция 1"


1. В нашем случае системный вызов команды cd будет chdir("/tmp")

2. Файл базы типов /usr/share/misc/magic.mgc
```
	openat(AT_FDCWD, "/usr/share/misc/magic.mgc", O_RDONLY) = 3
```
	Так же, по всей видимости ищет и пользовательские файлы:
```
	stat("/home/telecor/.magic.mgc", 0x7ffd6f6ac520) = -1 ENOENT (No such file or directory)
	stat("/home/telecor/.magic", 0x7ffd6f6ac520) = -1 ENOENT (No such file or directory)
	openat(AT_FDCWD, "/etc/magic.mgc", O_RDONLY) = -1 ENOENT (No such file or directory)
	stat("/etc/magic", {st_mode=S_IFREG|0644, st_size=111, ...}) = 0
	openat(AT_FDCWD, "/etc/magic", O_RDONLY) = 3
```

3. 
```
    root@netboxtest:/home/telecor# lsof -p 39225 | grep 123
    vi     39273 telecor    4u   REG  253,0    12288   4199 /home/telecor/.123.txt.swp (deleted)

    echo '' >/proc/39273/fd/4

    где 39273 PID процеса, а 4 это файловый дескриптор
```

4. "Зомби" процессы, в отличии от "сирот" освобождают свои ресурсы, но не освобождают запись в таблице процессов. 
	    Запись освободиться при вызове wait() родительским процессом. 
	
5.    
```
    root@netboxtest:/home/telecor# dpkg -L bpfcc-tools | grep sbin/opensnoop
    /usr/sbin/opensnoop-bpfcc
    root@netboxtest:/home/telecor# /usr/sbin/opensnoop-bpfcc
    PID    COMM               FD ERR PATH
    739    redis-server       17   0 /proc/739/stat
    739    redis-server       17   0 /proc/739/stat
    739    redis-server       17   0 /proc/739/stat
    739    redis-server       17   0 /proc/739/stat
    739    redis-server       17   0 /proc/739/stat
    739    redis-server       17   0 /proc/739/stat
    739    redis-server       17   0 /proc/739/stat
    739    redis-server       17   0 /proc/739/stat
    739    redis-server       17   0 /proc/739/stat
    739    redis-server       17   0 /proc/739/stat
    739    redis-server       17   0 /proc/739/stat
    739    redis-server       17   0 /proc/739/stat
    739    redis-server       17   0 /proc/739/stat
    739    redis-server       17   0 /proc/739/stat
    739    redis-server       17   0 /proc/739/stat
    739    redis-server       17   0 /proc/739/stat
    739    redis-server       17   0 /proc/739/stat
    739    redis-server       17   0 /proc/739/stat
    739    redis-server       17   0 /proc/739/stat
    739    redis-server       17   0 /proc/739/stat
    739    redis-server       17   0 /proc/739/stat
    1      systemd            22   0 /proc/638/cgroup
    739    redis-server       17   0 /proc/739/stat
```
6. 
```
    Part of the utsname information is also accessible via
       /proc/sys/kernel/{ostype, hostname, osrelease, version,
       domainname}.
```
7. 
```
        && -  условный оператор, 
        а ;  - разделитель последовательных команд

        то есть в случае с && вторая команда выполниться, только при условии успешного выполнения первой.

        
        set -e - прерывает сессию при любом ненулевом значении исполняемых команд в конвеере кроме последней.
        в случае &&  вместе с set -e- вероятно не имеет смысла, так как при ошибке , выполнение команд прекратиться.
```
8.   По сути, для сценария , повышает деталезацию вывода ошибок(логирования), 
	    и завершит сценарий при наличии ошибок, на любом этапе выполнения сценария, кроме последней завершающей команды
```
    -e прерывает выполнение исполнения при ошибке любой команды кроме последней в последовательности 
    -x вывод трейса простых команд 
    -u неустановленные/не заданные параметры и переменные считаются как ошибки, с выводом в stderr текста ошибки и выполнит завершение неинтерактивного вызова
    -o pipefail возвращает код возврата набора/последовательности команд, ненулевой при последней команды или 0 для успешного выполнения команд.
```
9. Самые частые:
```
        S,S+,Ss,Ssl,Ss+ - Процессы ожидающие завершения. 
        I,I< - фоновые бездействующие процессы ядра

        Доп символы это доп характеритики, например приоритет (<)
```

