# clusterbot-setup-script
A script that automatically sets up development environment for ceph-dashboard use

# Setup:

Make sure you have **downloaded the kubeconfig file from cluster-bot on Slack to your Downloads folder**. This can be done by simply clicking the Download button (looks like a little cloud) shown below:

![dwn](https://user-images.githubusercontent.com/36835422/58883319-284ad300-86ac-11e9-8dff-a791d37dcf2b.png)

# How to Use:

### Make sure you have:
1. Username of your cluster bot **(Highlighted in Blue below)**
2. Password of your cluster bot **(Highlighted in Blue below)**

![clusterbot-user-and-pass](https://user-images.githubusercontent.com/36835422/58724848-a2791000-83ab-11e9-9e3f-4a5f00348431.png)


To run the script, download the file botscript.sh and run it:

```
sudo ./botscript.sh
```

Once the script is run, you will be asked to provide your username **(Number 1 above)** and your password **(Number 2 above)**. Input these values when prompted.


After running the script, a password should be printed at the bottom of your terminal **(Bottom of screenshot below)**. That is your ceph-dashboard password.

Likewise, a URL for a AWS server should be printed (it will be labeled "External IP"). Copy and paste into your web browser along with the port next to it (4 digits), and you should be able to login to ceph-dashboard (add a colon between the IP and the port in your browser). **Below is a picture of the link and port (highlighted) as well as the password (at the bottom)**

![screenshot-of-aws](https://user-images.githubusercontent.com/36835422/58724582-04854580-83ab-11e9-99b4-bf95aec53db9.png)

**Username for ceph dashboard is admin.
Password is the password printed when the script is done.**


