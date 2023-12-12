# Variables

# Build images
build-image:
	sudo docker build -t my-nginx -f ./srcs/requirements/nginx/Dockerfile ./srcs/requirements/nginx

# Run containers
run-container:
	sudo docker run -d -p 80:80 -p 443:443 --name my-nginx-container my-nginx

# Stop containers
stop-container:
	sudo docker stop my-nginx-container

# Remove containers
remove-container:
	sudo docker rm my-nginx-container

# Remove images
remove-image:
	sudo docker rmi my-nginx

# Remove SSL
remove-ssl:
	rm -f /etc/nginx/ssl/certificate.crt /etc/nginx/ssl/certificate.key

# All
all:
	docker-compose up -d -f ./srcs/docker-compose.yml

down:
	docker-compose down -f ./srcs/docker-compose.yml

# Clean
clean:
	docker-compose down --rmi all -v -f ./srcs/docker-compose.yml

# Fclean
fclean: clean

# Re
re: clean all
