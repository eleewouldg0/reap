FROM node:16-buster

WORKDIR /app
COPY package.json .
RUN npm install --production
COPY . .

EXPOSE 3000
CMD ["node", "index.js"]
