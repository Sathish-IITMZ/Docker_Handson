# Creating Dockerfiles and Building Images on Windows

A step-by-step guide to creating Dockerfiles and building your own Docker images using Windows Command Prompt.

## Prerequisites

- Windows 10/11
- Docker Desktop installed and running
- WSL 2 backend configured

## Verifying Your Docker Setup

Before starting, verify that Docker is properly installed and running:

```cmd
docker --version
docker run hello-world
```

## Creating Your First Dockerfile and Image

### Step 1: Create a Project Directory

```cmd
mkdir my-first-docker-image
cd my-first-docker-image
```

### Step 2: Create a Simple HTML File

```cmd
echo ^<!DOCTYPE html^>^<html^>^<head^>^<title^>My Docker Website^</title^>^</head^>^<body^>^<h1^>Hello from Docker!^</h1^>^<p^>This is a simple website running in a container.^</p^>^</body^>^</html^> > index.html
```

Alternatively, you can create this file in a text editor like Notepad and save it as `index.html` in your project directory.

### Step 3: Create a Dockerfile

```cmd
echo FROM nginx:alpine > Dockerfile
echo COPY index.html /usr/share/nginx/html/ >> Dockerfile
echo EXPOSE 80 >> Dockerfile
```

Or create a file named `Dockerfile` (no extension) in your text editor with the following content:

```dockerfile
FROM nginx:alpine
COPY index.html /usr/share/nginx/html/
EXPOSE 80
```

### Step 4: Build Your Docker Image

```cmd
docker build -t my-website .
```

This command builds an image tagged as `my-website` using the Dockerfile in the current directory (`.`).

### Step 5: Verify Your Image

```cmd
docker images
```

You should see your `my-website` image in the list.

### Step 6: Run Your Docker Image

```cmd
docker run -d -p 8080:80 --name my-website-container my-website
```

This runs your image as a container, mapping port 8080 on your machine to port 80 in the container.

### Step 7: Test Your Website

Open a web browser and navigate to:
```
http://localhost:8080
```

You should see your "Hello from Docker!" webpage.

### Step 8: Stop and Remove the Container

```cmd
docker stop my-website-container
docker rm my-website-container
```

## Creating a More Complex Application

### Step 1: Create a New Project Directory

```cmd
mkdir node-docker-app
cd node-docker-app
```

### Step 2: Create a Simple Node.js Application

Create a file named `app.js`:

```cmd
echo const express = require('express'); > app.js
echo const app = express(); >> app.js
echo const PORT = process.env.PORT || 3000; >> app.js
echo. >> app.js
echo app.get('/', (req, res) =^> { >> app.js
echo   res.send('Hello from Node.js in Docker!'); >> app.js
echo }); >> app.js
echo. >> app.js
echo app.listen(PORT, () =^> { >> app.js
echo   console.log(`Server running on port ${PORT}`); >> app.js
echo }); >> app.js
```

### Step 3: Create a Package.json File

```cmd
echo { > package.json
echo   "name": "node-docker-app", >> package.json
echo   "version": "1.0.0", >> package.json
echo   "description": "A simple Node.js Docker app", >> package.json
echo   "main": "app.js", >> package.json
echo   "scripts": { >> package.json
echo     "start": "node app.js" >> package.json
echo   }, >> package.json
echo   "dependencies": { >> package.json
echo     "express": "^4.17.1" >> package.json
echo   } >> package.json
echo } >> package.json
```

### Step 4: Create a Dockerfile

```cmd
echo FROM node:14-alpine > Dockerfile
echo WORKDIR /app >> Dockerfile
echo COPY package*.json ./ >> Dockerfile
echo RUN npm install >> Dockerfile
echo COPY app.js ./ >> Dockerfile
echo EXPOSE 3000 >> Dockerfile
echo CMD ["npm", "start"] >> Dockerfile
```

### Step 5: Build Your Node.js Application Image

```cmd
docker build -t node-app .
```

### Step 6: Run Your Application

```cmd
docker run -d -p 3000:3000 --name my-node-app node-app
```

### Step 7: Test Your Application

Open a web browser and navigate to:
```
http://localhost:3000
```

You should see "Hello from Node.js in Docker!".

## Understanding Dockerfile Instructions

Here's an explanation of common Dockerfile instructions:

- `FROM`: Specifies the base image
- `WORKDIR`: Sets the working directory inside the container
- `COPY`: Copies files from host to container
- `ADD`: Similar to COPY but can handle remote URLs and auto-extract archives
- `RUN`: Executes commands during build
- `ENV`: Sets environment variables
- `EXPOSE`: Documents which ports the container listens on
- `CMD`: Specifies the command to run when the container starts
- `ENTRYPOINT`: Similar to CMD but harder to override

## Multi-Stage Builds for Smaller Images

Multi-stage builds allow you to use multiple FROM statements in your Dockerfile, each starting a new build stage. This is useful for creating smaller production images.

### Example: Multi-Stage Build for a Go Application

```cmd
mkdir go-multi-stage
cd go-multi-stage
```

Create a simple Go application (`main.go`):

```cmd
echo package main > main.go
echo. >> main.go
echo import ( >> main.go
echo     "fmt" >> main.go
echo     "net/http" >> main.go
echo ) >> main.go
echo. >> main.go
echo func main() { >> main.go
echo     http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) { >> main.go
echo         fmt.Fprintf(w, "Hello from Go in Docker!") >> main.go
echo     }) >> main.go
echo. >> main.go
echo     http.ListenAndServe(":8080", nil) >> main.go
echo } >> main.go
```

Create a multi-stage Dockerfile:

```cmd
echo # Build stage > Dockerfile
echo FROM golang:1.17-alpine AS build >> Dockerfile
echo WORKDIR /app >> Dockerfile
echo COPY main.go . >> Dockerfile
echo RUN go build -o main . >> Dockerfile
echo. >> Dockerfile
echo # Final stage >> Dockerfile
echo FROM alpine:latest >> Dockerfile
echo WORKDIR /app >> Dockerfile
echo COPY --from=build /app/main . >> Dockerfile
echo EXPOSE 8080 >> Dockerfile
echo CMD ["./main"] >> Dockerfile
```

Build and run:

```cmd
docker build -t go-app .
docker run -d -p 8080:8080 --name my-go-app go-app
```

Test at http://localhost:8080

## Tagging and Pushing Images to Docker Hub

### Step 1: Log in to Docker Hub

```cmd
docker login
```

Enter your Docker Hub username and password when prompted.

### Step 2: Tag Your Image

```cmd
docker tag my-website username/my-website:1.0
```

Replace `username` with your Docker Hub username.

### Step 3: Push to Docker Hub

```cmd
docker push username/my-website:1.0
```

## Docker Build Arguments and Environment Variables

### Using Build Arguments

Build arguments allow you to pass variables during the build process.

Create a Dockerfile:

```cmd
echo FROM nginx:alpine > Dockerfile
echo ARG BACKGROUND_COLOR=blue >> Dockerfile
echo WORKDIR /usr/share/nginx/html >> Dockerfile
echo RUN echo "<!DOCTYPE html><html><head><style>body { background-color: ${BACKGROUND_COLOR}; color: white; }</style></head><body><h1>Hello Docker</h1></body></html>" > index.html >> Dockerfile
echo EXPOSE 80 >> Dockerfile
```

Build with a custom argument:

```cmd
docker build --build-arg BACKGROUND_COLOR=red -t colored-site .
```

### Using Environment Variables

Environment variables can be defined in the Dockerfile and overridden when running.

Create a Dockerfile:

```cmd
echo FROM node:14-alpine > Dockerfile
echo WORKDIR /app >> Dockerfile
echo COPY package*.json ./ >> Dockerfile
echo RUN npm install >> Dockerfile
echo COPY app.js ./ >> Dockerfile
echo ENV PORT=3000 >> Dockerfile
echo ENV NODE_ENV=production >> Dockerfile
echo EXPOSE 3000 >> Dockerfile
echo CMD ["npm", "start"] >> Dockerfile
```

Run with a custom environment variable:

```cmd
docker run -d -p 8000:5000 -e PORT=5000 -e NODE_ENV=development --name env-node-app node-app
```

## Best Practices for Dockerfile

1. **Use Specific Base Image Tags**: Use specific versions (e.g., `node:14-alpine` instead of `node:latest`) for reproducible builds

2. **Minimize Layers**: Combine related commands into single RUN statements using && to reduce image size

3. **Clean Up After Installation**: Remove temporary files and caches in the same RUN command

4. **Use .dockerignore**: Create a `.dockerignore` file to exclude unnecessary files:
   ```cmd
   echo node_modules > .dockerignore
   echo npm-debug.log >> .dockerignore
   echo Dockerfile >> .dockerignore
   echo .git >> .dockerignore
   echo .gitignore >> .dockerignore
   ```

5. **Use Multi-Stage Builds**: To keep final images small and secure

6. **Run as Non-Root User**: Add a user and switch to it with the USER instruction

7. **Add Health Checks**: Use the HEALTHCHECK instruction to verify container health

## Troubleshooting Common Docker Build Issues on Windows

### Issue: "context canceled" Error

If you see "context canceled" during build, check if Docker Desktop is running properly or restart it.

### Issue: Permission Denied Errors

Make sure you're running Command Prompt as an administrator for operations that require elevated privileges.

### Issue: Path Issues with Volumes

Use the correct path format when mounting volumes:

```cmd
docker run -v %cd%:/app my-image
```

### Issue: CRLF vs LF Line Endings

Windows uses CRLF line endings which can cause issues with shell scripts. In your Dockerfile, convert line endings:

```dockerfile
COPY script.sh /app/
RUN dos2unix /app/script.sh && chmod +x /app/script.sh
```

## End

