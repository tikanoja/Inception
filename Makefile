# Variables

# All
all:
	docker-compose -f srcs/docker-compose.yml build --no-cache
	docker-compose -f srcs/docker-compose.yml up -d
	
# Build images
build-image:
	docker build -t my-nginx -f ./srcs/requirements/nginx/Dockerfile ./srcs/requirements/nginx

# Run containers
run-container:
	docker run -d -p 80:80 -p 443:443 --name my-nginx-container my-nginx

# Stop containers
stop-container:
	docker stop my-nginx-container

# Remove containers
remove-container:
	docker rm my-nginx-container

# Remove images
remove-image:
	docker rmi my-nginx

# Remove SSL
remove-ssl:
	rm -f /etc/nginx/ssl/certificate.crt /etc/nginx/ssl/certificate.key


down:
	cd srcs && docker-compose down

# Clean
clean:
	docker-compose -f srcs/docker-compose.yml down --rmi all -v
	rm -f /etc/nginx/ssl/certificate.crt /etc/nginx/ssl/certificate.key

# Fclean
fclean: clean

# Re
re: clean all
