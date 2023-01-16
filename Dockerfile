#Use the lastest version of node as the base image
FROM node:19-alpine AS builder

#Set the working directory to the root of the project
WORKDIR /app

#Copy the rest of the project files to the working directory
COPY . .

#Install the dependencies
RUN npm install && npm run build

#Use the lastest version of node as the base image
FROM node:19-alpine AS runner

#Set the working directory to the root of the project
WORKDIR /app

#Copy the rest of the project files to the working directory
COPY . .

#Copy the builder and node_modules files to the working directory
COPY --from=builder /app/node_modules ./node_modules

#Copy the package.json and package-lock.json files to the working directory
COPY --from=builder /app/package.json ./package.json

#Expose the application's port
EXPOSE 5173

#Set the host to the port
ENV HOST=0.0.0.0

#Start the application
CMD ["npm","run","dev"]