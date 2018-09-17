# Requirements
You must have the following before beginning:

* a working and configured Kubernetes cluster with some pods running
* kubectl



---

---
# Installation on nix systems
1. Navigate to `bin` directory:

        cd /usr/local/bin

1. Copy `.sshpod.sh` to `usr/local/bin`.
1. Change permissions on the file:

        chmod +x .sshpod.sh

1. Open `~/.bashrc` in any text editor.
1. Add this line to the end of the file:

        source ~/.my_custom_commands.sh

1. Save and exit.
1. Restart terminal before use.


---
# Usage

1. Make sure that you are on your desired context and namespace.
1. Execute:

        sshpod
        
1. Which will give you a numbered list of all pods within your cluster and namespace like so:

        1 --> staging-testone-7965b9f5-45lhr
        2 --> staging-testone-7965b9f5-45lhr
        3 --> staging-testtwo-7965b9f5-45lhr
        4 --> staging-testtwo-7965b9f5-45lhr
        5 --> staging-testthree-7965b9f5-45lhr
        6 --> staging-testthree-7965b9f5-45lhr

1. Enter the number of the pod you wish to ssh into and hit return.
1. Response should take you inside the pod which will look like this:

        root@staging-testone-7965b9f5-45lhr:/var/www/html#
      
