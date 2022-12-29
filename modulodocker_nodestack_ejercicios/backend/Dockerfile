FROM node:lts-alpine
WORKDIR /usr
COPY package.json ./
COPY tsconfig.json ./
COPY src ./src
RUN ls -a
RUN npm install
RUN npm run build
## this is stage two , where the app actually runs
FROM node:lts-alpine
WORKDIR /usr
COPY package.json ./
RUN npm install --only=production
COPY --from=0 /usr/dist .
RUN npm install pm2 -g
EXPOSE 5000
ENV DATABASE_URL=mongodb://some-mongo:27017
ENV DATABASE_NAME=TopicstoreDb
ENV PORT=5000
ENV HOST=topics-api
CMD ["pm2-runtime","app.js"]
