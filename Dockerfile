ARG HUGO_VERSION=0.147.2

# ---- hugo: Hugo toolchain, also used for live local development ----
FROM debian:bookworm-slim AS hugo
ARG HUGO_VERSION
RUN apt-get update \
 && apt-get install -y --no-install-recommends ca-certificates curl git \
 && rm -rf /var/lib/apt/lists/* \
 && ARCH="$(dpkg --print-architecture)" \
 && curl -fsSL "https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_extended_${HUGO_VERSION}_linux-${ARCH}.tar.gz" \
    | tar -xz -C /usr/local/bin hugo \
 && hugo version
WORKDIR /site
EXPOSE 1313
CMD ["hugo", "server", "--bind", "0.0.0.0", "--baseURL", "http://localhost:1313/", "--poll", "700ms"]

# ---- build: render the static site into /site/public ----
FROM hugo AS build
ARG BASE_URL=/
COPY . .
RUN hugo --minify --baseURL "${BASE_URL}"

# ---- web: serve the built site with nginx ----
FROM nginx:1.27-alpine AS web
COPY --from=build /site/public /usr/share/nginx/html
EXPOSE 80
