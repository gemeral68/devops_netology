
# Clickhouse & Vector & Lighthouse
Полное описание работы было представлено в предыдущем домашнем задании. Здесь же добавился play  с разворачиванием lighthouse и nginx.
Рассмотрим его работу:
```yml
- name: Install LightHouse
  hosts: lighthouse
  become: true
  vars_files:
    - ./group_vars/lighthouse/vars.yml
  handlers:
    - name: Start nginx
      ansible.builtin.systemd:
        name: nginx
        state: restarted
  tasks:
    - name: Install Git
      ansible.builtin.yum:
        update_cache: yes
        name: "{{ item }}"
        state: present
      with_items: 
          - git
          - epel-release
          - nginx
    - name: Clone lighthouse repo
      ansible.builtin.git:
        repo: "{{lighthouse_url}}"
        dest: "{{lighthouse_dir}}"
        version: master
    - name: Create nginx conf
      ansible.builtin.template:
        src: nginx_lighthouse.conf.j2
        dest: "{{nginx_conf_dir}}"
        mode: "0644"
        owner: root
        group: root
      notify: Start nginx
```
Общий принцип работы play заключается в том, чтобы склонировать репозиторий в каталог /usr/share/nginx/html/lighthouse и создать конфиг файл для nginx.
group_vars/lighthouse:
```yml
---
nginx_conf_dir: /etc/nginx/conf.d/nginx_lighthouse.conf
lighthouse_url: https://github.com/VKCOM/lighthouse.git
lighthouse_dir: /usr/share/nginx/html/lighthouse/
```
inventory:
```yml
---
clickhouse:
  hosts:
    clickhouse-01:
      ansible_host: <ip-addr>
vector:
  hosts:
    vector-01:
      ansible_host: <ip-addr>
lighthouse:
  hosts:
    lighthouse-01:
      ansible_host: <ip-addr>
all:
  vars:
    ansible_ssh_private_key_file: /home/bulat/.ssh/id_rsa
    ansible_sudo_pass: netology
    ansible_user: netology
```
templates/clickhouse.conf.j2:
```
<clickhouse>
  <listen_host>::</listen_host> 
</clickhouse>
```
templates/nginx_lighthouse.conf.j2:
```
server {
        listen       8080;
        server_name  _;
        root         /usr/share/nginx/html/lighthouse/;
        index        index.html;

        # Load configuration files for the default server block.

        location / {

        }

        error_page 404 /404.html;
            location = /40x.html {
        }

        error_page 500 502 503 504 /50x.html;
            location = /50x.html {
        }
}
```

## Лог выполнения Playbook:
```yml
ansible-playbook -i inventory/prod.yml site.yml  --diff -vv
ansible-playbook [core 2.15.3]
  config file = None
  configured module search path = ['/home/bulat/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
  ansible python module location = /usr/lib/python3.11/site-packages/ansible
  ansible collection location = /home/bulat/.ansible/collections:/usr/share/ansible/collections
  executable location = /usr/bin/ansible-playbook
  python version = 3.11.3 (main, Jun  5 2023, 09:32:32) [GCC 13.1.1 20230429] (/usr/bin/python)
  jinja version = 3.1.2
  libyaml = True
No config file found; using defaults
Skipping callback 'default', as we already have a stdout callback.
Skipping callback 'minimal', as we already have a stdout callback.
Skipping callback 'oneline', as we already have a stdout callback.

PLAYBOOK: site.yml **********************************************************************************************************************************************************************************************************************************************************************************************************************
3 plays in site.yml

PLAY [Install Clickhouse] ***************************************************************************************************************************************************************************************************************************************************************************************************************

TASK [Gathering Facts] ******************************************************************************************************************************************************************************************************************************************************************************************************************
task path: /home/bulat/Projects/Netology/Ansible/08-ansible-02-playbook/site.yml:2
ok: [clickhouse-01]

TASK [Get clickhouse distrib] ***********************************************************************************************************************************************************************************************************************************************************************************************************
task path: /home/bulat/Projects/Netology/Ansible/08-ansible-02-playbook/site.yml:14
ok: [clickhouse-01] => (item=clickhouse-client) => {"ansible_loop_var": "item", "changed": false, "dest": "./clickhouse-client-23.7.4.5.rpm", "elapsed": 0, "gid": 1000, "group": "netology", "item": "clickhouse-client", "mode": "0664", "msg": "HTTP Error 304: Not Modified", "owner": "netology", "secontext": "unconfined_u:object_r:user_home_t:s0", "size": 84668, "state": "file", "status_code": 304, "uid": 1000, "url": "https://packages.clickhouse.com/rpm/stable/clickhouse-client-23.7.4.5.x86_64.rpm"}
ok: [clickhouse-01] => (item=clickhouse-server) => {"ansible_loop_var": "item", "changed": false, "dest": "./clickhouse-server-23.7.4.5.rpm", "elapsed": 0, "gid": 1000, "group": "netology", "item": "clickhouse-server", "mode": "0664", "msg": "HTTP Error 304: Not Modified", "owner": "netology", "secontext": "unconfined_u:object_r:user_home_t:s0", "size": 111189, "state": "file", "status_code": 304, "uid": 1000, "url": "https://packages.clickhouse.com/rpm/stable/clickhouse-server-23.7.4.5.x86_64.rpm"}
ok: [clickhouse-01] => (item=clickhouse-common-static) => {"ansible_loop_var": "item", "changed": false, "dest": "./clickhouse-common-static-23.7.4.5.rpm", "elapsed": 0, "gid": 1000, "group": "netology", "item": "clickhouse-common-static", "mode": "0664", "msg": "HTTP Error 304: Not Modified", "owner": "netology", "secontext": "unconfined_u:object_r:user_home_t:s0", "size": 270835240, "state": "file", "status_code": 304, "uid": 1000, "url": "https://packages.clickhouse.com/rpm/stable/clickhouse-common-static-23.7.4.5.x86_64.rpm"}

TASK [Install clickhouse packages] ******************************************************************************************************************************************************************************************************************************************************************************************************
task path: /home/bulat/Projects/Netology/Ansible/08-ansible-02-playbook/site.yml:24
ok: [clickhouse-01] => {"changed": false, "msg": "", "rc": 0, "results": ["clickhouse-common-static-23.7.4.5-1.x86_64 providing clickhouse-common-static-23.7.4.5.rpm is already installed", "clickhouse-client-23.7.4.5-1.x86_64 providing clickhouse-client-23.7.4.5.rpm is already installed", "clickhouse-server-23.7.4.5-1.x86_64 providing clickhouse-server-23.7.4.5.rpm is already installed"]}

TASK [Clickhouse config] ****************************************************************************************************************************************************************************************************************************************************************************************************************
task path: /home/bulat/Projects/Netology/Ansible/08-ansible-02-playbook/site.yml:31
ok: [clickhouse-01] => {"changed": false, "checksum": "a1363b7ffd8fa0eadbbdf705a30281d99d440db1", "dest": "/etc/clickhouse-server/config.d/clickhouse.xml", "gid": 994, "group": "clickhouse", "mode": "0600", "owner": "clickhouse", "path": "/etc/clickhouse-server/config.d/clickhouse.xml", "secontext": "system_u:object_r:etc_t:s0", "size": 59, "state": "file", "uid": 997}

TASK [Flush handlers] *******************************************************************************************************************************************************************************************************************************************************************************************************************
task path: /home/bulat/Projects/Netology/Ansible/08-ansible-02-playbook/site.yml:39
META: triggered running handlers for clickhouse-01

TASK [Create database] ******************************************************************************************************************************************************************************************************************************************************************************************************************
task path: /home/bulat/Projects/Netology/Ansible/08-ansible-02-playbook/site.yml:41
ok: [clickhouse-01] => {"changed": false, "cmd": ["clickhouse-client", "-q", "create database logs;"], "delta": "0:00:01.092210", "end": "2023-08-24 14:10:44.179102", "failed_when_result": false, "msg": "non-zero return code", "rc": 82, "start": "2023-08-24 14:10:43.086892", "stderr": "Received exception from server (version 23.7.4):\nCode: 82. DB::Exception: Received from localhost:9000. DB::Exception: Database logs already exists.. (DATABASE_ALREADY_EXISTS)\n(query: create database logs;)", "stderr_lines": ["Received exception from server (version 23.7.4):", "Code: 82. DB::Exception: Received from localhost:9000. DB::Exception: Database logs already exists.. (DATABASE_ALREADY_EXISTS)", "(query: create database logs;)"], "stdout": "", "stdout_lines": []}

PLAY [Install Vector] *******************************************************************************************************************************************************************************************************************************************************************************************************************

TASK [Gathering Facts] ******************************************************************************************************************************************************************************************************************************************************************************************************************
task path: /home/bulat/Projects/Netology/Ansible/08-ansible-02-playbook/site.yml:47
ok: [vector-01]

TASK [Get_vector_version] ***************************************************************************************************************************************************************************************************************************************************************************************************************
task path: /home/bulat/Projects/Netology/Ansible/08-ansible-02-playbook/site.yml:60
changed: [vector-01] => {"changed": true, "cmd": ["vector", "--version"], "delta": "0:00:00.010033", "end": "2023-08-24 14:10:47.148821", "msg": "", "rc": 0, "start": "2023-08-24 14:10:47.138788", "stderr": "", "stderr_lines": [], "stdout": "vector 0.32.0 (x86_64-unknown-linux-gnu 1b403e1 2023-08-15 14:56:36.089460954)", "stdout_lines": ["vector 0.32.0 (x86_64-unknown-linux-gnu 1b403e1 2023-08-15 14:56:36.089460954)"]}

TASK [Create a directory Vector] ********************************************************************************************************************************************************************************************************************************************************************************************************
task path: /home/bulat/Projects/Netology/Ansible/08-ansible-02-playbook/site.yml:64
skipping: [vector-01] => {"changed": false, "false_condition": "is_installed is failed", "skip_reason": "Conditional result was False"}

TASK [Copy rpm file to server] **********************************************************************************************************************************************************************************************************************************************************************************************************
task path: /home/bulat/Projects/Netology/Ansible/08-ansible-02-playbook/site.yml:73
skipping: [vector-01] => {"changed": false, "false_condition": "is_installed is failed", "skip_reason": "Conditional result was False"}

TASK [Install package] ******************************************************************************************************************************************************************************************************************************************************************************************************************
task path: /home/bulat/Projects/Netology/Ansible/08-ansible-02-playbook/site.yml:80
skipping: [vector-01] => {"changed": false, "false_condition": "is_installed is failed", "skip_reason": "Conditional result was False"}

TASK [Create vector config] *************************************************************************************************************************************************************************************************************************************************************************************************************
task path: /home/bulat/Projects/Netology/Ansible/08-ansible-02-playbook/site.yml:87
ok: [vector-01] => {"changed": false, "checksum": "b97cc28f02368f30c17f760ab3b974b80dc8ce96", "dest": "/etc/vector/vector.yml", "gid": 0, "group": "root", "mode": "0644", "owner": "root", "path": "/etc/vector/vector.yml", "secontext": "system_u:object_r:etc_t:s0", "size": 347, "state": "file", "uid": 0}

TASK [Create vector systemd unit] *******************************************************************************************************************************************************************************************************************************************************************************************************
task path: /home/bulat/Projects/Netology/Ansible/08-ansible-02-playbook/site.yml:95
ok: [vector-01] => {"changed": false, "checksum": "0a79aa1419338dba33379f2aed707da7927a626b", "dest": "/usr/lib/systemd/system/vector.service", "gid": 0, "group": "root", "mode": "0644", "owner": "root", "path": "/usr/lib/systemd/system/vector.service", "secontext": "system_u:object_r:systemd_unit_file_t:s0", "size": 294, "state": "file", "uid": 0}

PLAY [Install LightHouse] ***************************************************************************************************************************************************************************************************************************************************************************************************************

TASK [Gathering Facts] ******************************************************************************************************************************************************************************************************************************************************************************************************************
task path: /home/bulat/Projects/Netology/Ansible/08-ansible-02-playbook/site.yml:104
ok: [lighthouse-01]

TASK [Install Git] **********************************************************************************************************************************************************************************************************************************************************************************************************************
task path: /home/bulat/Projects/Netology/Ansible/08-ansible-02-playbook/site.yml:115
ok: [lighthouse-01] => (item=git) => {"ansible_loop_var": "item", "changed": false, "item": "git", "msg": "", "rc": 0, "results": ["git-1.8.3.1-25.el7_9.x86_64 providing git is already installed"]}
ok: [lighthouse-01] => (item=epel-release) => {"ansible_loop_var": "item", "changed": false, "item": "epel-release", "msg": "", "rc": 0, "results": ["epel-release-7-11.noarch providing epel-release is already installed"]}
ok: [lighthouse-01] => (item=nginx) => {"ansible_loop_var": "item", "changed": false, "item": "nginx", "msg": "", "rc": 0, "results": ["1:nginx-1.20.1-10.el7.x86_64 providing nginx is already installed"]}

TASK [Clone lighthouse repo] ************************************************************************************************************************************************************************************************************************************************************************************************************
task path: /home/bulat/Projects/Netology/Ansible/08-ansible-02-playbook/site.yml:124
ok: [lighthouse-01] => {"after": "d701335c25cd1bb9b5155711190bad8ab852c2ce", "before": "d701335c25cd1bb9b5155711190bad8ab852c2ce", "changed": false, "remote_url_changed": false}

TASK [Create nginx conf] ****************************************************************************************************************************************************************************************************************************************************************************************************************
task path: /home/bulat/Projects/Netology/Ansible/08-ansible-02-playbook/site.yml:129
ok: [lighthouse-01] => {"changed": false, "checksum": "42cfc0da2c8c1a45530ad55212c78114cc49b4c0", "dest": "/etc/nginx/conf.d/nginx_lighthouse.conf", "gid": 0, "group": "root", "mode": "0644", "owner": "root", "path": "/etc/nginx/conf.d/nginx_lighthouse.conf", "secontext": "system_u:object_r:httpd_config_t:s0", "size": 422, "state": "file", "uid": 0}

PLAY RECAP ******************************************************************************************************************************************************************************************************************************************************************************************************************************
clickhouse-01              : ok=5    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
lighthouse-01              : ok=4    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
vector-01                  : ok=4    changed=1    unreachable=0    failed=0    skipped=3    rescued=0    ignored=0  
```
## Подключение к Lighthouse:
![](https://github.com/gemeral68/devops_netology/blob/main/mnt-homeworks/08-ansible-03-yandex/Screenshot%20from%202023-08-24%2017-25-36.png)

![](https://github.com/gemeral68/devops_netology/blob/main/mnt-homeworks/08-ansible-03-yandex/Screenshot%20from%202023-08-24%2017-25-59.png)
