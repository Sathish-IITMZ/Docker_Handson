# Creating Dockerfiles and Building Custom Images

A comprehensive guide to creating Dockerfiles and building your own Docker images.

## Table of Contents

- [Prerequisites](#prerequisites)
- [Understanding Dockerfiles](#understanding-dockerfiles)
- [Creating Your First Dockerfile](#creating-your-first-dockerfile)
- [Building Your Image](#building-your-image)
- [More Complex Example - Node.js Application](#more-complex-example---nodejs-application)
- [Multi-Stage Builds for Smaller Images](#multi-stage-builds-for-smaller-images)
- [Dockerfile Best Practices](#dockerfile-best-practices)
- [Common Dockerfile Instructions](#common-dockerfile-instructions)
- [Building and Managing Images](#building-and-managing-images)
- [Troubleshooting](#troubleshooting)
- [Complete Example: Python Flask Application](#complete-example-python-flask-application)

## Prerequisites

Before starting, ensure you have:
- Docker installed and running
- Basic understanding of command line operations
- A text editor

## Understanding Dockerfiles

A Dockerfile is a text file containing instructions for building a Docker image. Think of a Docker image as a blueprint for creating containers - the running instances of your application.

Key concepts:
- **Image**: A read-only template containing your application code, libraries, and dependencies
- **Container**: A running instance of an image
- **Dockerfile**: Text file with instructions to build an image
- **Build context**: The directory containing the Dockerfile and other files needed during the build

## Creating Your First Dockerfile

### Step 1: Create a Project Directory

```bash
mkdir docker-demo
cd docker-demo
```

### Step 2: Create a Simple Application

For a basic web page example:

```bash
echo '<html><body><h1>Hello from my custom Docker image!</h1></body></html>' > index.html
```

### Step 3: Create the Dockerfile

Create a file named `Dockerfile` (no extension) in your project directory:

```bash
touch Dockerfile
```

### Step 4: Edit the Dockerfile

Open the Dockerfile in any text editor and add:

```dockerfile
# Use an official base image
FROM nginx:alpine

# Copy files from your host to the container
COPY index.html /usr/share/nginx/html/

# Expose port 80
EXPOSE 80

# Command to run when container starts
CMD ["nginx", "-g", "daemon off;"]
```

Let's break down this Dockerfile:

1. `FROM nginx:alpine`: Specifies the base image to build upon - a lightweight Alpine Linux with Nginx installed
2. `COPY index.html /usr/share/nginx/html/`: Copies your local index.html file into the container's web directory
3. `EXPOSE 80`: Documents that the container will listen on port 80
4. `CMD ["nginx", "-g", "daemon off;"]`: Specifies the command to run when the container starts

## Building Your Image

### Step 5: Build the Docker Image

```bash
docker build -t my-website:1.0 .
```

- `-t my-website:1.0`: Tags your image with name and version
- `.`: Uses the current directory as the build context (looks for Dockerfile here)

You should see output showing each step in the build process.

### Step 6: Verify the Image Was Created

```bash
docker images
```

You should see your `my-website:1.0` image in the list.

### Step 7: Run a Container from Your Image

```bash
docker run -d -p 8080:80 --name my-website-container my-website:1.0
```

- `-d`: Runs the container in detached mode (in the background)
- `-p 8080:80`: Maps port 8080 on your host to port 80 in the container
- `--name my-website-container`: Gives a name to your container

### Step 8: Test Your Container

Open your browser and go to: http://localhost:8080

You should see your "Hello from my custom Docker image!" webpage.

### Step 9: Managing Your Container

Check that your container is running:

```bash
docker ps
```

Stop the container:

```bash
docker stop my-website-container
```

Remove the container:

```bash
docker rm my-website-container
```

## More Complex Example - Node.js Application

### Step 1: Create a New Project

```bash
mkdir node-app
cd node-app
```

### Step 2: Create Application Files

Create package.json:

```bash
echo '{
  "name": "docker-node-app",
  "version": "1.0.0",
  "description": "Node.js on Docker",
  "main": "server.js",
  "scripts": {
    "start": "node server.js"
  },
  "dependencies": {
    "express": "^4.18.2"
  }
}' > package.json
```

Create server.js:

```bash
echo 'const express = require("express");
const app = express();
const PORT = process.env.PORT || 3000;

app.get("/", (req, res) => {
  res.send("Hello from Docker Node.js app!");
});

app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});' > server.js
```

### Step 3: Create Dockerfile for Node.js App

```bash
echo 'FROM node:14-alpine

# Create app directory
WORKDIR /usr/src/app

# Install app dependencies
# Copy package.json and package-lock.json first for better caching
COPY package*.json ./
RUN npm install

# Copy app source code
COPY . .

# Expose port
EXPOSE 3000

# Start command
CMD ["node", "server.js"]' > Dockerfile
```

### Step 4: Build the Node.js Docker Image

```bash
docker build -t my-node-app:1.0 .
```

### Step 5: Run the Node.js Container

```bash
docker run -d -p 3000:3000 --name node-app-container my-node-app:1.0
```

### Step 6: Test the Node.js App

Open your browser and navigate to: http://localhost:3000

You should see "Hello from Docker Node.js app!" displayed.

## Multi-Stage Builds for Smaller Images

Multi-stage builds are a powerful technique to create smaller Docker images by using multiple stages in your Dockerfile.

### Example: Go Application

```dockerfile
# Build stage
FROM golang:1.17-alpine AS builder
WORKDIR /app
COPY . .
RUN go build -o main .

# Final stage
FROM alpine:latest
WORKDIR /root/
COPY --from=builder /app/main .
EXPOSE 8080
CMD ["./main"]
```

This Dockerfile:
1. Uses a larger Go image to compile the application
2. Uses a minimal Alpine image for the final container
3. Copies only the compiled binary from the build stage

The result is a much smaller image without build tools or source code.

## Dockerfile Best Practices

### 1. Use Specific Base Image Tags

```dockerfile
# Good
FROM node:16.14-alpine

# Avoid
FROM node:latest
```

Using specific tags ensures reproducible builds and avoids unexpected changes.

### 2. Group RUN Commands

```dockerfile
# Good
RUN apt-get update && \
    apt-get install -y package1 package2 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Avoid multiple RUN instructions for package installation
# RUN apt-get update
# RUN apt-get install -y package1
# RUN apt-get install -y package2
```

Grouping commands reduces the number of layers and image size.

### 3. Use .dockerignore File

Create a `.dockerignore` file to exclude unnecessary files:

```
node_modules
npm-debug.log
.git
.gitignore
```

This speeds up builds and reduces image size.

### 4. Set Working Directory

```dockerfile
WORKDIR /app
```

Setting a working directory organizes your container filesystem.

### 5. Use Environment Variables

```dockerfile
ENV NODE_ENV=production
```

Environment variables make your Dockerfile more flexible.

### 6. Use Non-Root User for Security

```dockerfile
RUN addgroup -S appgroup && adduser -S appuser -G appgroup
USER appuser
```

Running as a non-root user improves security.

### 7. Order Instructions for Better Caching

Place instructions that change less frequently earlier in the Dockerfile.

```dockerfile
# Copy dependencies file first
COPY package.json .
RUN npm install

# Then copy application code (changes frequently)
COPY . .
```

## Common Dockerfile Instructions

| Instruction | Purpose |
|-------------|---------|
| `FROM` | Specifies the base image |
| `WORKDIR` | Sets the working directory |
| `COPY` | Copies files from host to container |
| `ADD` | Copies files, handles URLs and tar archives |
| `RUN` | Executes commands during build |
| `ENV` | Sets environment variables |
| `ARG` | Defines build-time variables |
| `EXPOSE` | Documents which ports to publish |
| `VOLUME` | Creates a mount point for volumes |
| `CMD` | Default command when container starts |
| `ENTRYPOINT` | Configures container to run as executable |
| `HEALTHCHECK` | Checks if container is still working |
| `LABEL` | Adds metadata to an image |

## Building and Managing Images

### Building with Tags

```bash
docker build -t username/repository:tag .
```

Using your Docker Hub username allows you to push the image to Docker Hub.

### Pushing to Docker Hub

```bash
docker login
docker push username/repository:tag
```

### Viewing Image Layers

```bash
docker history my-image:tag
```

This helps understand how your image is constructed.

### Tagging Existing Images

```bash
docker tag my-image:1.0 my-image:latest
```

Useful for version management.

## Troubleshooting

### View Build Logs

Use `--progress=plain` for detailed build logs:

```bash
docker build --progress=plain -t my-image .
```

### Debugging Containers

Run interactively to debug:

```bash
docker run -it --rm my-image sh
```

### Clean Up Failed Builds

```bash
docker builder prune
```

This removes unused build cache.

## Complete Example: Python Flask Application

### Directory Structure

```
flask-app/
├── app.py
├── requirements.txt
├── templates/
│   └── index.html
└── Dockerfile
```

### Create Files

```bash
mkdir -p flask-app/templates
cd flask-app
```

requirements.txt:

```bash
echo "Flask==2.0.1" > requirements.txt
```

app.py:

```bash
echo 'from flask import Flask, render_template
app = Flask(__name__)

@app.route("/")
def hello():
    return render_template("index.html")

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)' > app.py
```

templates/index.html:

```bash
mkdir -p templates
echo '<!DOCTYPE html>
<html>
<head>
    <title>Docker Flask App</title>
</head>
<body>
    <h1>Hello from Docker Flask App!</h1>
    <p>This is a complete example of a containerized Flask application.</p>
</body>
</html>' > templates/index.html
```

Dockerfile:

```bash
echo 'FROM python:3.9-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 5000

CMD ["python", "app.py"]' > Dockerfile
```

### Build and Run

```bash
docker build -t flask-app:1.0 .
docker run -d -p 5000:5000 --name flask-container flask-app:1.0
```

Access at http://localhost:5000

## Docker Commands Cheatsheet

Here's a quick reference for common Docker commands:

### Images

```bash
# List images
docker images

# Build an image
docker build -t image-name:tag .

# Remove an image
docker rmi image-name:tag

# Pull an image from Docker Hub
docker pull image-name:tag
```

### Containers

```bash
# Run a container
docker run -d -p host-port:container-port --name container-name image-name:tag

# List running containers
docker ps

# List all containers (including stopped)
docker ps -a

# Stop a container
docker stop container-name

# Start a stopped container
docker start container-name

# Remove a container
docker rm container-name

# Execute a command in a running container
docker exec -it container-name command
```

### Clean Up

```bash
# Remove all stopped containers
docker container prune

# Remove all unused images
docker image prune

# Remove all unused volumes
docker volume prune

# Remove everything unused
docker system prune -a
```

---

This guide should help you get started with creating Dockerfiles and building your own Docker images. As you become more comfortable with these concepts, you can explore more advanced features and optimizations to better containerize your applications.
