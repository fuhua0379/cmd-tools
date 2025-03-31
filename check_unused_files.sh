#!/bin/bash

# 检查是否提供了目标目录参数
if [ -z "$1" ]; then
    echo "用法: $0 <目标目录> [-d 删除无用文件]"
    exit 1
fi

# 目标目录
TARGET_DIR="$1"

# 确保目标目录存在
if [ ! -d "$TARGET_DIR" ]; then
    echo "错误: 目录 '$TARGET_DIR' 不存在！"
    exit 1
fi

# 查找无用文件
find_unused_files() {
    find "$TARGET_DIR" -type f \( -name "._*" -o -name ".DS_Store" -o -name "Thumbs.db" \) -print0
}

# 删除无用文件
delete_unused_files() {
    echo "正在删除以下无用文件："
    while IFS= read -r -d '' file; do
        echo "$file"
        rm -f "$file"
    done <<< "$1"
}

# 主逻辑
UNUSED_FILES=$(find_unused_files)

if [ -z "$UNUSED_FILES" ]; then
    echo "目录 '$TARGET_DIR' 是干净的，没有找到无用文件。"
else
    echo "以下是 '$TARGET_DIR' 中的无用文件："
    echo "$UNUSED_FILES" | tr '\0' '\n'

    # 检查是否需要删除
    if [ "$2" == "-d" ]; then
        delete_unused_files "$UNUSED_FILES"
        echo "无用文件已删除。"
    fi
fi
