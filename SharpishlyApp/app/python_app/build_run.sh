docker build -t flask-nginx-app .
docker run -d -p 2000:80 flask-nginx-app
