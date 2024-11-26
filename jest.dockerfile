FROM node:14

# Install Jest
RUN npm install --save-dev jest jest-environment-jsdom

# Copy package.json to the image
COPY package*.json ./

# Install dependencies
RUN npm install

