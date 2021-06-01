FROM node:14.16.1

# ENV NODE_ENV production

EXPOSE 6969

WORKDIR /opt/app

COPY package*.json ./

RUN npm install

COPY . .

# RUN npm run build

CMD npm start