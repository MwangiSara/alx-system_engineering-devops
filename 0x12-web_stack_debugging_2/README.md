
# 0x12. Web stack debugging #2

DevOps, SysAdmin, Scripting, Debugging

### Concepts

_For this project, we expect you to look at this concept:_

-   [Web stack debugging](https://intranet.alxswe.com/concepts/68)
# Web stack debugging

  

# Intro

  

Debugging usually takes a big chunk of a software engineer’s time. The art of debugging is tough and it takes years, even decades to master, and that is why seasoned software engineers are the best at it… experience. They have seen lots of broken code, buggy systems, weird edge cases and race conditions.

  

![](https://s3.amazonaws.com/alx-intranet.hbtn.io/uploads/medias/2020/9/45dffb0b1da8dc2ce47e340d7f88b05652c0f486.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIARDDGGGOUSBVO6H7D%2F20240513%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20240513T120220Z&X-Amz-Expires=86400&X-Amz-SignedHeaders=host&X-Amz-Signature=ab1eec4a1a7dee0a5c65b90e21df1ad3ddf6e394693d595ef57117603afe39df)

  

# Non-exhaustive guide to debugging

  

## School specific

  

If you are struggling to get something right that is run on the checker, like a Bash script or a piece of code, keep in mind that you can simulate the flow by starting a Docker container with the distribution that is specified in the requirements and by running your code. Check the **Docker** concept page for more info.

  

## Test and verify your assumptions

  

The idea is to ask a set of questions until you find the issue. For example, if you installed a web server and it isn’t serving a page when browsing the IP, here are some questions you can ask yourself to start debugging:

  

- Is the web server started? - You can check using the service manager, also double check by checking process list.

- On what port should it listen? - Check your web server configuration

- Is it actually listening on this port? - `netstat -lpdn` - run as `root` or `sudo` so that you can see the process for each listening port

- It is listening on the correct server IP? - `netstat` is also your friend here

- Is there a firewall enabled?

- Have you looked at logs? - usually in `/var/log` and `tail -f` is your friend

- Can I connect to the HTTP port from the location I am browsing from? - `curl` is your friend

  

There is a good chance that at this point you will already have found part of the issue.

  

## Get a quick overview of the machine state

  

[Youtube video First 5 Commands When I Connect on a Linux Server](https://www.youtube.com/watch?v=1_gqlbADaAw&feature=youtu.be  "Youtube video First 5 Commands When I Connect on a Linux Server")

  

When you connect to a server/machine/computer/container you want to understand what’s happened recently and what’s happening now, and you can do this with [5 commands](https://www.linux.com/training-tutorials/first-5-commands-when-i-connect-linux-server/  "5 commands") in a minute or less:

  

###  `w`

  

- shows server [uptime](https://www.techtarget.com/whatis/definition/uptime-and-downtime  "uptime") which is the time during which the server has been continuously running

- shows which users are connected to the server

- load average will give you a good sense of the server health - (read more about load [here](https://scoutapm.com/blog/understanding-load-averages  "here") and [here](https://www.brendangregg.com/blog/2017-08-08/linux-load-averages.html  "here"))

  

###  `history`

  

- shows which commands were previously run by the user you are currently connected to

- you can learn a lot about what type of work was previously performed on the machine, and what could have gone wrong with it

- where you might want to start your debugging work

  

###  `top`

  

- shows what is currently running on this server

- order results by CPU, memory utilization and catch the ones that are resource intensive

  

###  `df`

  

- shows disk utilization

  

###  `netstat`

  

- what port and IP your server is listening on

- what processes are using sockets

- try `netstat -lpn` on a Ubuntu machine

  

## Machine

  

Debugging is pretty much about verifying assumptions, in a perfect world the software or system we are working on would be working perfectly, the server is in perfect shape and everybody is happy. But actually, it NEVER goes this way, things ALWAYS fail (it’s tremendous!).

  

For the machine level, you want to ask yourself these questions:

  

- Does the server have free disk space? - `df`

- Is the server able to keep up with CPU load? - `w`, `top`, `ps`

- Does the server have available memory? `free`

- Are the server disk(s) able to keep up with read/write IO? - `htop`

  

If the answer is **no** for any of these questions, then that might be the reason why things are not going as expected. There are often 3 ways of solving the issue:

  

- free up resources (stop process(es) or reduce their resource consumption)

- increase the machine resources (adding memory, CPU, disk space…)

- distributing the resource usage to other machines

  

## Network issue

  

For the machine level, you want to ask yourself these questions:

  

- Does the server have the expected network interfaces and IPs up and running? `ifconfig`

- Does the server listen on the sockets that it is supposed to? `netstat` (`netstat -lpd` or `netstat -lpn`)

- Can you connect from the location you want to connect from, to the socket you want to connect to? `telnet` to the IP + PORT (`telnet 8.8.8.8 80`)

- Does the server have the correct firewall rules? `iptables`, `ufw`:

-  `iptables -L`

-  `sudo ufw status`

  

## Process issue

  

If a piece of Software isn’t behaving as expected, it can obviously be because of above reasons… but the good news is that there is more to look into (there is ALWAYS more to look into actually).

  

- Is the software started? `init`, `init.d`:

-  `service NAME_OF_THE_SERVICE status`

-  `/etc/init.d/NAME_OF_THE_SERVICE status`

- Is the software process running? `pgrep`, `ps`:

-  `pgrep -lf NAME_OF_THE_PROCESS`

-  `ps auxf`

- Is there anything interesting in the logs? look for log files in `/var/log/` and `tail -f` is your friend

  

## Debugging is fun

  

Debugging can be frustrating, but it will definitely be part of your job, it requires experience and methodology to become good at it. The good news is that bugs are never going away, and the more experienced you become, trickier bugs will be assigned to you! Good luck :)

  

![](https://s3.amazonaws.com/alx-intranet.hbtn.io/uploads/medias/2020/9/bae58c9f066a9668001ef4b4c39778407439d2f9.gif?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIARDDGGGOUSBVO6H7D%2F20240513%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20240513T120220Z&X-Amz-Expires=86400&X-Amz-SignedHeaders=host&X-Amz-Signature=c79c20ac24df0e7e908bf52edfc99f2f6575b93d49a8816edcf9cb823f489e5c)
  
  

![](https://s3.amazonaws.com/intranet-projects-files/holbertonschool-sysadmin_devops/284/V1HjQ1Y.png)

![](https://s3.amazonaws.com/intranet-projects-files/holbertonschool-sysadmin_devops/287/99littlebugsinthecode-holberton.jpg)

## Requirements

### General

-   All your files will be interpreted on Ubuntu 20.04 LTS
-   All your files should end with a new line
-   A [README.md](https://tiloid.com/ "README.md") file at the root of the folder of the project is mandatory
-   All your Bash script files must be executable
-   Your Bash scripts must pass  `Shellcheck`  without any error
-   Your Bash scripts must run without error
-   The first line of all your Bash scripts should be exactly  `#!/usr/bin/env bash`
-   The second line of all your Bash scripts should be a comment explaining what is the script doing

## Tasks

### 0. Run software as another user

mandatory

![](https://s3.amazonaws.com/alx-intranet.hbtn.io/uploads/medias/2020/9/eaeff07a715ff880b1ceb8e863a1d141a74a7f85.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIARDDGGGOUSBVO6H7D%2F20240513%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20240513T114720Z&X-Amz-Expires=86400&X-Amz-SignedHeaders=host&X-Amz-Signature=3cb798345f19a8f98c2f7d5665a971c1748d3044cbf30e2a1e630e6918d5de93)

The user  `root`  is, on Linux, the “superuser”. It can do anything it wants, that’s a good and bad thing. A good practice is that one should never be logged in the  `root`  user, as if you fat finger a command and for example run  `rm -rf /`, there is no comeback. That’s why it is preferable to run as a privileged user, meaning that the user also has the ability to perform tasks that the  `root`  user can do, just need to use a specific command that you need to discover.

For the containers that you are given in this project as well as the checker, everything is run under the  `root`  user, which has the ability to run anything as another user.

Requirements:

-   write a Bash script that accepts one argument
-   the script should run the  `whoami`  command under the user passed as an argument
-   make sure to try your script by passing different users

Example:

```
root@ubuntu:~# whoami
root
root@ubuntu:~# ./0-iamsomeoneelse www-data
www-data
root@ubuntu:~# whoami
root
root@ubuntu:~#

```

**Repo:**

-   GitHub repository:  `alx-system_engineering-devops`
-   Directory:  `0x12-web_stack_debugging_2`
-   File:  `0-iamsomeoneelse`

Done?  Get a sandbox

### 1. Run Nginx as Nginx

mandatory

The  `root`  user is a superuser that can do anything on a Unix machine, the top administrator. Security wise, you must do everything that you can to prevent an attacker from logging in as  `root`. With this in mind, it’s a good practice not to run your web servers as  `root`  (which is the default for most configurations) and instead run the process as the less privileged  `nginx`  user instead. This way, if a hacker does find a security issue that allows them to break-in to your server, the impact is limited by the permissions of the  `nginx`  user.

Fix this container so that Nginx is running as the  `nginx`  user.

Requirements:

-   `nginx`  must be running as  `nginx`  user
-   `nginx`  must be listening on all active IPs on port  `8080`
-   You cannot use  `apt-get remove`
-   Write a Bash script that configures the container to fit the above requirements

After debugging:

```
root@ab6f4542747e:~# ps auxff | grep ngin[x]
nginx      884  0.0  0.0  77360  2744 ?        Ss   19:16   0:00 nginx: master process /usr/sbin/nginx
nginx      885  0.0  0.0  77712  2772 ?        S    19:16   0:00  \_ nginx: worker process
nginx      886  0.0  0.0  77712  3180 ?        S    19:16   0:00  \_ nginx: worker process
nginx      887  0.0  0.0  77712  3180 ?        S    19:16   0:00  \_ nginx: worker process
nginx      888  0.0  0.0  77712  3208 ?        S    19:16   0:00  \_ nginx: worker process
root@ab6f4542747e:~#
root@ab6f4542747e:~# nc -z 0 8080 ; echo $?
0
root@ab6f4542747e:~#

```

**Repo:**

-   GitHub repository:  `alx-system_engineering-devops`
-   Directory:  `0x12-web_stack_debugging_2`
-   File:  `1-run_nginx_as_nginx`

Done?  Get a sandbox

### 2. 7 lines or less

#advanced

Using what you did for task #1, make your fix short and sweet.

Requirements:

-   Your Bash script must be 7 lines long or less
-   There must be a new line at the end of the file
-   You respect Bash script requirements
-   You cannot use  `;`
-   You cannot use  `&&`
-   You cannot use  `wget`
-   You cannot execute your previous answer file (Do not include the name of the previous script in this one)

**Repo:**

-   GitHub repository:  `alx-system_engineering-devops`
-   Directory:  `0x12-web_stack_debugging_2`
-   File:  `100-fix_in_7_lines_or_less`

Done?  Get a sandbox
