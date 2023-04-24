# Stage 1
# Build docker image of react app
FROM node:16-alpine AS build-stage

WORKDIR /usr/src/app
 
COPY package*.json ./
 
RUN npm install --only=development
 
COPY . .
 
RUN npm run build

FROM nginx:alpine AS production

ARG NODE_ENV=production
ENV NODE_ENV=${NODE_ENV}

# Set working directory to nginx asset directory
WORKDIR /usr/share/nginx/html

# Remove default nginx static assets
RUN rm -rf ./*

# Copy static assets from builder stage
COPY --from=build-stage /usr/src/app/build .

# Containers run nginx with global directives and daemon off
ENTRYPOINT ["nginx", "-g", "daemon off;"]