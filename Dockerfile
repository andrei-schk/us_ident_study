FROM ubuntu:latest

LABEL maintainer = "andrei <andrey@savchuk.biz>"

RUN apt update && \
	apt install -y python3-venv && \
	VE="/opt/venv" && \
	python3 -m venv $VE && \
	PATH=$VE/bin:$PATH &&  \
	pip install --quiet notebook numpy pandas scipy matplotlib statsmodels seaborn scikit-learn xgboost tqdm &&\
	useradd -ms /bin/bash client && \
	chown client opt && \
	chsh -s /bin/bash client && \
	echo "root:shvG.JsHq1TEY" | chpasswd -e 

USER	client

COPY . .

EXPOSE 8888

WORKDIR notebooks

CMD export PATH=/opt/venv/bin:$PATH && \
	PASSHASH='argon2:$argon2id$v=19$m=10240,t=10,p=8$9fLW8QZ23JfI49mKisIGZg$TVtnC4chMHWwkPv2PPB4XQ' && \
	bash -c "jupyter notebook --NotebookApp.password='$PASSHASH' --ip='0.0.0.0'"