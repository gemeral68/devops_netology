

```yml
[08-ansible-02-playbook]$ ansible-playbook -i inventory/prod.yml site.yml --diff -vv
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

PLAYBOOK: site.yml *****************************************************************************************************************************************************************************************************************************************************************************************************
2 plays in site.yml

PLAY [Install Clickhouse] **********************************************************************************************************************************************************************************************************************************************************************************************

TASK [Gathering Facts] *************************************************************************************************************************************************************************************************************************************************************************************************
task path: /home/bulat/Projects/Netology/Ansible/08-ansible-02-playbook/site.yml:2
ok: [clickhouse-01]

TASK [Get clickhouse distrib] ******************************************************************************************************************************************************************************************************************************************************************************************
task path: /home/bulat/Projects/Netology/Ansible/08-ansible-02-playbook/site.yml:12
ok: [clickhouse-01] => (item=clickhouse-client) => {"ansible_loop_var": "item", "changed": false, "dest": "./clickhouse-client-23.7.4.5.rpm", "elapsed": 0, "gid": 1000, "group": "netology", "item": "clickhouse-client", "mode": "0664", "msg": "HTTP Error 304: Not Modified", "owner": "netology", "secontext": "unconfined_u:object_r:user_home_t:s0", "size": 84668, "state": "file", "status_code": 304, "uid": 1000, "url": "https://packages.clickhouse.com/rpm/stable/clickhouse-client-23.7.4.5.x86_64.rpm"}
ok: [clickhouse-01] => (item=clickhouse-server) => {"ansible_loop_var": "item", "changed": false, "dest": "./clickhouse-server-23.7.4.5.rpm", "elapsed": 0, "gid": 1000, "group": "netology", "item": "clickhouse-server", "mode": "0664", "msg": "HTTP Error 304: Not Modified", "owner": "netology", "secontext": "unconfined_u:object_r:user_home_t:s0", "size": 111189, "state": "file", "status_code": 304, "uid": 1000, "url": "https://packages.clickhouse.com/rpm/stable/clickhouse-server-23.7.4.5.x86_64.rpm"}
ok: [clickhouse-01] => (item=clickhouse-common-static) => {"ansible_loop_var": "item", "changed": false, "dest": "./clickhouse-common-static-23.7.4.5.rpm", "elapsed": 0, "gid": 1000, "group": "netology", "item": "clickhouse-common-static", "mode": "0664", "msg": "HTTP Error 304: Not Modified", "owner": "netology", "secontext": "unconfined_u:object_r:user_home_t:s0", "size": 270835240, "state": "file", "status_code": 304, "uid": 1000, "url": "https://packages.clickhouse.com/rpm/stable/clickhouse-common-static-23.7.4.5.x86_64.rpm"}

TASK [Install clickhouse packages] *************************************************************************************************************************************************************************************************************************************************************************************
task path: /home/bulat/Projects/Netology/Ansible/08-ansible-02-playbook/site.yml:22
ok: [clickhouse-01] => {"changed": false, "msg": "Nothing to do", "rc": 0, "results": ["Installed clickhouse-common-static-23.7.4.5.rpm", "Installed clickhouse-client-23.7.4.5.rpm", "Installed clickhouse-server-23.7.4.5.rpm"]}

TASK [Flush handlers] **************************************************************************************************************************************************************************************************************************************************************************************************
task path: /home/bulat/Projects/Netology/Ansible/08-ansible-02-playbook/site.yml:31
META: triggered running handlers for clickhouse-01

TASK [Create database] *************************************************************************************************************************************************************************************************************************************************************************************************
task path: /home/bulat/Projects/Netology/Ansible/08-ansible-02-playbook/site.yml:33
ok: [clickhouse-01] => {"changed": false, "cmd": ["clickhouse-client", "-q", "create database logs;"], "delta": "0:00:00.333434", "end": "2023-08-22 06:03:57.982422", "failed_when_result": false, "msg": "non-zero return code", "rc": 82, "start": "2023-08-22 06:03:57.648988", "stderr": "Received exception from server (version 23.7.4):\nCode: 82. DB::Exception: Received from localhost:9000. DB::Exception: Database logs already exists.. (DATABASE_ALREADY_EXISTS)\n(query: create database logs;)", "stderr_lines": ["Received exception from server (version 23.7.4):", "Code: 82. DB::Exception: Received from localhost:9000. DB::Exception: Database logs already exists.. (DATABASE_ALREADY_EXISTS)", "(query: create database logs;)"], "stdout": "", "stdout_lines": []}

PLAY [Install Vector] **************************************************************************************************************************************************************************************************************************************************************************************************

TASK [Gathering Facts] *************************************************************************************************************************************************************************************************************************************************************************************************
task path: /home/bulat/Projects/Netology/Ansible/08-ansible-02-playbook/site.yml:38
ok: [clickhouse-01]

TASK [Get_vector_version] **********************************************************************************************************************************************************************************************************************************************************************************************
task path: /home/bulat/Projects/Netology/Ansible/08-ansible-02-playbook/site.yml:51
changed: [clickhouse-01] => {"changed": true, "cmd": ["vector", "--version"], "delta": "0:00:00.078224", "end": "2023-08-22 06:04:00.960890", "msg": "", "rc": 0, "start": "2023-08-22 06:04:00.882666", "stderr": "", "stderr_lines": [], "stdout": "vector 0.32.0 (x86_64-unknown-linux-gnu 1b403e1 2023-08-15 14:56:36.089460954)", "stdout_lines": ["vector 0.32.0 (x86_64-unknown-linux-gnu 1b403e1 2023-08-15 14:56:36.089460954)"]}

TASK [Create a directory Vector] ***************************************************************************************************************************************************************************************************************************************************************************************
task path: /home/bulat/Projects/Netology/Ansible/08-ansible-02-playbook/site.yml:55
skipping: [clickhouse-01] => {"changed": false, "false_condition": "is_installed is failed", "skip_reason": "Conditional result was False"}

TASK [Copy rpm file to server] *****************************************************************************************************************************************************************************************************************************************************************************************
task path: /home/bulat/Projects/Netology/Ansible/08-ansible-02-playbook/site.yml:65
skipping: [clickhouse-01] => {"changed": false, "false_condition": "is_installed is failed", "skip_reason": "Conditional result was False"}

TASK [Install package] *************************************************************************************************************************************************************************************************************************************************************************************************
task path: /home/bulat/Projects/Netology/Ansible/08-ansible-02-playbook/site.yml:72
skipping: [clickhouse-01] => {"changed": false, "false_condition": "is_installed is failed", "skip_reason": "Conditional result was False"}

TASK [Create vector config] ********************************************************************************************************************************************************************************************************************************************************************************************
task path: /home/bulat/Projects/Netology/Ansible/08-ansible-02-playbook/site.yml:80
ok: [clickhouse-01] => {"changed": false, "checksum": "70d35791ad88043f87d61cdc1b0bbb68b3500827", "dest": "/etc/vector/vector.yml", "gid": 1000, "group": "netology", "mode": "0644", "owner": "netology", "path": "/etc/vector/vector.yml", "secontext": "system_u:object_r:etc_t:s0", "size": 343, "state": "file", "uid": 1000}

TASK [Create vector systemd unit] **************************************************************************************************************************************************************************************************************************************************************************************
task path: /home/bulat/Projects/Netology/Ansible/08-ansible-02-playbook/site.yml:89
ok: [clickhouse-01] => {"changed": false, "checksum": "6bb839c28189c88c332cc257dc41d35bc6ef9afe", "dest": "/usr/lib/systemd/system/vector.service", "gid": 1000, "group": "netology", "mode": "0644", "owner": "netology", "path": "/usr/lib/systemd/system/vector.service", "secontext": "system_u:object_r:systemd_unit_file_t:s0", "size": 302, "state": "file", "uid": 1000}

PLAY RECAP *************************************************************************************************************************************************************************************************************************************************************************************************************
clickhouse-01              : ok=8    changed=1    unreachable=0    failed=0    skipped=3    rescued=0    ignored=0   
```
