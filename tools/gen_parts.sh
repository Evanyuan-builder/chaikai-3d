#!/bin/bash
# 用法: ./gen_parts.sh 版本(G1-Turbo|G1)  —— 并行生成全部零件，结果在 models/<版本>/
V=${1:-G1-Turbo}; mkdir -p models/$V logs
set -a; . ./.env; set +a
gen(){ env -u http_proxy -u https_proxy -u all_proxy -u HTTP_PROXY -u HTTPS_PROXY -u ALL_PROXY \
  python3 lux3d/runtime/lux3d_client.py --region cn text --version $V --style photorealistic --format glb "$2" models/$V/$1 > logs/$V_$1.log 2>&1; echo "$1 done rc=$?"; }
gen 01_zao   "中国传统农村酿酒作坊的砖砌灶台：方形青砖灶，正面有一个拱形的烧柴火口，里面有木柴和火，灶顶是一个圆形开口用来放大铁锅，单独一个物体" &
gen 02_diguo "一口圆形大铁锅，敞口，锅里装着清水，铸铁黑色质感，锅沿较宽，单独一个物体" &
gen 03_bi    "一个圆形的竹编篦子：扁平圆盘，竹篾编成的网格有很多小孔，边缘有一圈竹框，单独一个物体" &
gen 04_zeng  "传统中国白酒蒸馏用的木制甑桶：由竖直木板拼成、外面箍着两道铁箍的大圆木桶，上口略大下口略小像花盆，上下都开口，没有盖子，旧木头质感，单独一个物体" &
gen 05_tianguo "古法酿酒用的天锅：一口浅浅的圆形锡锅，锅底向下凸成尖锥形，锅里盛着冷水，锅沿宽，金属质感，单独一个物体" &
gen 06_jiupan "一个小小的圆形锡制接酒盘，盘边伸出一根细长的斜向下的导流管，金属质感，单独一个物体" &
gen 07_tan   "一个传统陶土酒坛：小口、圆鼓肚、深褐色釉面，坛口敞开，单独一个物体" &
wait
