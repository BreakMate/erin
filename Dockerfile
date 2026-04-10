FROM --platform=$BUILDPLATFORM caddy:2.9.1-builder AS builder
ARG TARGETARCH
RUN GOARCH=$TARGETARCH xcaddy build \
    --with github.com/caddyserver/replace-response

# Build the React app
FROM node:20-alpine AS frontend
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# Set up Caddy and the frontend built beforehand
FROM caddy:2.9.1-alpine
COPY --from=builder /usr/bin/caddy /usr/bin/caddy
COPY docker/Caddyfile /etc/caddy/Caddyfile
COPY --from=frontend /app/build /srv
ENV AUTH_ENABLED="true"
ENV AUTH_SECRET="\$2a\$14\$qRW8no8UDmSwIWM6KHwdRe1j/LMrxoP4NSM756RVodqeUq5HzG6t."
ENV PUBLIC_URL="https://localhost"
ENV APP_TITLE="Erin - TikTok feed for your own clips"
ENV AUTOPLAY_ENABLED="false"
ENV PROGRESS_BAR_POSITION="bottom"
ENV IGNORE_HIDDEN_PATHS="false"
ENV SCROLL_DIRECTION="vertical"
ENV USE_CUSTOM_SKIN="false"
ENV VIDEO_START_POSITION="start"
