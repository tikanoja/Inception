# Use VM Alpine version as base image
FROM alpine:3.18.5

# Install NGINX
RUN apk update && \
	apk add --no-cache nginx && \
	apk add --no-cache openssl

# Ensure that we have the dir to store PID (sudo??)
RUN mkdir -p /run/nginx/

# Ensure that we have the correct directory (sudo??)
# Give rights with -m 775 maybe ?
RUN mkdir -p /etc/nginx/ssl/

RUN sudo nginx

# Generate SSL cert & key
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -out /etc/nginx/ssl/certificate.crt \
    -keyout /etc/nginx/ssl/certificate.key \
    -subj "/C=FI/ST=Helsinki/L=Helsinki/O=Ecole 42/OU=Hive Helsinki/CN=ttikanoj.42.fr"

# Add a new user within the container
#RUN adduser -D -H -s /sbin/nologin -g www-data -G www-data www-data

# Copy the HTML content to NGINX default dir for test purposes...
COPY tools /usr/share/nginx/html

# Copy NGINX configuration to the container
COPY conf/nginx.conf /etc/nginx/nginx.conf

# Expose ports for HTTP and HTTPS
EXPOSE 80 443

# Start NGINX
CMD ["nginx", "-g", "daemon off;"]
