#!/bin/zsh
# 维护者用：正本在作者本机的 skillshare 源，改完跑这个，把 skill 同步进仓库、提交、推送。
# 用法：./sync.sh "改了什么"
set -e
R="${0:A:h}"
SRC="${YUYAN_SRC:-$HOME/.config/skillshare/skills/aigc/yuyan-sheji}"
rsync -a --delete --exclude .DS_Store --exclude __pycache__ "$SRC/" "$R/yuyan-sheji/"
cd "$R"
git add -A
git diff --cached --quiet && { echo "没有改动"; exit 0; }
git commit -q -m "${1:-同步 skill}"
git push -q
echo "已推送：$(git log -1 --format='%h %s')"
