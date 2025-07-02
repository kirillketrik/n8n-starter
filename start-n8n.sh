#!/bin/sh

echo "⌛ Waiting for ngrok started..."

until curl -s --fail http://ngrok:4040/api/tunnels > /dev/null; do
  sleep 2
done


NGROK_URL=$(curl -s http://ngrok:4040/api/tunnels | jq -r '.tunnels[0].public_url')

echo "🌐 Given ngrok URL: $NGROK_URL"

export WEBHOOK_URL="$NGROK_URL"
export WEBHOOK_TUNNEL_URL="$NGROK_URL"

exec n8n
