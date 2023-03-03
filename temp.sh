#!/bin/bash
set -x 
# 多久运行一次单位秒默认3小时
sleep_run(){
        sleep 10800
}
# TGbot
api_key="***"
chat_id="*****"
#API地址不懂不要动
URL=https://thingproxy.freeboard.io/fetch/https://api.telegram.org/bot$api_key/sendMessage


while true; do 
  temp=$[$(cat /sys/class/thermal/thermal_zone0/temp)/1000]
  if [ "$temp" -gt 30 ]; then
    curl -X POST $URL -d chat_id=$chat_id -d text="💀💀💀Pine64当前温度过高: $temp°💀💀💀" > /dev/null
  else
    curl -X POST $URL -d chat_id=$chat_id -d text="👍︎👍︎👍︎text":"当前温度: $temp°👍︎👍︎👍︎" > /dev/null
  fi 
  sleep_run
done
