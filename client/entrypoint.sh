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

cleanup() {
    echo "Stopping NFS mount..."
    
    # Kill all processes using /mnt/nfs before unmounting
    fuser -km /mnt/nfs

    # Force unmount in case of any issues
    umount -f /mnt/nfs && echo "NFS unmounted successfully." || echo "Warning: Failed to unmount NFS!"

    echo "Stopping rpcbind and nfs-common..."
    killall rpcbind
    killall statd
    service nfs-common stop
    service rpcbind stop

    echo "Cleanup complete. Exiting..."
    exit 0
}
trap cleanup SIGTERM SIGINT

/files_creator.sh

tail -f /dev/null