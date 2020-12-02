FROM node:14.15-alpine as base
RUN mkdir /app
WORKDIR /app
COPY package.json ./
COPY yarn.lock ./
RUN yarn

# dev
FROM base as dev
ENV NODE_ENV=development
CMD ["yarn" , "dev"]

# pre-prod
FROM base as pre-prod
COPY . .
RUN yarn build

#prod
FROM node:14.15-alpine as prod
ENV NODE_ENV=production
RUN mkdir /app
WORKDIR /app
COPY package.json ./
COPY yarn.lock ./
RUN yarn install --production
COPY --from=pre-prod /app/dist ./dist
USER node
EXPOSE 4000
CMD ["node", "dist/index.js"]