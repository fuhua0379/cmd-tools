#!/bin/bash

# 检查是否提供了目标目录参数
if [ -z "$1" ]; then
    echo "用法: $0 <目标目录>"
    exit 1
fi

# 目标目录
TARGET_DIR="$1"

# 确保目标目录存在
if [ ! -d "$TARGET_DIR" ]; then
    echo "错误: 目录 '$TARGET_DIR' 不存在！"
    exit 1
fi

# 查找 `._` 文件和 `.DS_Store` 文件
FILES=$(find "$TARGET_DIR" -type f \( -name "._*" -o -name ".DS_Store" -o -name "Thumbs.db" \))

# 判断是否找到匹配的文件
if [ -z "$FILES" ]; then
    echo "没有找到匹配的文件"
else
    echo "以下是 '$TARGET_DIR' 中的无用文件："
    echo "$FILES" | tr ' ' '\n'  # 每行显示一个文件
fi
