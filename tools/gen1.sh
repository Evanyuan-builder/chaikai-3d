#!/bin/bash
# 用法: ./gen1.sh 版本 名字 "提示词"
set -a; . ./.env; set +a
env -u http_proxy -u https_proxy -u all_proxy -u HTTP_PROXY -u HTTPS_PROXY -u ALL_PROXY \
  python3 lux3d/runtime/lux3d_client.py --region cn text --version "$1" --style photorealistic --format glb "$3" "models/$1/$2" > "logs/$1_$2.log" 2>&1
echo "$2 rc=$?"
