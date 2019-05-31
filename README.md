# clusterbot-setup-script
A script that automatically sets up development environment for ceph-dashboard use

# How to Use:

Make sure you have:
1. Username of your cluster bot (always kubeadmin), also found on slack
2. Password of your cluster bot (found on slack next to username)
3. Server for your cluster bot (found within the file from slack)

Once the script is run, you will be asked to provide your username (kubeadmin), your password (provided by cluster-bot on slack) and your server (within the file cluster-bot gives you). Input these values.

After running the script, a password should be printed at the bottom of your terminal. That is your ceph-dashboard password.
Likewise, a URL for a AWS server should be printed (it will be labeled "External IP"). Copy and paste into your web browser along with the port next to it (4 digits), and you should be able to login to ceph-dashboard (add a colon between the IP and the port). **Below is a picture of the link and port (highlighted) as well as the password (at the bottom**

![screenshot-of-aws](https://user-images.githubusercontent.com/36835422/58724582-04854580-83ab-11e9-99b4-bf95aec53db9.png)

Username for ceph dashboard is admin.
Password is the password printed when the script is done.
