***"vm-docker"*** is creating a virtual machine which has docker installed.

Connect to vm:

1. generate a ssh key: 

    `sh-keygen -t rsa`

2. set the path of the public key in *admin_ssh_key* section alongside with the username 
3. *public_ip_address* output shows the ip address of the vm
4. ssh -i ~/.ssh/name_of_the_key username@ip_address
