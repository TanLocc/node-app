FROM node:latest



# Create app directory
WORKDIR /usr/src/app

# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
# where available (npm@5+)
COPY package.json ./
RUN echo 104.16.24.35 registry.npmjs.org >> /etc/hosts
RUN echo 104.16.25.35 registry.npmjs.org >> /etc/hosts
RUN echo 104.16.26.35 registry.npmjs.org >> /etc/hosts
RUN echo 104.16.27.35 registry.npmjs.org >> /etc/hosts
RUN npm install 
# If you are building your code for production
# RUN npm install --only=production

# Bundle app source
COPY . .

EXPOSE 8080
CMD [ "npm", "start" ]
