FROM node:20-slim AS builder

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

RUN npm prune --production

#########################################

FROM node:20-slim

WORKDIR /app

COPY --from=builder /app ./

EXPOSE 3000

CMD ["node", "src/main.js"]