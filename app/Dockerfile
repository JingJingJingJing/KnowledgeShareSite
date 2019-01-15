#FROM node:latest

# COPY package*.json /src/app/

# WORKDIR /src/app

# RUN npm install

# COPY . .

# EXPOSE 3000

# CMD ["node","."]

FROM node:11.6.0-alpine

COPY . /src/app/ 

WORKDIR /src/app

EXPOSE 3000

CMD npm install && node .
