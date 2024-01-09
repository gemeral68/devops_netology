# Домашнее задание к занятию 12 «GitLab»

## DevOps

```bash
Running with gitlab-runner 16.6.1 (f5da3c5a)
  on gitlab-runner tFU7SyQ8, system ID: s_7f41121eb447
Preparing the "shell" executor
00:00
Using Shell (bash) executor...
Preparing environment
00:01
Running on test1...
Getting source from Git repository
00:01
Fetching changes with git depth set to 20...
Reinitialized existing Git repository in /home/gitlab-runner/builds/tFU7SyQ8/0/root/netology/.git/
Checking out f222998f as detached HEAD (ref is main)...
Skipping Git submodules setup
Executing "step_script" stage of the job script
02:44
$ echo "Building the image..."
Building the image...
$ docker build -t $VER_IMAGE .
DEPRECATED: The legacy builder is deprecated and will be removed in a future release.
            Install the buildx component to build images with BuildKit:
            https://docs.docker.com/go/buildx/
Step 1/17 : FROM centos:7
 ---> eeb6ee3f44bd
Step 2/17 : ENV PYTHON_VER=3.7.11     PYTHON_MINOR=3.7
 ---> Using cache
 ---> 183ea59be5f0
Step 3/17 : RUN yum makecache
 ---> Using cache
 ---> 9c1333460420
Step 4/17 : RUN yum install -y wget make gcc openssl-devel bzip2-devel libffi-devel zlib-devel xz-devel
 ---> Using cache
 ---> d3de79438826
Step 5/17 : WORKDIR /usr/src
 ---> Using cache
 ---> fef74afb6e42
Step 6/17 : RUN wget https://www.python.org/ftp/python/${PYTHON_VER}/Python-${PYTHON_VER}.tgz
 ---> Using cache
 ---> 5f2e4bfbf60c
Step 7/17 : RUN tar xzf Python-${PYTHON_VER}.tgz
 ---> Using cache
 ---> b2146bdd25ea
Step 8/17 : WORKDIR /usr/src/Python-${PYTHON_VER}
 ---> Using cache
 ---> 95f85be82254
Step 9/17 : RUN ./configure --enable-optimizations
 ---> Using cache
 ---> 5a239c5f9225
Step 10/17 : RUN make altinstall
 ---> Using cache
 ---> aab88168cd61
Step 11/17 : RUN rm /usr/src/Python-${PYTHON_VER}.tgz
 ---> Using cache
 ---> 6b5640ec1989
Step 12/17 : RUN python3.7 -V
 ---> Using cache
 ---> 6a7cfb370f5e
Step 13/17 : WORKDIR /python_api
 ---> Using cache
 ---> 4deac23b119c
Step 14/17 : COPY requirements.txt python-api.py ./
 ---> Using cache
 ---> b9832cdc8eff
Step 15/17 : RUN pip${PYTHON_MINOR} install -r requirements.txt
 ---> Using cache
 ---> bf1984302260
Step 16/17 : EXPOSE 5290
 ---> Using cache
 ---> b921c1e4593d
Step 17/17 : CMD python${PYTHON_MINOR} python-api.py
 ---> Using cache
 ---> 86c57940f54d
Successfully built 86c57940f54d
Successfully tagged 10.116.100.32:5001/hello:gitlab-f222998f
$ docker push $VER_IMAGE
The push refers to repository [10.116.100.32:5001/hello]
e9dc118cdfb5: Preparing
c39da07ff309: Preparing
9dc58dbe050e: Preparing
639c5bed8339: Preparing
0cb6c7c91368: Preparing
29cc67a931d9: Preparing
339f58a80637: Preparing
1c827b48f096: Preparing
3020b121b9ec: Preparing
aaab6472b015: Preparing
174f56854903: Preparing
29cc67a931d9: Waiting
339f58a80637: Waiting
1c827b48f096: Waiting
3020b121b9ec: Waiting
aaab6472b015: Waiting
174f56854903: Waiting
c39da07ff309: Pushed
639c5bed8339: Pushed
9dc58dbe050e: Pushed
29cc67a931d9: Pushed
1c827b48f096: Pushed
e9dc118cdfb5: Pushed
aaab6472b015: Pushed
339f58a80637: Pushed
3020b121b9ec: Pushed
174f56854903: Pushed
0cb6c7c91368: Pushed
gitlab-f222998f: digest: sha256:73f4d3d16c9bc9b3fd6bcbd6100c5c8ed26452c237bc8039988674f6c759a611 size: 2633
Job succeeded
```
```bash
docker run -d --name netology -p 5290:5290 86c57940f54d
df57e1a1cb1b90719850ba109eb72e42233ca7d5cda1d29c7be187e290a9825b
root@test1:/home/telecor# docker ps
CONTAINER ID   IMAGE                     COMMAND                  CREATED         STATUS                    PORTS                                                                                NAMES
df57e1a1cb1b   86c57940f54d              "/bin/sh -c 'python$…"   9 seconds ago   Up 7 seconds              0.0.0.0:5290->5290/tcp, :::5290->5290/tcp                                            netology
```
```bash
curl localhost:5290/get_info
{"version": 3, "method": "GET", "message": "Already started"}
```
