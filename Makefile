NAME = inception

all: prepare build up

prepare:
	mkdir -p /home/$(USER)/data/wordpress
	mkdir -p /home/$(USER)/data/mariadb

build:
	docker-compose -f srcs/docker-compose.yml build

up:
	docker-compose -f srcs/docker-compose.yml up -d

down:
	docker-compose -f srcs/docker-compose.yml down

clean: down
	docker system prune -a -f

fclean: clean
	rm -rf /home/$(USER)/data/wordpress/*
	rm -rf /home/$(USER)/data/mariadb/*

re: fclean all

.PHONY: all prepare build up down clean fclean re
