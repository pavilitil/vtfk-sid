#!/usr/bin/env bash
set -euo pipefail

CONTAINER_NAME="vtfk-lab01"
IMAGE_NAME="ubuntu:24.04"

# Видалення попередньої капсули за наявності
docker rm -f "${CONTAINER_NAME}" >/dev/null 2>&1 || true

# Запуск ізольованого контейнера
docker run -d \
  --name "${CONTAINER_NAME}" \
  --hostname capsule-host \
  -e VTFK_NONCE="${VTFK_NONCE:-}" \
  "${IMAGE_NAME}" sleep infinity >/dev/null

# Передавання змінної середовища всередину капсули
docker exec -e VTFK_NONCE="${VTFK_NONCE:-}" "${CONTAINER_NAME}" sh -c 'echo "$VTFK_NONCE" > /tmp/vtfk-nonce'

echo "Капсула успішно розгорнута."
