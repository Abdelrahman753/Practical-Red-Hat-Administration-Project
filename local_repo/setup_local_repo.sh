#!/bin/bash
# Script to configure a local YUM repository and install MariaDB
MOUNTPATH="/mnt/repo"
REPOPATH="/etc/yum.repos.d/local.repo"
LOGFILE="/var/log/local_repo.log"

echo "[$(date)] Starting local repository setup..." >> $LOGFILE
# configure yhe local repository
echo -e "[BaseOS-http]
name=RHEL 9 BaseOS Local HTTP Repository
baseurl=http://repo.local/repo/BaseOS
enabled=1
gpgcheck=0

[AppStream-http]
name=RHEL 9 AppStream Local HTTP Repository
baseurl=http://repo.local/repo/AppStream
enabled=1
gpgcheck=0" > $REPOPATH

# Check if the repository file was created successfully
if [ -f $REPOPATH ]; then
    echo "[$(date)] RepoFile configured successfully at $REPOPATH" >> $LOGFILE
else
    echo "[$(date)] Failed to Configure RepoFile" >> $LOGFILE
    exit 1
fi

# Verify the repository configuration
if  6; then
    echo "[$(date)] LocalRepo IS CONFIGURED SUCCESSFULLY" >> $LOGFILE
else
    echo "[$(date)] LccalRepo IS NOT CONFIGURED SUCCESSFULLY" >> $LOGFILE
    exit 1
fi

# Install MariaDB
if rpm -q mariaDB &>> /dev/null; then
        echo "[$(date)] MariaDB is already installed." >> $LOGFILE
else
        echo "[$(date)] Installing MariaDB..." >> $LOGFILE
        dnf install mariadb -y >> $LOGFILE
fi

# Verify MariaDB installation
if [ $? -eq 0  ] ; then
        echo "[$(date)] MariaDB installed successfully." >> $LOGFILE
else
        echo "[$(date)] MariaDB installation failed." >> $LOGFILE
        exit 1
fi


