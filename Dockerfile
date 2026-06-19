# Use a lightweight nginx image
FROM nginx:alpine

# Copy simple HTML file into nginx directory
COPY index.html /usr/share/nginx/html/index.html

# Expose port 80
EXPOSE 80

# Start nginx
CMD ["nginx", "-g", "daemon off;"]
