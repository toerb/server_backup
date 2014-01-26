#!/bin/bash

PASSPHRASE=''
export PASSPHRASE

LOGDATE=$(date +%Y-%m-%d)
NAME=''
LOGDIR='/var/log/duplicity'

duplicity remove-all-but-n-full 2 -v5 --force sftp://${SOME_HOST}/${NAME}_backup >> ${LOGDIR}/${NAME}_${LOGDATE}.log

duplicity --full-if-older-than 14D -v5 --gpg-options '--cipher-algo AES256' --exclude-filelist /usr/local/etc/duplicity-exclude.conf / sftp://${SOME_HOST}/${NAME}_backup >> ${LOGDIR}/${NAME}_${LOGDATE}.log 

unset PASSPHRASE
gzip "${LOGDIR}/${NAME}_${LOGDATE}.log"
