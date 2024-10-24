#!/bin/bash

# ip linkコマンドの出力を取得
ip_output=$(ip link)

# 正規表現パターンを定義
pattern="(eno|enp|ens|enx|eth0)[[:alnum:]]*"

# パターンにマッチする行を抽出し、インターフェース名を取得
interface_name=$(echo "$ip_output" | grep -oE "$pattern")

# ネットワークインターフェース名を表示
echo "ネットワークインターフェース名: $interface_name"
