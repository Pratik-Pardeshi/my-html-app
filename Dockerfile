# Use an official Nginx image as a base image
FROM nginx:alpine

# Copy static files into the container
COPY index.html /usr/share/nginx/html/
COPY styles.css /usr/share/nginx/html/
COPY app.js /usr/share/nginx/html/

# Expose port 80 for the application
EXPOSE 80
