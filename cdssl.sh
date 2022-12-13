#!/bin/bash

port=***

#tg_bot通知

#bot_token
TOKEN=***
#bot_id
CHAT_ID=***
#下面不懂不要动
URL="https://thingproxy.freeboard.io/fetch/https://api.telegram.org/bot$TOKEN/sendMessage"


#检测https证书有效
echo '开始检查 https证书有效期'

#定义错误的域名
errorDominStr=""

while read line; do
    echo "====================================================================================="
    echo "当前检测的域名：" $line
    end_time=$(echo | timeout 1 openssl s_client -servername $line -connect $line:$port 2>/dev/null | openssl x509 -noout -enddate 2>/dev/null | awk -F '=' '{print $2}' )
    ([ $? -ne 0 ] || [[ $end_time == '' ]]) && echo '该域名链接不上,跳到下一个域名' && continue
    
    end_times=`date -d "$end_time " +%s`
    current_times=`date -d "$(date -u '+%b %d %T %Y GMT') " +%s`

	echo "截至日期: " $end_times
	echo "当前日期: " $current_times
	
    
    let left_time=$end_times-$current_times
    days=`expr $left_time / 86400`
    echo "剩余天数: " $days
    
    [ $days -lt 5 ] && echo "https 证书有效期少于5天，存在风险"  && errorDominStr="$errorDominStr  $line"
    
done < $(pwd)/checkdominssl/https_list.txt


echo -e "准备过期的域名为： \n  $errorDominStr"

if [ "$errorDominStr" = "" ]
then
  echo "不包含准备过期的域名"
  bgq="👍︎👍︎👍︎不存在低于5天准备过期的域名

👋👋👋︎Good bye!"

  MESSAGE=$bgq
  
  curl -s -X POST $URL -d chat_id=$CHAT_ID -d text="$MESSAGE" 
else
  echo "包含准备过期的域名"
  
  gq="💀💀💀存在不到5天就过期的域名
  
包含准备过期的域名:

$errorDominStr

👆︎👆︎👆︎快去续约上方域名吧
  "
  
  MESSAGE=$gq
  
  curl -s -X POST $URL -d chat_id=$CHAT_ID -d text="$MESSAGE"
  
  exit 10
fi

echo "Good bye!"

exit 0
