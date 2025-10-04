# Use Node.js 18 as base image
FROM node:18-alpine

# Set working directory
WORKDIR /app

# Copy package files
COPY app/package*.json ./

# Install dependencies
RUN npm install

# Copy source code
COPY app/ .

# Expose port (not needed for Lambda, but for testing)
EXPOSE 3000

# Default command
CMD ["node", "index.js"]
