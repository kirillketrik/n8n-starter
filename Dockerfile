FROM n8nio/n8n:latest

USER root
RUN apk add --no-cache curl jq
USER node
