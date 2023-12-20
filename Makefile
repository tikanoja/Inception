# Variables

# All
all:
	docker-compose -f srcs/docker-compose.yml build
	docker-compose -f srcs/docker-compose.yml up -d
	
# Clean
clean:
	docker-compose -f srcs/docker-compose.yml down --rmi all -v
	rm -f /etc/nginx/ssl/certificate.crt /etc/nginx/ssl/certificate.key

# Fclean
fclean: clean
	docker system prune -f

# Re
re: fclean all
