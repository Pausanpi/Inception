all: 
	mkdir -p ~/data
	mkdir -p ~/data/mariadb ~/data/wordpress
	docker compose -f srcs/docker-compose.yml build
	docker compose -f srcs/docker-compose.yml up

clean:
	docker system prune -af

remove:
	docker stop $$(docker ps -qa); docker rm $$(docker ps -qa); docker rmi $$(docker images -qa); docker volume rm $$(docker volume ls -q); docker network rm $$(docker network ls -q) 2>/dev/null
	rm -rf ~/data

re: remove all

.PHONY: all clean remove re