# Variables

# All
all:
	if ! grep -q "ttikanoj.42.fr" /etc/hosts; then
		echo "127.0.0.1 ttikanoj.42.fr" >> /etc/hosts
	fi
	if ! grep -q "www.ttikanoj.42.fr" /etc/hosts; then
		echo "127.0.0.1 www.ttikanoj.42.fr" >> /etc/hosts
	fi
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
	sed -i '/ttikanoj\.42\.fr/d' /etc/hosts
	rm -rf /home/ttikanoj/data/mariadb-data
	rm -rf /home/ttikanoj/data/wordpress-data
	docker system prune -f

# Re
re: fclean all
