FROM node:latest



# Create app directory
WORKDIR /usr/src/app

# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
# where available (npm@5+)
COPY package.json ./
RUN npm config set registry http://registry.npmjs.org
RUN echo 104.16.93.83 www.npmjs.com registry.npmjs.org >> /etc/hosts
RUN npm install 
# If you are building your code for production
# RUN npm install --only=production

# Bundle app source
COPY . .

EXPOSE 8080
CMD [ "npm", "start" ]
