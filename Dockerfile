# Use an official Node.js runtime as a parent image
FROM node:18-alpine AS builder


# Set the working directory to /app
WORKDIR /app

# Copy the package.json and package-lock.json files to the container
COPY package*.json ./

# Install the dependencies
RUN npm install --force

# Copy the rest of the application code to the container
COPY . .

# Build the Angular application
RUN npm run build --prod



# Use an official Nginx runtime as a parent image
FROM nginx:alpine

# Copy the built Angular app to the Nginx directory
COPY --from=builder /app/dist/main /usr/share/nginx/html

# Expose port 80 for the Nginx server
EXPOSE 80

# Start the Nginx server
CMD ["nginx", "-g", "daemon off;"]
