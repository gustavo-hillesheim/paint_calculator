docker_start:
	docker-compose up --build

docker_stop:
	docker-compose down

docker_attach:
	docker attach --sig-proxy=false `docker container ls | grep paint_calculator | cut -d ' ' -f1`