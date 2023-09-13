Role Name
=========

A brief description of the role goes here.

Requirements
------------

Any pre-requisites that may not be covered by Ansible itself or the role should be mentioned here. For instance, if the role uses the EC2 module, it may be a good idea to mention in this section that the boto package is required.

Role Variables
--------------

A description of the settable variables for this role should go here, including any variables that are in defaults/main.yml, vars/main.yml, and any variables that can/should be set via parameters to the role. Any variables that are read from other roles and/or the global scope (ie. hostvars, group vars, etc.) should be mentioned here as well.

Dependencies
------------

A list of other roles hosted on Galaxy should go here, plus any details in regards to parameters that may need to be set for other roles, or variables that are used from other roles.

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - hosts: servers
      roles:
         - { role: username.rolename, x: 42 }

License
-------

BSD

Author Information
------------------

An optional section for the role authors to include contact information, or a website (HTML is not allowed).



ansible-playbook -i inventory.yml site.yml  --diff -vv
ansible-playbook [core 2.15.3]
  config file = None
  configured module search path = ['/home/bulat/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
  ansible python module location = /usr/lib/python3.11/site-packages/ansible
  ansible collection location = /home/bulat/.ansible/collections:/usr/share/ansible/collections
  executable location = /usr/bin/ansible-playbook
  python version = 3.11.5 (main, Sep  2 2023, 14:16:33) [GCC 13.2.1 20230801] (/usr/bin/python)
  jinja version = 3.1.2
  libyaml = True
No config file found; using defaults
Skipping callback 'default', as we already have a stdout callback.
Skipping callback 'minimal', as we already have a stdout callback.
Skipping callback 'oneline', as we already have a stdout callback.

PLAYBOOK: site.yml **********************************************************************************************************************************************************************
3 plays in site.yml

PLAY [Install Clickhouse] ***************************************************************************************************************************************************************

TASK [Gathering Facts] ******************************************************************************************************************************************************************
task path: /home/bulat/Projects/Netology/Ansible/08-ansible-04-role/site.yml:2
ok: [clickhouse-01]

TASK [clickhouse-role : Get clickhouse distrib] *****************************************************************************************************************************************
task path: /home/bulat/Projects/Netology/Ansible/08-ansible-04-role/clickhouse-role/tasks/main.yml:4
ok: [clickhouse-01] => (item=clickhouse-client) => {"ansible_loop_var": "item", "changed": false, "dest": "./clickhouse-client-23.7.4.5.rpm", "elapsed": 0, "gid": 0, "group": "root", "item": "clickhouse-client", "mode": "0644", "msg": "HTTP Error 304: Not Modified", "owner": "root", "secontext": "unconfined_u:object_r:user_home_t:s0", "size": 84668, "state": "file", "status_code": 304, "uid": 0, "url": "https://packages.clickhouse.com/rpm/stable/clickhouse-client-23.7.4.5.x86_64.rpm"}
ok: [clickhouse-01] => (item=clickhouse-server) => {"ansible_loop_var": "item", "changed": false, "dest": "./clickhouse-server-23.7.4.5.rpm", "elapsed": 0, "gid": 0, "group": "root", "item": "clickhouse-server", "mode": "0644", "msg": "HTTP Error 304: Not Modified", "owner": "root", "secontext": "unconfined_u:object_r:user_home_t:s0", "size": 111189, "state": "file", "status_code": 304, "uid": 0, "url": "https://packages.clickhouse.com/rpm/stable/clickhouse-server-23.7.4.5.x86_64.rpm"}
ok: [clickhouse-01] => (item=clickhouse-common-static) => {"ansible_loop_var": "item", "changed": false, "dest": "./clickhouse-common-static-23.7.4.5.rpm", "elapsed": 0, "gid": 0, "group": "root", "item": "clickhouse-common-static", "mode": "0644", "msg": "HTTP Error 304: Not Modified", "owner": "root", "secontext": "unconfined_u:object_r:user_home_t:s0", "size": 270835240, "state": "file", "status_code": 304, "uid": 0, "url": "https://packages.clickhouse.com/rpm/stable/clickhouse-common-static-23.7.4.5.x86_64.rpm"}

TASK [clickhouse-role : Install clickhouse packages] ************************************************************************************************************************************
task path: /home/bulat/Projects/Netology/Ansible/08-ansible-04-role/clickhouse-role/tasks/main.yml:14
ok: [clickhouse-01] => {"changed": false, "msg": "", "rc": 0, "results": ["clickhouse-common-static-23.7.4.5-1.x86_64 providing clickhouse-common-static-23.7.4.5.rpm is already installed", "clickhouse-client-23.7.4.5-1.x86_64 providing clickhouse-client-23.7.4.5.rpm is already installed", "clickhouse-server-23.7.4.5-1.x86_64 providing clickhouse-server-23.7.4.5.rpm is already installed"]}

TASK [clickhouse-role : Clickhouse config] **********************************************************************************************************************************************
task path: /home/bulat/Projects/Netology/Ansible/08-ansible-04-role/clickhouse-role/tasks/main.yml:21
ok: [clickhouse-01] => {"changed": false, "checksum": "a1363b7ffd8fa0eadbbdf705a30281d99d440db1", "dest": "/etc/clickhouse-server/config.d/clickhouse.xml", "gid": 994, "group": "clickhouse", "mode": "0600", "owner": "clickhouse", "path": "/etc/clickhouse-server/config.d/clickhouse.xml", "secontext": "system_u:object_r:etc_t:s0", "size": 59, "state": "file", "uid": 997}

TASK [clickhouse-role : Flush handlers] *************************************************************************************************************************************************
task path: /home/bulat/Projects/Netology/Ansible/08-ansible-04-role/clickhouse-role/tasks/main.yml:29
META: triggered running handlers for clickhouse-01

TASK [clickhouse-role : Create database] ************************************************************************************************************************************************
task path: /home/bulat/Projects/Netology/Ansible/08-ansible-04-role/clickhouse-role/tasks/main.yml:31
ok: [clickhouse-01] => {"changed": false, "cmd": ["clickhouse-client", "-q", "create database logs;"], "delta": "0:00:04.005864", "end": "2023-09-13 11:45:40.776508", "failed_when_result": false, "msg": "non-zero return code", "rc": 82, "start": "2023-09-13 11:45:36.770644", "stderr": "Received exception from server (version 23.7.4):\nCode: 82. DB::Exception: Received from localhost:9000. DB::Exception: Database logs already exists.. (DATABASE_ALREADY_EXISTS)\n(query: create database logs;)", "stderr_lines": ["Received exception from server (version 23.7.4):", "Code: 82. DB::Exception: Received from localhost:9000. DB::Exception: Database logs already exists.. (DATABASE_ALREADY_EXISTS)", "(query: create database logs;)"], "stdout": "", "stdout_lines": []}

PLAY [Install Vector] *******************************************************************************************************************************************************************

TASK [Gathering Facts] ******************************************************************************************************************************************************************
task path: /home/bulat/Projects/Netology/Ansible/08-ansible-04-role/site.yml:7
ok: [vector-01]

TASK [vector-role : Get_vector_version] *************************************************************************************************************************************************
task path: /home/bulat/Projects/Netology/Ansible/08-ansible-04-role/vector-role/tasks/main.yml:3
changed: [vector-01] => {"changed": true, "cmd": ["vector", "--version"], "delta": "0:00:00.008391", "end": "2023-09-13 11:45:43.583924", "msg": "", "rc": 0, "start": "2023-09-13 11:45:43.575533", "stderr": "", "stderr_lines": [], "stdout": "vector 0.32.0 (x86_64-unknown-linux-gnu 1b403e1 2023-08-15 14:56:36.089460954)", "stdout_lines": ["vector 0.32.0 (x86_64-unknown-linux-gnu 1b403e1 2023-08-15 14:56:36.089460954)"]}

TASK [vector-role : Create a directory Vector] ******************************************************************************************************************************************
task path: /home/bulat/Projects/Netology/Ansible/08-ansible-04-role/vector-role/tasks/main.yml:7
skipping: [vector-01] => {"changed": false, "false_condition": "is_installed is failed", "skip_reason": "Conditional result was False"}

TASK [vector-role : Copy rpm file to server] ********************************************************************************************************************************************
task path: /home/bulat/Projects/Netology/Ansible/08-ansible-04-role/vector-role/tasks/main.yml:16
skipping: [vector-01] => {"changed": false, "false_condition": "is_installed is failed", "skip_reason": "Conditional result was False"}

TASK [vector-role : Install package] ****************************************************************************************************************************************************
task path: /home/bulat/Projects/Netology/Ansible/08-ansible-04-role/vector-role/tasks/main.yml:23
skipping: [vector-01] => {"changed": false, "false_condition": "is_installed is failed", "skip_reason": "Conditional result was False"}

TASK [vector-role : Create vector config] ***********************************************************************************************************************************************
task path: /home/bulat/Projects/Netology/Ansible/08-ansible-04-role/vector-role/tasks/main.yml:30
ok: [vector-01] => {"changed": false, "checksum": "de562392ce69ebcd919e618746b007bd78d1dd8c", "dest": "/etc/vector/vector.yml", "gid": 0, "group": "root", "mode": "0644", "owner": "root", "path": "/etc/vector/vector.yml", "secontext": "system_u:object_r:etc_t:s0", "size": 347, "state": "file", "uid": 0}

TASK [vector-role : Create vector systemd unit] *****************************************************************************************************************************************
task path: /home/bulat/Projects/Netology/Ansible/08-ansible-04-role/vector-role/tasks/main.yml:38
ok: [vector-01] => {"changed": false, "checksum": "0a79aa1419338dba33379f2aed707da7927a626b", "dest": "/usr/lib/systemd/system/vector.service", "gid": 0, "group": "root", "mode": "0644", "owner": "root", "path": "/usr/lib/systemd/system/vector.service", "secontext": "system_u:object_r:systemd_unit_file_t:s0", "size": 294, "state": "file", "uid": 0}

PLAY [Install LightHouse] ***************************************************************************************************************************************************************

TASK [Gathering Facts] ******************************************************************************************************************************************************************
task path: /home/bulat/Projects/Netology/Ansible/08-ansible-04-role/site.yml:12
ok: [lighthouse-01]

TASK [lighthouse-role : Install Git] ****************************************************************************************************************************************************
task path: /home/bulat/Projects/Netology/Ansible/08-ansible-04-role/lighthouse-role/tasks/main.yml:3
ok: [lighthouse-01] => (item=git) => {"ansible_loop_var": "item", "changed": false, "item": "git", "msg": "", "rc": 0, "results": ["git-1.8.3.1-25.el7_9.x86_64 providing git is already installed"]}
ok: [lighthouse-01] => (item=epel-release) => {"ansible_loop_var": "item", "changed": false, "item": "epel-release", "msg": "", "rc": 0, "results": ["epel-release-7-11.noarch providing epel-release is already installed"]}
ok: [lighthouse-01] => (item=nginx) => {"ansible_loop_var": "item", "changed": false, "item": "nginx", "msg": "", "rc": 0, "results": ["1:nginx-1.20.1-10.el7.x86_64 providing nginx is already installed"]}

TASK [lighthouse-role : Clone lighthouse repo] ******************************************************************************************************************************************
task path: /home/bulat/Projects/Netology/Ansible/08-ansible-04-role/lighthouse-role/tasks/main.yml:12
ok: [lighthouse-01] => {"after": "d701335c25cd1bb9b5155711190bad8ab852c2ce", "before": "d701335c25cd1bb9b5155711190bad8ab852c2ce", "changed": false, "remote_url_changed": false}

TASK [lighthouse-role : Create nginx conf] **********************************************************************************************************************************************
task path: /home/bulat/Projects/Netology/Ansible/08-ansible-04-role/lighthouse-role/tasks/main.yml:17
ok: [lighthouse-01] => {"changed": false, "checksum": "b10e9c06c478cbdb9a34390aade54e28e45b4711", "dest": "/etc/nginx/conf.d/nginx_lighthouse.conf", "gid": 0, "group": "root", "mode": "0644", "owner": "root", "path": "/etc/nginx/conf.d/nginx_lighthouse.conf", "secontext": "system_u:object_r:httpd_config_t:s0", "size": 421, "state": "file", "uid": 0}

PLAY RECAP ******************************************************************************************************************************************************************************
clickhouse-01              : ok=5    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
lighthouse-01              : ok=4    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
vector-01                  : ok=4    changed=1    unreachable=0    failed=0    skipped=3    rescued=0    ignored=0 