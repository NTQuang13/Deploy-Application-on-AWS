#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
APP_DIR="${ROOT_DIR}/Java-Login-App"

if [[ -f "${ROOT_DIR}/.env" ]]; then
  set -a
  # shellcheck disable=SC1091
  source "${ROOT_DIR}/.env"
  set +a
fi

: "${HARBOR_REGISTRY:?Set HARBOR_REGISTRY (example: harbor.example.com)}"
: "${HARBOR_PROJECT:?Set HARBOR_PROJECT (example: java-login-app)}"
: "${HARBOR_USERNAME:?Set HARBOR_USERNAME}"
: "${HARBOR_PASSWORD:?Set HARBOR_PASSWORD}"

IMAGE_NAME="${IMAGE_NAME:-dptweb}"
IMAGE_TAG="${IMAGE_TAG:-1.0}"
IMAGE_REF="${HARBOR_REGISTRY}/${HARBOR_PROJECT}/${IMAGE_NAME}:${IMAGE_TAG}"

echo "${HARBOR_PASSWORD}" | docker login "${HARBOR_REGISTRY}" -u "${HARBOR_USERNAME}" --password-stdin
docker build -t "${IMAGE_REF}" "${APP_DIR}"
docker push "${IMAGE_REF}"
echo "Pushed ${IMAGE_REF}"
