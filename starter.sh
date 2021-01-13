#! /bin/sh
THEWAY=$(pwd)
#git clone https://github.com/andrei-schk/us_ident_study.git
unzip ./capstone_user_identification/3users
unzip ./capstone_user_identification/10users
unzip ./capstone_user_identification/150users
docker run -v $THEWAY/capstone_user_identification -p 8888:8888 andreischk/user_identification_study