#!/bin/bash

touch /data/root_squash
echo "root_squash has been created!"
chown root:root /data/root_squash
chmod 644 /data/root_squash

echo "/data 172.18.0.3(rw,sync,no_subtree_check,no_root_squash)" > /etc/exports
#Apply the NFS export changes
exportfs -rav
echo "NFS export updated with no_root_squash."

touch /data/no_squash
echo "no_squash has been created!"
chown root:root /data/no_squash
chmod 644 /data/no_squash