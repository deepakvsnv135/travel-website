# Use official nginx base image
FROM nginx:alpine

# Remove default nginx index page
RUN rm -rf /usr/share/nginx/html/*

# Copy your static website files to Nginx's web root
COPY . /usr/share/nginx/html

# Expose port 80 to access the website
EXPOSE 8080

# Start Nginx when the container starts
CMD ["nginx", "-g", "daemon off;"]
