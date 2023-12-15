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

define run_if
	@if $(2) | grep -q $(1); then \
		$(3) $(1); fi
endef

ENV_FILE := ./srcs/.env
DATA := $(HOME)/data

up: $(ENV_FILE) $(DATA)
	docker-compose -f ./srcs/docker-compose.yml up --build -d

down:
	docker-compose -f ./srcs/docker-compose.yml down

status:
	@docker ps -a
	@docker images
	@docker volume ls

stop:
	$(call run_if, inception-wordpress, docker ps, docker stop)
	$(call run_if, inception-nginx, docker ps, docker stop)
	$(call run_if, inception-mariadb, docker ps, docker stop)

rm: stop
	$(call run_if, inception-wordpress, docker ps -a, docker rm)
	$(call run_if, inception-nginx, docker ps -a, docker rm)
	$(call run_if, inception-mariadb, docker ps -a, docker rm)

rmi: rm
	$(call run_if, inception-wordpress, docker images, docker rmi)
	$(call run_if, inception-nginx, docker images, docker rmi)
	$(call run_if, inception-mariadb, docker images, docker rmi)

clean:
	@sudo rm -rf $(DATA)
	$(call run_if, inception-database, docker volume ls, docker volume rm -f)
	$(call run_if, inception-files, docker volume ls, docker volume rm -f)

fclean: stop rmi clean

re: fclean up

$(ENV_FILE):
	@echo "Missing .env file"
	@exit 1

$(DATA):
	mkdir -p $(DATA)/inception-database
	mkdir -p $(DATA)/inception-files

.PHONY: up down stop rm rmi clean fclean