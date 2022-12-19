#!/bin/bash
set -x 
# 设置域名 端口默认443
domains=( abc.com cbd,com )
port=443

# 低于多少天通知快过期域名默认5天
threshold=5

# 多久运行一次单位秒默认3天

sleep_run(){
        sleep 259200
}

# TGbot
api_key="****"
chat_id="*****"
#API地址不懂不要动
URL=https://thingproxy.freeboard.io/fetch/https://api.telegram.org/bot$api_key/sendMessage

# opensslpath
openssl_path="/usr/bin/openssl"

# temp_file
temp_file="/tmp/ssl_cert_info.txt"



while true; do
  # 逻辑判断域名缓存
  expired_domains=""
  remaining_domains=""

  for domain in "${domains[@]}"; do
    $openssl_path s_client -servername $domain -connect $domain:$port < /dev/null 2> /dev/null | $openssl_path x509 -noout -enddate > $temp_file

    expiration_date=$(grep "notAfter" $temp_file | cut -d'=' -f2)

    expiration_timestamp=$(date -d "$expiration_date" +%s)

    current_timestamp=$(date +%s)

    days_remaining=$(( (expiration_timestamp - current_timestamp) / 86400 ))

    if [ $days_remaining -lt $threshold ]; then
      expired_domains="$expired_domains $domain(有效期剩余：$days_remaining天)"
    else
      remaining_domains="$remaining_domains $domain (有效期剩余：$days_remaining天)"
    fi
  done

  if [ ! -z "$expired_domains" ]; then
    message="💀💀💀存在5天快过期的域名:$expired_domains"
    curl -s -X POST $URL -d chat_id=$chat_id -d text="$message" > /dev/null
  fi

  if [ ! -z "$remaining_domains" ]; then
    message="👍︎👍︎👍︎这些域名没过期$remaining_domains"
    curl -s -X POST $URL -d chat_id=$chat_id -d text="$message" > /dev/null
  fi
sleep_run
done

