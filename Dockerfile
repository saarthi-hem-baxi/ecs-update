# Use the official Node.js 14 (LTS) image as the base image
FROM node:14

# Set the working directory inside the container
WORKDIR /usr/src/app

# Copy package.json and package-lock.json to the container's working directory
COPY package*.json ./

# Install the Node.js dependencies
RUN npm install

# Copy the rest of the application's code to the container's working directory
COPY . .


# Start the application when the container starts
CMD ["node", "app.js"]

