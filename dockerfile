FROM ubuntu
RUN apt-get update
RUN apt-get install -y apache2
RUN apt-get install -y apache2-utils
RUN apt-get clean
Add . /home/ubuntu
EXPOSE 80
CMD ["apache2ctl", "-D","FOREGROUND"]
