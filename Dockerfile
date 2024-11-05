FROM nginx:latest

COPY index.html /usr/share/nginx/html/index.html
COPY imagenes /usr/share/nginx/html/imagenes
