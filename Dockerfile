FROM node:current as web_builder

WORKDIR /build

# Add Web Files
ADD . .

# Build
RUN yarn install && yarn build

FROM docker.io/nginx:1-alpine

COPY --from=web_builder /build/dist /usr/share/nginx/html/dist
COPY --from=web_builder /build/index.min.html /usr/share/nginx/html/index.html
ADD public /usr/share/nginx/html/public
ADD nginx.conf /etc/nginx/nginx.conf
