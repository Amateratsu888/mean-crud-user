# Use an official Node runtime as a parent image
FROM node:14 AS build

# Set the working directory
WORKDIR /app

# Copy the package.json and package-lock.json files to the working directory
COPY package*.json ./

# Install dependencies
RUN npm ci

# Copy the rest of the application code to the working directory
COPY . .

# Build the Angular app for production
RUN npm run build 

# Use an official Nginx runtime as a parent image
FROM nginx:alpine

# Remove the default nginx website
#RUN rm -rf /usr/share/nginx/html/*


# Copy the Nginx configuration file to the container
#COPY default.conf /etc/nginx/conf.d/default.conf

# Copy the Angular app build files to the container
COPY --from=build /app/dist/angular-app /usr/share/nginx/html

#expose the default nginx website 
EXPOSE 80
