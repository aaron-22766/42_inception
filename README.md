<h1 align="center">
	<p>
	inception
	</p>
	<img src="https://github.com/ayogun/42-project-badges/blob/main/badges/inceptione.png">
</h1>

<p align="center">
	<b><i>One container is not enough, we need to go deeper</i></b><br><br>
</p>

<p align="center">
	<img alt="GitHub code size in bytes" src="https://img.shields.io/github/languages/code-size/aaron-22766/42_inception?color=lightblue" />
	<img alt="Code language count" src="https://img.shields.io/github/languages/count/aaron-22766/42_inception?color=yellow" />
	<img alt="GitHub top language" src="https://img.shields.io/github/languages/top/aaron-22766/42_inception?color=blue" />
	<img alt="GitHub last commit" src="https://img.shields.io/github/last-commit/aaron-22766/42_inception?color=green" />
</p>

---

## 🗣 About

This project aims to broaden your knowledge of system administration by using Docker. You will virtualize several Docker images, creating them in your new personal virtual machine.

## 🛠 Usage

#### Run

* Have **Docker Desktop** installed and running
* Add the line `127.0.0.1 arabenst.42.fr` to `/etc/hosts` to redirect the required domain name to localhost
* be inside the root folder of the repo and run `make up` to start
* visit `arabenst.42.fr` in your browser
* run `make down` to stop

#### Upload wordpress backup

Because newer versions of the plugin get stuck on upload...

* visit `arabenst.42.fr/wp-admin` enter the admin login as in `srcs/.env`
* install the **All-in-One Migration Version 6.7** Wordpress plugin following [this guide](https://www.namehero.com/blog/how-to-fix-a-stuck-all-in-one-wp-migration-import/#1-2-installing-the-older-plugin-version-67)
* navigate to the plugin, select *Import* and upload the desired backup (`inception.wpress` is the website I made for the evaluation)
* visit the main page again and the changes should be applied

## 💬 Description

* Three **Docker Containers** run the individual services:
  * **nginx** (webserver)
  * **MariaDB** (database)
  * **WordPress** (content management system) and **php-fpm** (web tool for quicker website)
* Two **Docker Volumes** mount local directories for persisting files:
  * WordPress database
  * WordPress website files
* A **Docker Network** establishes the connection between your containers
<br>
* Each container is launched from a **Docker Image** which is built from a  **Dockerfile**:
  * pulls a base image (I decided to only use **Alpine**, as it's more light-weight and therefore installs quicker than **Debian**)
  * installs and configures programs as required
  * launches a startup-script that makes some last minute setup and runs the service
* A **docker-compose.yml** file manages everything:
  * builds images from Dockerfiles (importing the .env file as the environment)
  * launches containers from images
  * hooks the containers up with volumes
  * configures the network for the containers to communicate with each other