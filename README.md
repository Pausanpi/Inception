# Inception
This project form 42 school aims to broaden your knowledge of system administration by using Docker. In this tutorial you will virtualize several Docker images, creating them in your new personal virtual machine. 

## Importante things to read before beginning the project
1. **Don´t try to do all the containers** (Nginx, wordpress and mariaDB) at the same time. You will be lost and you will not understand properly how it works. Do it step by step.
2. **Begin with Nginx** by displaying an index.html page
   - Learn first how to launch a docker image && to execute this image **without using docker-compose**
   - Learn how display an html page on http://localhost:80
   - Learn how to display an html page with SSL on http://localhost:443
3. **Do wordpress**
   - You can begin from here the docker-compose file, you don´t need it before
4. **Finish with MariDB**


# Definitions
## What is a docker?
Docker is an open platform for developing, shipping, and running applications. Docker enables you to separate your applications from your infrastructure so you can deliver software quickly. With Docker, you can manage your infraestructure in the same ways you manage your applicatons. By taking advantage of Docker's methodologies for shipping, testing, and deploying code quickly, you can significantly reduce the delay between writing code and running it in production. Docker provides the ability to package and run an application in a loosely isolated environment called a container.

## What is a docker-file?
Docker can build images automatically by reading the instructions from a Dockerfile. A Dockerfile is a text document that contains all the commands a user could call on the command line to assemble an image. Using docker build users can create an automated build that executes several command-line instructions in succesion.

# Docker
## Important commands to use docker
### General docker commands
```c
- docker ps or docker ps -a // show the names of the containers you have + the id you need and the port associated.
- docker pull "NameOfTheImage" // pull an image from dockerhub
- docker "Three first letter of your docker" // show the logs of your last run of dockers
- docker rm $(docker ps -a -q) // allow to delete all the opened images
- docker exec -it "Three first letter of your docker" sh // to execute the program with the shell
```

### Docker run
```c
- docker run "name of the docker image" // to run the docker image
- docker run -d, // run container in background
- docker run -p, // publish a container's port to the host
- docker run -P, // publish all exposed port to random ports
- docker run -it "imageName", // the program will continue to run and you will be able to interact with the container
- docker run -name sl mysql, // give a name for the container instead an ID
- docker run -d -p 7000:80 test:latest
```

### Docker image
```c
- docker image rm -f "image name/id" // delete the image, if the image is running you need to kill it first
- docker image kill "name", // stop a running image
```

## How to write a docker file
* Create a filename dockerfile
* Write tyour command inside the doc
* Build the dockerfile with the command "docker build -t "nameYouChoose"
* Execute the dockerfile with the command: docker run "nameYouChoose"

  Here are the most common types of instructions:
  * FROM - defines a base for your image. exempple: FROM debian
  * RUN - executes any commands in a new layer on top of the current image and commits the result. RUN also has a shell from for running commands.
  * WORKDIR - sets the working directory for any RUN, CMD, ENTRYPOINT, COPY, and ADD instructions that follow it in the Dockerfile.
  * COPY - copies new files or directories from and adds them to the filesystem of the container at the path
  * CMD - lets you define the default program that is run once you start the container based on this image. Each Dockerfile only has one CMD, and only the last CMD instance is respected when multiple ones exist.
 
# Nginx
## How to set up Nginx (our web server)
- [Video tutorial](<http://nginx.org/en/docs/beginners_guide.html>)
Nginx is a webserver which stores html, js, images files and use http request to display a website. Nginx conf documents will be used to config out server and the right proxy connexion.

## Configure .conf file on nginx
### Listen && Locate
* Listen will indicate to the server which request it has to accept: Listen can take ports and address: exemple Listen 80;
* The locate directive within NGINX server block allows to route request to correct location within the file system. The directive is used to tell NGINX where to look for a resource by including files and folders while matching a locate block against an URL.

## Steps to add in localhost by configuring
### (this point works only on the mac and not the VM)
1. I added to my /var/www/ directory an index html file
2. I configured the default file in etc/nginx/site-enable-default
3. I added a server bracket with a location to var/www in the doc. Save it and reload nginx with 'nginx 's reload'
4. Because the port host I put when I built was 7000. Go to a web page and put: http://localhost:7000/. it works!!!
