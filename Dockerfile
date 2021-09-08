FROM    node:14.2.0-alpine3.11 as builder

WORKDIR /app

COPY    package*.json ./
RUN     npm install

COPY    . .
RUN     npm run build
RUN     mkdir /pkg
RUN     mv dist node_modules package.json /pkg/

FROM    node:14.2.0-alpine3.11

WORKDIR /app

RUN npm install -g http-server

COPY    --from=builder /pkg /app

CMD ["http-server", "dist"]
