#!/usr/bin/env bash
set -euo pipefail

OUT_DIR=${1:-./state-export}
mkdir -p "$OUT_DIR"
cp /root/.hermes/state.db "$OUT_DIR/state.db"
cp /root/.hermes/processes.json "$OUT_DIR/processes.json" 2>/dev/null || true
cp /root/.hermes/channel_directory.json "$OUT_DIR/channel_directory.json" 2>/dev/null || true
cp /root/.hermes/gateway_state.json "$OUT_DIR/gateway_state.json" 2>/dev/null || true
cp -r /root/.hermes/pairing "$OUT_DIR/pairing" 2>/dev/null || true

echo "Exported live Hermes state into $OUT_DIR"
echo "Encrypt before storing or pushing."
