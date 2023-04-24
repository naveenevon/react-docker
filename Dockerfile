# Stage 1
# Build docker image of react app
FROM node:16-alpine AS build-stage
WORKDIR /usr/src/app
 
COPY package*.json ./
 
RUN npm install
 
COPY . .
 
EXPOSE 3000
 
CMD [ "npm", "start" ]