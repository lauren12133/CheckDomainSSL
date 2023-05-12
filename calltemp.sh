#!/bin/bash

# 如果您的TGbot令牌和聊天ID不同，请将它们替换为真实值
token="****"
chat_id="*****"
URL="https://api.telegram.org/bot${token}/sendMessage"  #默认地址需要设备翻墙，支持自定义反代地址
high_temp=50 #你想设置的温度墙

get_temp=$(sensors | grep 'temp1' | sed -n 3p | cut -c 16-22)
get_temp2=$[$(cat /sys/class/thermal/thermal_zone0/temp)/1000]

while true; do
  #get_temp需要安装lm-sensors依赖更准确，如果不想安装请改为$get_temp2。
  temp=$get_temp2
  if [[ ${temp%%.*} -ge $high_temp ]]; then
    curl -s -X POST $URL -d "chat_id=${chat_id}&text=当前温度：${temp}! 💀💀💀温度过高💀💀💀"
	sleep 10 #TG提醒时间默认10秒，如果触发温度过高，防止TG刷提醒烦人可根据自己需要调节甚至删除
  fi
  sleep 2 #多少时间执行一次默认2秒
done &



#如果想强行结束脚本 ps -aux | grep "bash calltemp.sh" | awk '{print $2}' | xargs kill
