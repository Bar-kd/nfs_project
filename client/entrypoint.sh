#!/bin/bash

service rpcbind start
service nfs-common start

if ! pgrep -x "rpc.statd" > /dev/null; then
    service rpc.statd start
fi

while ! mount -t nfs mizar:/data /mnt/nfs; do
    echo "Waiting for NFS mount..."
    sleep 2
done

/files_creator.sh

tail -f /dev/null