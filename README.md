1. В качестве средства виртуализации использую QEMU-KVM и инструмент для управления виртуализацией libvirt.
4. Конфигурационный файл для запуска centos 7 посредством vagrant выглядит следующим образом:
	
    ENV['VAGRANT_DEFAULT_PROVIDER'] = 'libvirt'

	Vagrant.configure("2") do |config|

  		##### DEFINE VM #####
  		config.vm.define "cent-7" do |config|
  		config.vm.hostname = "cent-7"
  		config.vm.box = "centos/7"
 		config.vm.box_check_update = false
  		config.vm.provider :libvirt do |v|
    			v.memory = 1024
    			v.cpus = 2
    			end
  		end
	end
5. По умолчанию выбо выделено CPU: 1, RAM 512MB , SWAP 2GB.
6. Расширение ресурсов возможно посредством добавления следующих строк в конфигурационный файл:
	
        v.memory = 1024
    	v.cpus = 2
8. HISTFILESIZE
   строка 470
  
    ignoreboth это сокращение для 2х директив ignorespace and ignoredups
    ignorespace - не сохранять команды начинающиеся с пробела, 
    ignoredups - не сохранять команду, если такая уже имеется в истории
9. {} - подстановка переменной из списка. Конструкция mkdir ./dir_{1..10} - создаст каталоги сименами dir_1, dir_2 и т.д. до dir_10
	
    строка 174
10. touch {000001..100000}.txt
    300000 файлов создать не удасться (ошибка -bash: /usr/bin/touch: Argument list too long)
11. [[]] - проверка условия.  [[ -d /tmp ]] проверяет наличие каталога. Возвращает 0 или 1.
12. на вм с ОС Centos7 получилось реализовать только следующий вывод:
        [vagrant@cent-7 tmp]$ type -a bash
	bash is /tmp/new_path_dir/bash
	bash is /usr/bin/bash
    
    на тестовой вм с ОС Ubuntu 20.04 все получилось реализовать как и требовалось в задании:
	
        root@test:/home/telecor# mkdir /tmp/new_path_dir
	root@test:/home/telecor# cp /bin/bash /tmp/new_path_dir/
	root@test:/home/telecor# type -a bash 
	bash is /usr/bin/bash
	bash is /bin/bash
	root@test:/home/telecor# PATH=/tmp/new_path_dir/:$PATH
	root@test:/home/telecor# type -a bash 
	bash is /tmp/new_path_dir/bash
	bash is /usr/bin/bash
	bash is /bin/bash
13. at - команда запускается в указанное время (в параметре)
    batch - запускается когда уровень загрузки системы снизится ниже 1.5.
