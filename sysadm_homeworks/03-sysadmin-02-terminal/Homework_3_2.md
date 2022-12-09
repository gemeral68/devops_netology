3.2.1 Операционная система не считается таковой, если в ней нет возможности перемещаться по директориям. Соответственно команда cd есть во всех ОС, она уже включена в неё. Поэтому она и называется builtin - то есть она уже 		включена в само ядро ОС. Например если ОС загрузится не полностью, а только grub, команда cd всё равно будет доступна.

	#type cd
	cd is a shell builtin

3.2.2 Альтернативой команде grep <some_string> <some_file> | wc -l без pipe является:
	 grep <some_string> <some_file> -с 
	 
	 [root@cent-7 /]# grep then 123.sh 
	 then
	 [root@cent-7 /]# grep then 123.sh | wc -l
	 1
	 [root@cent-7 /]# grep then 123.sh -c
	 1
	 
3.2.3  Родительским процессом с PID 1 является systemd:
	
	 [root@cent-7 /]# pstree -p
	 systemd(1)─┬─NetworkManager(380)─┬─dhclient(419)
           	    │                     ├─{NetworkManager}(393)
           	    │                     └─{NetworkManager}(399)
           	    ├─agetty(401)
           	    ├─agetty(402)
           	    ├─auditd(299)───{auditd}(301)
           	    ├─chronyd(370)
           	    ├─crond(403)
           	    ├─dbus-daemon(365)───{dbus-daemon}(374)
           	    
3.2.4	Из pts0:

	[root@cent-7 .ssh]# ls -l \root 2>/dev/pts/1
	
Вывод в pts1:
	
	[vagrant@cent-7 ~]$ who
	vagrant  pts/0        2022-09-10 12:41 (192.168.121.1)
	vagrant  pts/1        2022-09-10 12:55 (192.168.121.1)
	[vagrant@cent-7 ~]$ ls: cannot access root: No such file or directory

3.2.5	

	[root@cent-7 /]# cat 123.sh 
	if [[ -d /tmp ]]
	then
    	   echo "каталог есть"
	else
    	   echo "каталога нет"
	fi
	[root@cent-7 /]# cat 123_out.sh
	cat: 123_out.sh: No such file or directory
	[root@cent-7 /]# cat < 123.sh > 123_out.sh
	[root@cent-7 /]# cat 123_out.sh
	if [[ -d /tmp ]]
	then
    	   echo "каталог есть"
	else
    	   echo "каталога нет"
	fi


3.2.6	Вывести получится командойперенаправления вывода:
	
	echo "Hello world" > /dev/tty3
	
Но наблюдать в графическом режиме не получится. Нужно переключитсья в TTY сочетанием клавиш Ctrl + Alt + F3.

3.2.7	

    [root@cent-7 /]# bash 5>&1 - создаст новый дескриптор и перенаправит его в stdout
	  [root@cent-7 /]# echo netology > /proc/$$/fd/5 - Перенаправит netology в дескриптор 5, который был перенаправлен в stdout
	  netology


3.2.8	

    [vagrant@cent-7 .ssh]$ ls -l /root 9>&2 2>&1 1>&9 |grep Permission -c
	  1
	
9>&2 - Новый дескриптор перенаправили в stderr
2>&1 - stderr перенаправили в stdout
1>&9 - stdout перенаправили в новый дескриптор 
	
3.2.9 Выведет переменные окружения. Можно вывести то же самое командами env и printenv. (Будет разделение по переменным)

3.2.10  

    /proc/<PID>/cmdline содержит полную командную строку запуска процесса, кроме тех процессов, что полностью ушли в своппинг, а также тех, что превратились в зомби. В этих двух случаях обрашение по этому пути вернет 0.
	  /proc/<PID>/exe под Linux 2.2 и 2.4 exe является символьной ссылкой, содержащей фактическое полное имя выполняемого файла.При попытке открыть exe будет открыт исполняемый файл. Под Linux 2.0 и в более ранних версиях exe  является указателем на запущенный файл и является символьной ссылкой. 	

3.2.11  SSE 4.2

	[root@cent-7 /]# grep sse /proc/cpuinfo

3.2.12  По умолчанию при выполнении команды на удаленном хосте с помощью ssh сессия TTY не выделяется. Это позволяет передавать двоичные данные и т.д. Для принудительного вызова сессии TTY используется ключ -t.
	
	[vagrant@cent-7 .ssh]$ ssh -t localhost 'tty'
	/dev/pts/1
	Connection to localhost closed.


3.2.13	Получилось реализовать после выполнения команды echo 0 > /proc/sys/kernel/yama/ptrace_scope и перезагрузки машины. 

	[root@cent-7 vagrant]# ps -a
  	PID TTY          TIME CMD
  	893 pts/0    00:00:00 sudo
  	895 pts/0    00:00:00 su
  	896 pts/0    00:00:00 bash
  	947 pts/1    00:00:00 sudo
  	949 pts/1    00:00:00 su
  	950 pts/1    00:00:00 bash
  	971 pts/1    00:00:00 reptyr
  	975 pts/0    00:00:00 ps

3.2.14	Команда tee делает вывод в файл, который указан ввиде параметра и в стандартный поток вывода. В примере tee запускается от рута и соответственно у нее есть право на запись.
