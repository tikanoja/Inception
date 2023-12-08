# Define Alpine version
FROM alpine:3.18.5

# Install NGINX
RUN apk update && apk add nginx && apk add openssl

# Copy the HTML content to NGINX default dir
COPY tools /usr/share/nginx/html

# Copy NGINX configuration to enable HTTPS
COPY conf/nginx.conf /etc/nginx/nginx.conf

# Expose ports for HTTP and HTTPS
EXPOSE 80 443

# Start NGINX
CMD ["nginx", "-g", "daemon off;"]
