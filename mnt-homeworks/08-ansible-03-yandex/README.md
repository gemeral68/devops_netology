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
ok: [clickhouse-01] => {"changed": false, "cmd": ["clickhouse-client", "-q", "create database logs;"], "delta": "0:00:01.427571", "end": "2023-08-24 14:07:22.410429", "failed_when_result": false, "msg": "non-zero return code", "rc": 82, "start": "2023-08-24 14:07:20.982858", "stderr": "Received exception from server (version 23.7.4):\nCode: 82. DB::Exception: Received from localhost:9000. DB::Exception: Database logs already exists.. (DATABASE_ALREADY_EXISTS)\n(query: create database logs;)", "stderr_lines": ["Received exception from server (version 23.7.4):", "Code: 82. DB::Exception: Received from localhost:9000. DB::Exception: Database logs already exists.. (DATABASE_ALREADY_EXISTS)", "(query: create database logs;)"], "stdout": "", "stdout_lines": []}

PLAY [Install Vector] *******************************************************************************************************************************************************************************************************************************************************************************************************************

TASK [Gathering Facts] ******************************************************************************************************************************************************************************************************************************************************************************************************************
task path: /home/bulat/Projects/Netology/Ansible/08-ansible-02-playbook/site.yml:47
ok: [vector-01]

TASK [Get_vector_version] ***************************************************************************************************************************************************************************************************************************************************************************************************************
task path: /home/bulat/Projects/Netology/Ansible/08-ansible-02-playbook/site.yml:60
changed: [vector-01] => {"changed": true, "cmd": ["vector", "--version"], "delta": "0:00:00.008255", "end": "2023-08-24 14:07:25.828759", "msg": "", "rc": 0, "start": "2023-08-24 14:07:25.820504", "stderr": "", "stderr_lines": [], "stdout": "vector 0.32.0 (x86_64-unknown-linux-gnu 1b403e1 2023-08-15 14:56:36.089460954)", "stdout_lines": ["vector 0.32.0 (x86_64-unknown-linux-gnu 1b403e1 2023-08-15 14:56:36.089460954)"]}

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
Notification for handler Start nginx has been saved.
--- before
+++ after: /home/bulat/.ansible/tmp/ansible-local-119114162f15uf_/tmppqtpsyg2/nginx_lighthouse.conf.j2
@@ -0,0 +1,20 @@
+server {
+        listen       8080;
+        server_name  _;
+        root         /usr/share/nginx/html/lighthouse/;
+        index        index.html;
+
+        # Load configuration files for the default server block.
+
+        location / {
+
+        }
+
+        error_page 404 /404.html;
+            location = /40x.html {
+        }
+
+        error_page 500 502 503 504 /50x.html;
+            location = /50x.html {
+        }
+}

changed: [lighthouse-01] => {"changed": true, "checksum": "42cfc0da2c8c1a45530ad55212c78114cc49b4c0", "dest": "/etc/nginx/conf.d/nginx_lighthouse.conf", "gid": 0, "group": "root", "md5sum": "44c6f2c985b0ece7e3f5f0d50104ea1e", "mode": "0644", "owner": "root", "secontext": "system_u:object_r:httpd_config_t:s0", "size": 422, "src": "/home/netology/.ansible/tmp/ansible-tmp-1692886058.2678475-1191539-38936080812842/source", "state": "file", "uid": 0}
NOTIFIED HANDLER Start nginx for lighthouse-01

RUNNING HANDLER [Start nginx] ***********************************************************************************************************************************************************************************************************************************************************************************************************
task path: /home/bulat/Projects/Netology/Ansible/08-ansible-02-playbook/site.yml:110
changed: [lighthouse-01] => {"changed": true, "name": "nginx", "state": "started", "status": {"ActiveEnterTimestamp": "Thu 2023-08-24 14:06:05 UTC", "ActiveEnterTimestampMonotonic": "7666299657", "ActiveExitTimestamp": "Thu 2023-08-24 14:06:05 UTC", "ActiveExitTimestampMonotonic": "7666244582", "ActiveState": "active", "After": "network-online.target basic.target -.mount system.slice remote-fs.target systemd-journald.socket tmp.mount nss-lookup.target", "AllowIsolate": "no", "AmbientCapabilities": "0", "AssertResult": "yes", "AssertTimestamp": "Thu 2023-08-24 14:06:05 UTC", "AssertTimestampMonotonic": "7666259756", "Before": "shutdown.target", "BlockIOAccounting": "no", "BlockIOWeight": "18446744073709551615", "CPUAccounting": "no", "CPUQuotaPerSecUSec": "infinity", "CPUSchedulingPolicy": "0", "CPUSchedulingPriority": "0", "CPUSchedulingResetOnFork": "no", "CPUShares": "18446744073709551615", "CanIsolate": "no", "CanReload": "yes", "CanStart": "yes", "CanStop": "yes", "CapabilityBoundingSet": "18446744073709551615", "CollectMode": "inactive", "ConditionResult": "yes", "ConditionTimestamp": "Thu 2023-08-24 14:06:05 UTC", "ConditionTimestampMonotonic": "7666259755", "Conflicts": "shutdown.target", "ControlGroup": "/system.slice/nginx.service", "ControlPID": "0", "DefaultDependencies": "yes", "Delegate": "no", "Description": "The nginx HTTP and reverse proxy server", "DevicePolicy": "auto", "ExecMainCode": "0", "ExecMainExitTimestampMonotonic": "0", "ExecMainPID": "18450", "ExecMainStartTimestamp": "Thu 2023-08-24 14:06:05 UTC", "ExecMainStartTimestampMonotonic": "7666299619", "ExecMainStatus": "0", "ExecReload": "{ path=/usr/sbin/nginx ; argv[]=/usr/sbin/nginx -s reload ; ignore_errors=no ; start_time=[n/a] ; stop_time=[n/a] ; pid=0 ; code=(null) ; status=0/0 }", "ExecStart": "{ path=/usr/sbin/nginx ; argv[]=/usr/sbin/nginx ; ignore_errors=no ; start_time=[Thu 2023-08-24 14:06:05 UTC] ; stop_time=[Thu 2023-08-24 14:06:05 UTC] ; pid=18448 ; code=exited ; status=0 }", "ExecStartPre": "{ path=/usr/sbin/nginx ; argv[]=/usr/sbin/nginx -t ; ignore_errors=no ; start_time=[Thu 2023-08-24 14:06:05 UTC] ; stop_time=[Thu 2023-08-24 14:06:05 UTC] ; pid=18445 ; code=exited ; status=0 }", "FailureAction": "none", "FileDescriptorStoreMax": "0", "FragmentPath": "/usr/lib/systemd/system/nginx.service", "GuessMainPID": "yes", "IOScheduling": "0", "Id": "nginx.service", "IgnoreOnIsolate": "no", "IgnoreOnSnapshot": "no", "IgnoreSIGPIPE": "yes", "InactiveEnterTimestamp": "Thu 2023-08-24 14:06:05 UTC", "InactiveEnterTimestampMonotonic": "7666258242", "InactiveExitTimestamp": "Thu 2023-08-24 14:06:05 UTC", "InactiveExitTimestampMonotonic": "7666265503", "JobTimeoutAction": "none", "JobTimeoutUSec": "0", "KillMode": "process", "KillSignal": "3", "LimitAS": "18446744073709551615", "LimitCORE": "18446744073709551615", "LimitCPU": "18446744073709551615", "LimitDATA": "18446744073709551615", "LimitFSIZE": "18446744073709551615", "LimitLOCKS": "18446744073709551615", "LimitMEMLOCK": "65536", "LimitMSGQUEUE": "819200", "LimitNICE": "0", "LimitNOFILE": "4096", "LimitNPROC": "3761", "LimitRSS": "18446744073709551615", "LimitRTPRIO": "0", "LimitRTTIME": "18446744073709551615", "LimitSIGPENDING": "3761", "LimitSTACK": "18446744073709551615", "LoadState": "loaded", "MainPID": "18450", "MemoryAccounting": "no", "MemoryCurrent": "18446744073709551615", "MemoryLimit": "18446744073709551615", "MountFlags": "0", "Names": "nginx.service", "NeedDaemonReload": "no", "Nice": "0", "NoNewPrivileges": "no", "NonBlocking": "no", "NotifyAccess": "none", "OOMScoreAdjust": "0", "OnFailureJobMode": "replace", "PIDFile": "/run/nginx.pid", "PermissionsStartOnly": "no", "PrivateDevices": "no", "PrivateNetwork": "no", "PrivateTmp": "yes", "ProtectHome": "no", "ProtectSystem": "no", "RefuseManualStart": "no", "RefuseManualStop": "no", "RemainAfterExit": "no", "Requires": "-.mount basic.target system.slice", "RequiresMountsFor": "/var/tmp", "Restart": "no", "RestartUSec": "100ms", "Result": "success", "RootDirectoryStartOnly": "no", "RuntimeDirectoryMode": "0755", "SameProcessGroup": "no", "SecureBits": "0", "SendSIGHUP": "no", "SendSIGKILL": "yes", "Slice": "system.slice", "StandardError": "inherit", "StandardInput": "null", "StandardOutput": "journal", "StartLimitAction": "none", "StartLimitBurst": "5", "StartLimitInterval": "10000000", "StartupBlockIOWeight": "18446744073709551615", "StartupCPUShares": "18446744073709551615", "StatusErrno": "0", "StopWhenUnneeded": "no", "SubState": "running", "SyslogLevelPrefix": "yes", "SyslogPriority": "30", "SystemCallErrorNumber": "0", "TTYReset": "no", "TTYVHangup": "no", "TTYVTDisallocate": "no", "TasksAccounting": "no", "TasksCurrent": "18446744073709551615", "TasksMax": "18446744073709551615", "TimeoutStartUSec": "1min 30s", "TimeoutStopUSec": "5s", "TimerSlackNSec": "50000", "Transient": "no", "Type": "forking", "UMask": "0022", "UnitFilePreset": "disabled", "UnitFileState": "disabled", "Wants": "network-online.target", "WatchdogTimestamp": "Thu 2023-08-24 14:06:05 UTC", "WatchdogTimestampMonotonic": "7666299636", "WatchdogUSec": "0"}}

PLAY RECAP ******************************************************************************************************************************************************************************************************************************************************************************************************************************
clickhouse-01              : ok=5    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
lighthouse-01              : ok=5    changed=2    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
vector-01                  : ok=4    changed=1    unreachable=0    failed=0    skipped=3    rescued=0    ignored=0
```
