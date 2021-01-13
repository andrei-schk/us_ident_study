FROM ubuntu:latest

LABEL maintainer = "andrei <andrey@savchuk.biz>"

USER root

RUN	apt update && \
	apt install -yq --no-install-recommends wget ca-certificates && \
	apt clean && \
	wget --quiet -O opt/Miniconda3-latest-Linux-x86_64.sh "https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh" && \
	rm -rf /var/lib/apt/lists/*

RUN		useradd -ms /bin/bash client && \
		chown client opt && \
		chsh -s /bin/bash client

USER	client

RUN	bash opt/Miniconda3-latest-Linux-x86_64.sh -f -b && \
	export PATH=~/miniconda3/bin:$PATH	&& \
	bash -c "conda  install --quiet --yes conda pip tini notebook" && \
	bash -c "conda install --quiet --yes -c conda-forge  numpy pandas scipy matplotlib statsmodels seaborn scikit-learn xgboost" && \
	exit	&& \
	rm opt/Miniconda3-latest-Linux-x86_64.sh && \
	rm -rf /var/lib/apt/lists/* 

COPY . .

EXPOSE 8888

USER client

WORKDIR notebooks

CMD 	export PATH=~/miniconda3/bin:$PATH && \
		PASSHASH=$(~/miniconda3/bin/python3 -c "from notebook.auth import passwd; print(passwd('winter'))") && \
		bash -c "jupyter notebook --NotebookApp.password='$PASSHASH' --ip='0.0.0.0'"