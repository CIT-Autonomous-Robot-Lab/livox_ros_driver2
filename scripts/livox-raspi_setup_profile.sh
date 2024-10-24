#!/bin/bash

# ip linkコマンドの出力を取得
ip_output=$(ip link)

# 正規表現パターンを定義
pattern="(eno|enp|ens|enx|eth0)[[:alnum:]]*"

# パターンにマッチする行を抽出し、インターフェース名を取得
interface_name=$(echo "$ip_output" | grep -oE "$pattern")

echo "ネットワークインターフェース名: $interface_name"

# プロファイル名
PROFILE_NAME="livox-raspi-SwitchingHub"

# IPv4設定1
IPV4_ADDRESS_1="10.42.0.1/24"
GATEWAY_IPV4_1=""

# IPv4設定2
IPV4_ADDRESS_2="192.168.1.50/24"
GATEWAY_IPV4_2=""

# IPv6設定（無効にする）
IPV6_METHOD="ignore"

# ネットワーク接続を作成（最初のIPv4アドレス）
nmcli connection add type ethernet ifname $interface_name con-name $PROFILE_NAME ipv4.addresses $IPV4_ADDRESS_1 ipv4.method manual ipv6.method $IPV6_METHOD

# 2つ目のIPv4アドレスを追加
nmcli connection modify $PROFILE_NAME +ipv4.addresses $IPV4_ADDRESS_2

# ゲートウェイ1がある場合に設定
if [ -n "$GATEWAY_IPV4_1" ]; then
    nmcli connection modify $PROFILE_NAME ipv4.gateway $GATEWAY_IPV4_1
fi

# ゲートウェイ2がある場合に設定
if [ -n "$GATEWAY_IPV4_2" ]; then
    nmcli connection modify $PROFILE_NAME ipv4.gateway $GATEWAY_IPV4_2
fi

# 接続を有効化
nmcli connection up $PROFILE_NAME

echo "ネットワークプロファイル $PROFILE_NAME が作成され、有効化されました。"

