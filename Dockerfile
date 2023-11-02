# Build stage
FROM node:20.9.0 AS build
# define working directory
WORKDIR /app
# copy dependency file
COPY ./package.json /app
# install dependencies before copying, for optimized performance
RUN npm install
# copy all necessary files for Angular to run
COPY ./src /app/src
COPY ./tsconfig.app.json /app/tsconfig.app.json
COPY ./tsconfig.spec.json /app/tsconfig.spec.json
COPY ./tsconfig.json /app/tsconfig.json 
COPY ./angular.json /app/angular.json
# build the project
RUN npm run build

# Test stage
FROM build AS test
# Update package manager repositories and install Chromium
RUN apt-get update && apt-get install -y chromium
# add karma conf file
COPY ./karma.conf.js /app/karma.conf.js
# Set CHROME_BIN environment variable
ENV CHROME_BIN=/usr/bin/chromium
# run tests
RUN npm test


# Deployment stage
#FROM nginx:latest AS deploy
#COPY --from=build /app/dist /usr/share/nginx/html
#EXPOSE 80
#CMD ["nginx", "-g", "daemon off;"]
