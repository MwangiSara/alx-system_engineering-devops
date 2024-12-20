# 0x0F. Load balancer

DevOps, SysAdmin

#### In a nutshell…

### Concepts

_For this project, we expect you to look at these concepts:_

---   [Load balancer](https://intranet.alxswe.com/concepts/46)

# Load balancer

Ever wonder how Facebook, Linkedin, Twitter and other web giants are handling such huge amounts of traffic? They don’t have just one server, but tens of thousands of them. In order to achieve this, web traffic needs to be distributed to these servers, and that is the role of a load-balancer.

![](https://s3.amazonaws.com/alx-intranet.hbtn.io/uploads/medias/2020/9/6cefdd14b2f8c36789cba132bd5a10d42d88a177.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIARDDGGGOUSBVO6H7D%2F20240430%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20240430T123249Z&X-Amz-Expires=86400&X-Amz-SignedHeaders=host&X-Amz-Signature=0921292ac39bf1dc662a1acd08099440621638e1ff4526f66931b965b3333ef5)

### Readme:

-   [Load-balancing](https://www.thegeekstuff.com/2016/01/load-balancer-intro/ "Load-balancing")
-   [Load-balancing algorithms](https://community.f5.com/kb/technicalarticles/intro-to-load-balancing-for-developers-%E2%80%93-the-algorithms/273759 "Load-balancing algorithms")

---   [Web stack debugging](https://intranet.alxswe.com/concepts/68)

# Web stack debugging

# Intro

Debugging usually takes a big chunk of a software engineer’s time. The art of debugging is tough and it takes years, even decades to master, and that is why seasoned software engineers are the best at it… experience. They have seen lots of broken code, buggy systems, weird edge cases and race conditions.

![](https://s3.amazonaws.com/alx-intranet.hbtn.io/uploads/medias/2020/9/45dffb0b1da8dc2ce47e340d7f88b05652c0f486.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIARDDGGGOUSBVO6H7D%2F20240430%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20240430T123724Z&X-Amz-Expires=86400&X-Amz-SignedHeaders=host&X-Amz-Signature=a9aed6e3b6703655c3dc7adc8f1681315c39df2612ae0d8fb1bafa9f6174718c)

# Non-exhaustive guide to debugging

## School specific

If you are struggling to get something right that is run on the checker, like a Bash script or a piece of code, keep in mind that you can simulate the flow by starting a Docker container with the distribution that is specified in the requirements and by running your code. Check the  **Docker**  concept page for more info.

## Test and verify your assumptions

The idea is to ask a set of questions until you find the issue. For example, if you installed a web server and it isn’t serving a page when browsing the IP, here are some questions you can ask yourself to start debugging:

-   Is the web server started? - You can check using the service manager, also double check by checking process list.
-   On what port should it listen? - Check your web server configuration
-   Is it actually listening on this port? -  `netstat -lpdn`  - run as  `root`  or  `sudo`  so that you can see the process for each listening port
-   It is listening on the correct server IP? -  `netstat`  is also your friend here
-   Is there a firewall enabled?
-   Have you looked at logs? - usually in  `/var/log`  and  `tail -f`  is your friend
-   Can I connect to the HTTP port from the location I am browsing from? -  `curl`  is your friend

There is a good chance that at this point you will already have found part of the issue.

## Get a quick overview of the machine state

[Youtube video First 5 Commands When I Connect on a Linux Server](https://www.youtube.com/watch?v=1_gqlbADaAw "Youtube video First 5 Commands When I Connect on a Linux Server")

When you connect to a server/machine/computer/container you want to understand what’s happened recently and what’s happening now, and you can do this with  [5 commands](https://www.linux.com/training-tutorials/first-5-commands-when-i-connect-linux-server/ "5 commands")  in a minute or less:

### `w`

-   shows server  [uptime](https://www.techtarget.com/whatis/definition/uptime-and-downtime "uptime")  which is the time during which the server has been continuously running
-   shows which users are connected to the server
-   load average will give you a good sense of the server health - (read more about load  [here](https://scoutapm.com/blog/understanding-load-averages "here")  and  [here](https://www.brendangregg.com/blog/2017-08-08/linux-load-averages.html "here"))

### `history`

-   shows which commands were previously run by the user you are currently connected to
-   you can learn a lot about what type of work was previously performed on the machine, and what could have gone wrong with it
-   where you might want to start your debugging work

### `top`

-   shows what is currently running on this server
-   order results by CPU, memory utilization and catch the ones that are resource intensive

### `df`

-   shows disk utilization

### `netstat`

-   what port and IP your server is listening on
-   what processes are using sockets
-   try  `netstat -lpn`  on a Ubuntu machine

## Machine

Debugging is pretty much about verifying assumptions, in a perfect world the software or system we are working on would be working perfectly, the server is in perfect shape and everybody is happy. But actually, it NEVER goes this way, things ALWAYS fail (it’s tremendous!).

For the machine level, you want to ask yourself these questions:

-   Does the server have free disk space? -  `df`
-   Is the server able to keep up with CPU load? -  `w`,  `top`,  `ps`
-   Does the server have available memory?  `free`
-   Are the server disk(s) able to keep up with read/write IO? -  `htop`

If the answer is  **no**  for any of these questions, then that might be the reason why things are not going as expected. There are often 3 ways of solving the issue:

-   free up resources (stop process(es) or reduce their resource consumption)
-   increase the machine resources (adding memory, CPU, disk space…)
-   distributing the resource usage to other machines

## Network issue

For the machine level, you want to ask yourself these questions:

-   Does the server have the expected network interfaces and IPs up and running?  `ifconfig`
-   Does the server listen on the sockets that it is supposed to?  `netstat`  (`netstat -lpd`  or  `netstat -lpn`)
-   Can you connect from the location you want to connect from, to the socket you want to connect to?  `telnet`  to the IP + PORT (`telnet 8.8.8.8 80`)
-   Does the server have the correct firewall rules?  `iptables`,  `ufw`:
    -   `iptables -L`
    -   `sudo ufw status`

## Process issue

If a piece of Software isn’t behaving as expected, it can obviously be because of above reasons… but the good news is that there is more to look into (there is ALWAYS more to look into actually).

-   Is the software started?  `init`,  `init.d`:
    -   `service NAME_OF_THE_SERVICE status`
    -   `/etc/init.d/NAME_OF_THE_SERVICE status`
-   Is the software process running?  `pgrep`,  `ps`:
    -   `pgrep -lf NAME_OF_THE_PROCESS`
    -   `ps auxf`
-   Is there anything interesting in the logs? look for log files in  `/var/log/`  and  `tail -f`  is your friend

## Debugging is fun

Debugging can be frustrating, but it will definitely be part of your job, it requires experience and methodology to become good at it. The good news is that bugs are never going away, and the more experienced you become, trickier bugs will be assigned to you! Good luck :)

![](https://s3.amazonaws.com/alx-intranet.hbtn.io/uploads/medias/2020/9/bae58c9f066a9668001ef4b4c39778407439d2f9.gif?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIARDDGGGOUSBVO6H7D%2F20240430%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20240430T123724Z&X-Amz-Expires=86400&X-Amz-SignedHeaders=host&X-Amz-Signature=d99e2a29fd826015c1255b5c32506065d70bb7e729145d1a79627b148fd354ba)

![](https://s3.amazonaws.com/intranet-projects-files/holbertonschool-sysadmin_devops/275/qfdked8.png)

## Background Context

You have been given 2 additional servers:

-   gc-[STUDENT_ID]-web-02-XXXXXXXXXX
-   gc-[STUDENT_ID]-lb-01-XXXXXXXXXX

Let’s improve our web stack so that there is  [redundancy](https://en.wikipedia.org/wiki/Redundancy_%28engineering%29 "redundancy")  for our web servers. This will allow us to be able to accept more traffic by doubling the number of web servers, and to make our infrastructure more reliable. If one web server fails, we will still have a second one to handle requests.

For this project, you will need to write Bash scripts to automate your work. All scripts must be designed to configure a brand new Ubuntu server to match the task requirements.

## Resources

**Read or watch**:

-   [Introduction to load-balancing and HAproxy](https://www.digitalocean.com/community/tutorials/an-introduction-to-haproxy-and-load-balancing-concepts "Introduction to load-balancing and HAproxy")
-   [HTTP header](https://www.techopedia.com/definition/27178/http-header "HTTP header")
-   [Debian/Ubuntu HAProxy packages](https://haproxy.debian.net/ "Debian/Ubuntu HAProxy packages")

## Requirements

### General

-   Allowed editors:  `vi`,  `vim`,  `emacs`
-   All your files will be interpreted on Ubuntu 16.04 LTS
-   All your files should end with a new line
-   A  `README.md`  file, at the root of the folder of the project, is mandatory
-   All your Bash script files must be executable
-   Your Bash script must pass  `Shellcheck`  (version  `0.3.7`) without any error
-   The first line of all your Bash scripts should be exactly  `#!/usr/bin/env bash`
-   The second line of all your Bash scripts should be a comment explaining what is the script doing


## Your servers

Name: 530478-web-01
Username: `ubuntu`
IP: `52.91.126.218`
State: running
Actions Toggle Dropdown
 
Name: 530478-web-02
Username: `ubuntu`
IP: `54.89.178.237`
State: running
Actions Toggle Dropdown

Name: 530478-lb-01
Username: `ubuntu`
IP: `54.175.101.81`
State: running
Actions Toggle Dropdown

## Tasks

### 0. Double the number of webservers

mandatory

Score:  100.0%  (Checks completed: 100.0%)

In this first task you need to configure  `web-02`  to be identical to  `web-01`. Fortunately, you built a Bash script during your  [web server project](https://github.com/OluTshegz/alx-system_engineering-devops/tree/master/0x0C-web_server "web server project"), and they’ll now come in handy to easily configure  `web-02`. Remember, always try to automate your work!

Since we’re placing our web servers behind a load balancer for this project, we want to add a custom Nginx response header. The goal here is to be able to track which web server is answering our HTTP requests, to understand and track the way a load balancer works. More in the coming tasks.

Requirements:

-   Configure Nginx so that its HTTP response contains a custom header (on  `web-01`  and  `web-02`)
    -   The name of the custom HTTP header must be  `X-Served-By`
    -   The value of the custom HTTP header must be the hostname of the server Nginx is running on
-   Write  `0-custom_http_response_header`  so that it configures a brand new Ubuntu machine to the requirements asked in this task
    -   [Ignore](https://github.com/koalaman/shellcheck/wiki/Ignore  "Ignore")  [SC2154](https://github.com/koalaman/shellcheck/wiki/SC2154  "SC2154")  for  `shellcheck`

Example:

```
sylvain@ubuntu$ curl -sI 34.198.248.145 | grep X-Served-By
X-Served-By: 03-web-01
sylvain@ubuntu$ curl -sI 54.89.38.100 | grep X-Served-By
X-Served-By: 03-web-02
sylvain@ubuntu$

```

If your server’s hostnames are not properly configured (`[STUDENT_ID]-web-01` and `[STUDENT_ID]-web-02`.), follow this [tutorial](https://repost.aws/knowledge-center/linux-static-hostname  "tutorial").

**Repo:**

-   GitHub repository:  `alx-system_engineering-devops`
-   Directory:  `0x0F-load_balancer`
-   File:  `0-custom_http_response_header`

Done!  Check your code  Get a sandbox  QA Review

### 1. Install your load balancer

mandatory

Score:  100.0%  (Checks completed: 100.0%)

Install and configure HAproxy on your  `lb-01`  server.

Requirements:

-   Configure HAproxy so that it send traffic to  `web-01`  and  `web-02`
-   Distribute requests using a roundrobin algorithm
-   Make sure that HAproxy can be managed via an init script
-   Make sure that your servers are configured with the right hostnames:  `[STUDENT_ID]-web-01`  and  `[STUDENT_ID]-web-02`. If not, follow this  [tutorial](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/set-hostname.html "tutorial").
-   For your answer file, write a Bash script that configures a new Ubuntu machine to respect above requirements

Example:

```
sylvain@ubuntu$ curl -Is 54.210.47.110
HTTP/1.1 200 OK
Server: nginx/1.4.6 (Ubuntu)
Date: Mon, 27 Feb 2017 06:12:17 GMT
Content-Type: text/html
Content-Length: 30
Last-Modified: Tue, 21 Feb 2017 07:21:32 GMT
Connection: keep-alive
ETag: "58abea7c-1e"
X-Served-By: 03-web-01
Accept-Ranges: bytes

sylvain@ubuntu$ curl -Is 54.210.47.110
HTTP/1.1 200 OK
Server: nginx/1.4.6 (Ubuntu)
Date: Mon, 27 Feb 2017 06:12:19 GMT
Content-Type: text/html
Content-Length: 612
Last-Modified: Tue, 04 Mar 2014 11:46:45 GMT
Connection: keep-alive
ETag: "5315bd25-264"
X-Served-By: 03-web-02
Accept-Ranges: bytes

sylvain@ubuntu$

```

**Repo:**

-   GitHub repository:  `alx-system_engineering-devops`
-   Directory:  `0x0F-load_balancer`
-   File:  `1-install_load_balancer`

Done!  Check your code  Get a sandbox  QA Review

### 2. Add a custom HTTP header with Puppet

#advanced

Score:  100.0%  (Checks completed: 100.0%)

Just as in task #0, we’d like you to automate the task of creating a custom HTTP header response, but with Puppet.

-   The name of the custom HTTP header must be  `X-Served-By`
-   The value of the custom HTTP header must be the hostname of the server Nginx is running on
-   Write  `2-puppet_custom_http_response_header.pp`  so that it configures a brand new Ubuntu machine to the requirements asked in this task

**Repo:**

-   GitHub repository:  `alx-system_engineering-devops`
-   Directory:  `0x0F-load_balancer`
-   File:  `2-puppet_custom_http_response_header.pp`

Done!  Check your code  Get a sandbox  QA Review
