# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: arabenst <arabenst@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2023/12/07 15:50:23 by arabenst          #+#    #+#              #
#    Updated: 2023/12/07 15:50:23 by arabenst         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

ENV_FILE := ./srcs/.env
DATA := $(HOME)/data

up: $(ENV_FILE) $(DATA)
	docker-compose -f ./srcs/docker-compose.yml up --build -d

down:
	docker-compose -f ./srcs/docker-compose.yml down

stop:
	@if docker ps | grep -q inception-wordpress; then \
		docker stop inception-wordpress; fi
	@if docker ps | grep -q inception-nginx; then \
		docker stop inception-nginx; fi
	@if docker ps | grep -q inception-mariadb; then \
		docker stop inception-mariadb; fi

rm: stop
	@if docker ps -a | grep -q inception-wordpress; then \
		docker rm inception-wordpress; fi
	@if docker ps -a | grep -q inception-nginx; then \
		docker rm inception-nginx; fi
	@if docker ps -a | grep -q inception-mariadb; then \
		docker rm inception-mariadb; fi

rmi: rm
	@if docker images | grep -q inception-wordpress; then \
		docker rmi inception-wordpress; fi
	@if docker images | grep -q inception-nginx; then \
		docker rmi inception-nginx; fi
	@if docker images | grep -q inception-mariadb; then \
		docker rmi inception-mariadb; fi

clean:
	@rm -rf $(DATA)
	@if docker volume ls | grep -q srcs_inception-database; then \
		sudo docker volume rm -f srcs_inception-database; fi
	@if docker volume ls | grep -q srcs_inception-files; then \
		sudo docker volume rm -f srcs_inception-files; fi

fclean: rmi clean

$(ENV_FILE):
	@echo "Missing .env file"
	@exit 1

$(DATA):
	mkdir -p $(DATA)/inception-database
	mkdir -p $(DATA)/inception-files

.PHONY: up down stop rm rmi clean fclean