#!/bin/bash

while ! mount -t nfs mizar:/data /mnt/nfs; do
    echo "Waiting for NFS mount..."
    sleep 2
done

echo "Creating 1,000 files of 2KB each in /mnt/nfs..."
mkdir -p /mnt/nfs

# Switch to star user and create 1,000 files of 2KB each named file_1 to file_1000
sudo -u star bash -c '
for i in {1..1000}; do
  truncate -s 2K /mnt/nfs/file_${i}
done '

echo "files creation is completed!"