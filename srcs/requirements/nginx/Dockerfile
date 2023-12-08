# Use VM Alpine version as base image
FROM alpine:3.18.5

# Install NGINX
RUN apk update && \
	apk add --no-cache nginx && \
	apk add --no-cache openssl

# Ensure that we have the correct directory
RUN mkdir -p /etc/nginx/ssl

# Generate SSL cert & key
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/certificate.key \
    -out /etc/nginx/ssl/certificate.crt \
    -subj "/C=FI/ST=Helsinki/L=Helsinki/O=Ecole42/CN=ttikanoj.42.fr" \
	#&& adduser -D -H -s /sbin/nologin -g www-data -G www-data www-data

# Copy the HTML content to NGINX default dir
COPY tools /usr/share/nginx/html

# Copy NGINX configuration to the container
COPY conf/nginx.conf /etc/nginx/nginx.conf

# Expose ports for HTTP and HTTPS
EXPOSE 80 443

# Start NGINX
CMD ["nginx", "-g", "daemon off;"]
