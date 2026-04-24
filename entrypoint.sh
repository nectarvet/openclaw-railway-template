#!/bin/bash
set -e

chown -R openclaw:openclaw /data
chmod 700 /data
chmod -R u+rX /data

# Clean up stale gateway lock/pid files left by a previous container instance.
# `gateway stop` marks the service disabled but won't release the lock when the
# referenced PID no longer exists (different container), causing the next
# `gateway run` to time out waiting for the lock.
OPENCLAW_STATE_DIR="${OPENCLAW_STATE_DIR:-/data/.openclaw}"
OPENCLAW_ENTRY="${OPENCLAW_ENTRY:-/usr/local/lib/node_modules/openclaw/dist/entry.js}"
gosu openclaw node "$OPENCLAW_ENTRY" gateway stop 2>/dev/null || true
find "$OPENCLAW_STATE_DIR" -maxdepth 3 \( -name "*.lock" -o -name "*.pid" \) -delete 2>/dev/null || true

if [ ! -d /data/.linuxbrew ]; then
  cp -a /home/linuxbrew/.linuxbrew /data/.linuxbrew
fi

rm -rf /home/linuxbrew/.linuxbrew
ln -sfn /data/.linuxbrew /home/linuxbrew/.linuxbrew

source /data/env.sh
exec gosu openclaw node src/server.js
