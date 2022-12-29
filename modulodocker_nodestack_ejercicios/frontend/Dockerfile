FROM node:lts-alpine
ENV NODE_ENV=production
WORKDIR /usr/src/app
COPY ["package.json", "package-lock.json*", "npm-shrinkwrap.json*", "./"]
RUN npm install --production --silent && mv node_modules ../
COPY . .
RUN chown -R node /usr/src/app
USER node
EXPOSE 8080
EXPOSE 3000
ENV API_URI=http://topics-api:5000/api/topics
CMD ["node", "server.js"]
