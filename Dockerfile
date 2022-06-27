# base images like node ver 12, ubuntu, etc
FROM node:12

# like cd-ing into our directory. docker will start from this folder directly
WORKDIR /app

# every instruction = layer. Docker will cache each layer if nothing changed
# we should install our dependency first so they an be cached
# copy our package.json to our working directory in container
COPY package*.json ./

RUN npm install

# after our dependencies are installed and committed (all 4 layers)
# we copy all our files to the container
# but we don't want to install node_modules, because our container's node modules will be overriden
# include node_modules in .dockerignore file, which works just like a .gitignore file
COPY . .

# set container's environment variable
ENV PORT=8080

# listen on port 8080
EXPOSE 8080

# command instruction - one per dockerfile
# tells container how to run the application
# unlike a regular command that starts a shell session (shell form like npm i),
# we run a special command in the exec form 
CMD ["npm", "start"]

# now build the docker image "docker build -t hackweek/kubernetes-sidecar:1.0 ."
# use -t to name the image
# use . to add a path to current directory
# we can ues this image as a base image or run it as a container

# to use this image, we push it to a container registry (i.e docker hub or a cloud provider)
# but first, login and create a tag for your named container
# docker login
# docker tag hackweek/kubernetes-sidecar:1.0 joshpark/kubernetes-sidcar 
# docker push joshpark/kubernetes-sidcar
# docker pull joshpark/kubernetes-sidcar

# container list
# docker ps

# docker run hackweek/kubernetes-sidecar:1.0
# We exposed port 8080, but it's not accessible to outside world by default
# To view our server/container, port forward to localhost 5000 port 8080
# docker run -p 5000:8080 hackweek/kubernetes-sidecar:1.0
# -d is used to detach container from terminal
# docker run -d -p 8080:8080 node-docker

