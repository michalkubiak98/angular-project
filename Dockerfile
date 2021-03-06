# Stage 1: Compile and Build angular codebase

# Use official node image as the base image
FROM node:16 as builder

# Set the working directory
WORKDIR /app

# Add the source code to app
COPY . .

# Install all the dependencies
RUN npm install

# Generate the build of the application
RUN npm run build


# Stage 2: Serve app with nginx server

# Use official nginx image as the base image
FROM nginx:alpine
WORKDIR /usr/share/nginx/html
# Remove default nginx static assets
RUN rm -rf ./*
# Copy the build output to replace the default nginx contents.
COPY --from=builder /app/dist .

# Expose port 80
EXPOSE 80
