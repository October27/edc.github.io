############################################################
# Dockerfile to build Wiki-in-box container images
# Based on Ubuntu
############################################################
 
#设置基础镜像

 
# Set the base image to Ubuntu
FROM ubuntu
 
#定义作者

 
# File Author / Maintaner
MAINTAINER  Rodger Yuan

#安装nginx
# Install Nginx
# Add application repository URL to the default sources
RUN echo "deb http://mirrors.163.com/ubuntu/ precise main universe restricted multiverse" >> /etc/apt/sources.list
# Update the repository
RUN apt-get update
# Install necessary tools
RUN apt-get install -y nano wget dialog net-tools
# Download and Install Nginx
RUN apt-get install -y nginx

# Remove the default Nginx configuration file
RUN rm -v /etc/nginx/nginx.conf
RUN rm -v /etc/nginx/mime.types
RUN rm -v /usr/share/nginx/html/index.html
# Copy a configuration file from the current directory
ADD /conf/nginx.conf /etc/nginx/
ADD /conf/mime.types /etc/nginx/
#Copy app file to html
#RUN mkdir /usr/share/nginx/html
ADD /data /usr/share/nginx/html/data 
ADD /imgs /usr/share/nginxhtml/imgs 
ADD /files /usr/share/nginx/html/files 
ADD /index.html /usr/share/nginx/html/index.html
ADD /latex.html /usr/share/nginx/html/latex.html
# Append "daemon off;" to the beginning of the configuration
RUN echo "daemon off;" >> /etc/nginx/nginx.conf
RUN echo 'root:toor' | chpasswd
# Expose ports
EXPOSE 80
# Set the default command to execute
# when creating a new container
CMD service nginx start