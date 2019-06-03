# clusterbot-setup-script
A script that automatically sets up development environment for ceph-dashboard use

# Setup:

Make sure that you have downloaded the Openshift Client and that the executable "oc" is in your "bin" directory. The download can be found here: https://github.com/openshift/origin/releases/tag/v3.11.0

Then install the proper file for your operationg system (for Fedora, we will be using the **file highlighted in blue below** )

![oc](https://user-images.githubusercontent.com/36835422/58800817-e2700b00-85d6-11e9-9557-42115e9a38df.png)

Alternatively, you could run the following two commands, and the file will automatically be downloaded into your current directory:

```sudo curl -LS -o h.tar.gz https://github.com/openshift/origin/releases/download/v3.11.0/openshift-origin-client-tools-v3.11.0-0cbc58b-linux-64bit.tar.gz
sudo tar -xzvf h.tar.gz -C ./
```

Proceed to cd into the downloaded file, then copy the executable "oc" into your "bin" directory

`cd openshift-origin-client-tools-v3.11.0-0cvc58b-linux-64bit`
`cp oc \home\bin`

# How to Use:

### Make sure you have:
1. Username of your cluster bot **(Highlighted in Blue below)**
2. Password of your cluster bot **(Highlighted in Blue below)**

![clusterbot-user-and-pass](https://user-images.githubusercontent.com/36835422/58724848-a2791000-83ab-11e9-9e3f-4a5f00348431.png)

3. Server for your cluster bot **(Highlighted in Blue below)**


![server](https://user-images.githubusercontent.com/36835422/58724857-a7d65a80-83ab-11e9-8cc7-dccd36b74d6f.png)


Once the script is run, you will be asked to provide your username **(Number 1 above)**, your password **(Number 2 above)** and your server **(Number 3 above)**. Input these values when prompted.


After running the script, a password should be printed at the bottom of your terminal **(Bottom of screenshot below)**. That is your ceph-dashboard password.

Likewise, a URL for a AWS server should be printed (it will be labeled "External IP"). Copy and paste into your web browser along with the port next to it (4 digits), and you should be able to login to ceph-dashboard (add a colon between the IP and the port in your browser). **Below is a picture of the link and port (highlighted) as well as the password (at the bottom)**

![screenshot-of-aws](https://user-images.githubusercontent.com/36835422/58724582-04854580-83ab-11e9-99b4-bf95aec53db9.png)

**Username for ceph dashboard is admin.
Password is the password printed when the script is done.**


