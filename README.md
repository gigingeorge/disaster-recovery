# Disaster Recovery

 This project explains about a disaster recovery on an AWS cloud. 
 
### Feature
 1. We can easily build the infrastructure and the contents using single bash script. 
 2. We will keep latest AMI of our instance automatically. 

### Tools Used
1. Git
2. Jenkins
3. Packer
4. Ansible
5. Terraform

All to be executed on AWS cloud. 

The Process flow will be

![alt text](https://i.ibb.co/Lx3pWHk/Screenshot.png)

Whenever a change is made by developer, via github webhook, it will execute the packer AMI builder via Jenkins. The Packer task on Jenkins is pipelined with Ansible so that whenever new AMI is created, old AMI will get removed.

So every time we have the latest AMI of our instance.

The second scenario is, when our full infrastructure configured is crashed due to some unforeseen reasons, by executing a script (recovery.sh) will make our infrastructure along with the website contents up and running.

I used Terraform to build the stack using the latest AMI we created earlier and Ansible to fetch the website contents from Git


------------------------- Gigin George-------------------------------------

------------------------ gigingkallumkal@gmail.com ------------------------

------------------- https://www.linkedin.com/in/gigin-george/ --------------
