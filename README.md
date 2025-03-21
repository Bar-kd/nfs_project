**NFS Network using Docker Compose**

**Overview**

This project sets up an NFS (Network File System) network using Docker Compose. 
It includes an NFS server (mizar) and an NFS client (alcor). 
The client mounts a shared directory from the server, enabling file sharing between containers.

**Prerequisites**

Ensure you have the following installed:
- Docker
- Docker Compose

**Setup Instructions**

1. Clone the repository
2. Build and start the NFS server and client - ```docker-compose up --build```
3. Stop and clean up the containers - ```docker-compose down -v```
