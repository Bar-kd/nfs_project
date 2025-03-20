#!/bin/bash

# Configure NFS exports
echo "/data 172.18.0.3(rw,sync,no_subtree_check,root_squash)" >> /etc/exports
# Apply the NFS export changes
exportfs -rav

# Set permissions
chmod -R 777 /data
chown -R nobody:nogroup /data

# Start required services
service rpcbind start
service nfs-kernel-server start
exportfs -r

cleanup() {
    echo "Stopping NFS services..."

    # Unexport NFS shares
    exportfs -uav

    # identifies and kills all processes that are currently using the /data directory
    fuser -km /data

    service nfs-kernel-server stop
    service rpcbind stop
    killall rpcbind
    killall nfsd

    echo "All services stopped. Exiting..."
    exit 0
}
trap cleanup SIGTERM SIGINT

/files_creator.sh

# Keep container running
tail -f /dev/null