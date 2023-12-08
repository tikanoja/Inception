# Use VM Alpine version as base image
FROM alpine:3.18.5

# Install NGINX
RUN apk update && \
	apk add --no-cache nginx && \
	apk add --no-cache openssl

# Copy the HTML content to NGINX default dir
COPY tools /usr/share/nginx/html

# Copy NGINX configuration to the container
COPY conf/nginx.conf /etc/nginx/nginx.conf

# Expose ports for HTTP and HTTPS
EXPOSE 80 443

# Start NGINX
CMD ["nginx", "-g", "daemon off;"]
