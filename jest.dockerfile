FROM node:14

# Install Jest
RUN npm install --save-dev jest

# Copy package.json to the image
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy test files to the image
COPY __tests__ ./

# Run Jest tests
CMD ["npm run test"]