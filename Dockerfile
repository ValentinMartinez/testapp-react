FROM node:16 as build-stage

WORKDIR /usr/src/app

COPY . .

# Las variables de entorno que empiezan con REACT_APP deben setearse aquí
# porque al hacer build se convierten en constantes
# Ejemplo:
#ENV REACT_APP_BACKEND_URL = http://localhost:8080

RUN yarn && yarn build

FROM nginx:1.21.6-alpine

COPY nginx/nginx.conf /etc/nginx/nginx.conf
COPY nginx/conf.conf /etc/nginx/conf.d/conf.conf

COPY --from=build-stage /usr/src/app/build/ /usr/share/nginx/html