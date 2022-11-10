FROM node:8.11-alpine

WORKDIR /app

COPY package.json /app
COPY package-lock.json /app

RUN npm install

COPY . /app

RUN npm install

EXPOSE 8085

CMD ["node", "index.js"]
