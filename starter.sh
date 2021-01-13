#! /bin/sh
THEWAY=$(pwd)

unzip ./capstone_user_identification/3users.zip -d ./capstone_user_identification
unzip /capstone_user_identification/10users.zip -d ./capstone_user_identification
unzip /capstone_user_identification/150users.zip -d ./capstone_user_identification
docker run -v $THEWAY/capstone_user_identification:/client/notebooks/capstone_user_identification -p 8888:8888 andreischk/user_identification_study

#git clone https://github.com/andrei-schk/us_ident_study.git
#cd us_ident_study
#/bin/bash starter.sh
