name: Init OpenWrt HTTP3/QUIC/TLS Package Feed

on:
  workflow_dispatch:
  push:
    paths:
      - '.github/workflows/openwrt-curl-http3.yml'

jobs:
  setup-feed:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout repository
        uses: actions/checkout@v4

      - name: Init package feed structure for OpenWrt curl+HTTP3
        run: |
          bash ./package_feed_init.sh

      - name: Commit & push generated feed
        run: |
          git config user.name "github-actions[bot]"
          git config user.email "github-actions[bot]@users.noreply.github.com"
          git add openwrt-curl-http3-feed
          git commit -m "Auto: Generate OpenWrt curl/HTTP3/quictls/ngtcp2/nghttp3 package feed" || echo "Nothing to commit"
          git push
