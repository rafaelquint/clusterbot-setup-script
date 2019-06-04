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

At the bottom of your screen when the script is done, there should be a login provided as well as an AWS link. Copy the link and then use the login provided. A screenshot of the link and login info is shown below:

![awslog](https://user-images.githubusercontent.com/36835422/58890389-87164980-86b8-11e9-88da-396ffc228995.png)

**Username for ceph dashboard is admin.
Password is the password printed when the script is done.**


