# https://registry.hub.docker.com/u/phusion/baseimage/
FROM lucee/lucee5-nginx:5.0.0.228
MAINTAINER Chris Peters <chris.peters@liquifusion.com>

# Lucee/Tomcat
# This needs to be overridden because it adds a servlet-mapping needed for CFWheels URL rewriting.
# <url-pattern>/rewrite.cfm/*</url-pattern>
COPY ./lucee/web.xml /usr/local/tomcat/conf/web.xml

# NGINX
COPY ./nginx/nginx.conf /etc/nginx/nginx.conf
COPY ./nginx/default /etc/nginx/sites-enabled/default
COPY ./nginx/proxy-params /etc/nginx/proxy-params
COPY ./nginx/cfwheels-rewrite-rules /etc/nginx/cfwheels-rewrite-rules

# App codebase
ADD ./app /var/www
