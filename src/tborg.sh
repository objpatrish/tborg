#!/usr/bin/env sh

TB_REPO="/repo"
TB_ARCHIVE="/archive"

echo "initializing TBORG backup at $(date)"

echo "checking if repo exists.."
borg check ${TB_REPO} 2>/dev/null 

exists=$?

if test "${exists}" -ne -0
then
    echo "repo doesn't exist, creating.."
    borg init --verbose -e none ${TB_REPO}
fi

echo "repo exists, backing up..."
borg create --verbose ${TB_REPO}::backup-${TB_BACKUP_METADATA}-$(date +%F_%H-%M-%S.%N) ${TB_ARCHIVE} &&

if [[ -z "${TB_HOURLY}" ]]; then 
    TB_HOURLY=72 
fi
if [[ -z "${TB_DAILY}" ]]; then 
    TB_DAILY=14 
fi
if [[ -z "${TB_WEEKLY}" ]]; then 
    TB_WEEKLY=8 
fi
if [[ -z "${TB_MONTHLY}" ]]; then 
    TB_MONTHLY=6 
fi

echo "pruning according to retention strategy: hourly: ${TB_HOURLY} daily: ${TB_DAILY} weekly: ${TB_WEEKLY} monthly: ${TB_MONTHLY}.."
borg prune --verbose --keep-hourly ${TB_HOURLY} --keep-daily ${TB_DAILY} --keep-weekly ${TB_WEEKLY} --keep-monthly ${TB_MONTHLY} ${TB_REPO}

echo "backup done, have nice day :)"
