# Variables

# All
all:
	mkdir -p /home/ttikanoj/data/mariadb-data
	mkdir -p /home/ttikanoj/data/wordpress-data
	docker-compose -f srcs/docker-compose.yml build
	docker-compose -f srcs/docker-compose.yml up -d
	
# Clean
clean:
	docker-compose -f srcs/docker-compose.yml down --rmi all -v
	rm -f /etc/nginx/ssl/certificate.crt /etc/nginx/ssl/certificate.key

# Fclean
fclean: clean
	rm -rf /home/ttikanoj/data/mariadb-data
	rm -rf /home/ttikanoj/data/wordpress-data
	docker system prune -f

# Re
re: fclean all
