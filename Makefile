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

define _if
	@if $(2) | grep -q $(1); then \
		$(3) $(1); fi
endef

ENV_FILE := ./srcs/.env
DATA := $(HOME)/data

up: $(ENV_FILE) $(DATA)
	docker compose -f ./srcs/docker-compose.yml up --build -d

down:
	docker compose -f ./srcs/docker-compose.yml down

stop:
	$(call _if, wordpress, docker ps, docker stop)
	$(call _if, nginx, docker ps, docker stop)
	$(call _if, mariadb, docker ps, docker stop)

rm: stop
	$(call _if, wordpress, docker ps -a, docker rm)
	$(call _if, nginx, docker ps -a, docker rm)
	$(call _if, mariadb, docker ps -a, docker rm)

rmi: rm
	$(call _if, wordpress, docker images, docker rmi)
	$(call _if, nginx, docker images, docker rmi)
	$(call _if, mariadb, docker images, docker rmi)

clean:
	@sudo rm -rf $(DATA)
	$(call _if, database, docker volume ls, docker volume rm -f)
	$(call _if, wordpress, docker volume ls, docker volume rm -f)
	$(call _if, inception, docker network ls, docker network rm)

fclean: stop rmi clean

re: fclean up

docker_status:
	@echo "\n\e[4mCONTAINERS:\e[0m"
	@docker ps -a
	@echo "\n\e[4mIMAGES:\e[0m"
	@docker images
	@echo "\n\e[4mVOLUMES:\e[0m"
	@docker volume ls
	@echo "\n\e[4mNETWORKS:\e[0m"
	@docker network ls

docker_clean:
	@docker ps -q | xargs -r docker stop
	@docker ps -qa | xargs -r docker rm
	@docker images -q | xargs -r docker rmi
	@docker volume ls -q | xargs -r docker volume rm
	@docker network ls --format '{{.Name}}' | grep -v '^bridge\|^host\|^none' \
	 | xargs -r docker network rm

$(ENV_FILE):
	@echo "Missing .env file"
	@exit 1

$(DATA):
	mkdir -p $(DATA)/database
	mkdir -p $(DATA)/wordpress

.PHONY: up down stop rm rmi clean fclean docker_status docker_clean