# Use a basic nginx image to serve the static content
FROM nginx:alpine

# Copy the static files to the nginx html folder
COPY . /usr/share/nginx/html

# Expose port 80
EXPOSE 80
