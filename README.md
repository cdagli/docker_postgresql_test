How to use this container? 

1) Build image from Dockerfile 
docker build -t test-database .

2) Run the container 
docker run --name some-test-database -p 5432:5432 test-database

3) Wait until database starts completelty then copy data files 
docker cp data some-test-database:/data

4) Run init script 
docker exec  -t some-test-database sh init_db.sh myapp

Default username / password: docker / docker