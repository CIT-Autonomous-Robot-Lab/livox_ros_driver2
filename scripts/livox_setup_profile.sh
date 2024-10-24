#!/bin/bash

# ip linkコマンドの出力を取得
ip_output=$(ip link)

# 正規表現パターンを定義
pattern="(eno|enp|ens|enx|eth0)[[:alnum:]]*"

# パターンにマッチする行を抽出し、インターフェース名を取得
interface_name=$(echo "$ip_output" | grep -oE "$pattern")

echo "ネットワークインターフェース名: $interface_name"

sudo nmcli connection add \
  con-name livox-host \
  ifname $interface_name \
  type ethernet \
  ipv4.method manual \
  ipv4.address 192.168.1.50/24 \
  ipv6.method disabled

# old
#sudo nmcli connection add \
#  con-name livox-host \
#  ifname $interface_name \
#  type ethernet \
#  ipv4.method manual \
#  ipv4.address 192.168.1.50/24 \
#  ipv4.gateway 192.168.1.1 \
#  ipv6.method disabled \
#  ipv4.dns 192.168.1.1

nmcli connection up livox-host
