# syntax=docker/dockerfile:1
FROM node:20-alpine AS builder

LABEL maintainer="EdoNezu Developer"
LABEL version="1.0.0"

WORKDIR /app

ENV NODE_ENV=production \
    PORT=3000

# 依存関係のインストール
COPY package*.json ./
RUN npm ci --only=production && \
    npm cache clean --force

COPY . .

EXPOSE ${PORT}

HEALTHCHECK --interval=30s --timeout=3s \
  CMD curl -f http://localhost:3000/health || exit 1

ENTRYPOINT ["node"]
CMD ["dist/index.js"]
