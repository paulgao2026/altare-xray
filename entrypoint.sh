#!/bin/sh
set -e
PORT=${PORT:-8080}
UUID=${UUID:-}
if [ -z "$UUID" ]; then
  echo "UUID env var is required" >&2
  exit 1
fi
mkdir -p /etc/xray
cat > /etc/xray/config.json <<EOF
{
  "log": {"loglevel": "warning"},
  "inbounds": [
    {
      "port": $PORT,
      "protocol": "vless",
      "settings": {
        "clients": [{"id": "$UUID"}],
        "decryption": "none"
      },
      "streamSettings": {
        "network": "ws",
        "wsSettings": {"path": "/ray"}
      }
    }
  ],
  "outbounds": [{"protocol": "freedom"}]
}
EOF
exec /usr/local/bin/xray run -c /etc/xray/config.json
