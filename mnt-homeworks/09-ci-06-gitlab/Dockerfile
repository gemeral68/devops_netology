FROM centos:7

ENV PYTHON_VER=3.7.11 \
    PYTHON_MINOR=3.7

RUN yum makecache 
RUN yum install -y wget make gcc openssl-devel bzip2-devel libffi-devel zlib-devel xz-devel  

WORKDIR /usr/src

RUN wget https://www.python.org/ftp/python/${PYTHON_VER}/Python-${PYTHON_VER}.tgz 
RUN tar xzf Python-${PYTHON_VER}.tgz 

WORKDIR /usr/src/Python-${PYTHON_VER}

RUN ./configure --enable-optimizations 
RUN make altinstall 
RUN rm /usr/src/Python-${PYTHON_VER}.tgz 
RUN python3.7 -V 

WORKDIR /python_api

COPY requirements.txt python-api.py ./

RUN pip${PYTHON_MINOR} install -r requirements.txt

EXPOSE 5290

CMD python${PYTHON_MINOR} python-api.py
