FROM ubuntu
RUN apt-get update
RUN apt-get install apache2 -y
RUN apt-get install apache2-utils -y
RUN apt-get clean
Add . /home/ubuntu
EXPOSE 80
CMD ["apache2ctl", "-D","FOREGROUND"]
