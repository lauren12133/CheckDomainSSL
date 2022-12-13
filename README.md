# CheckDominSSL
## 批量监测域名SSL证书过期并通知TGbot，支持自定义证书（bot-api以加入反代接口国内可用，不需要的可自行更改，不提供技术支持）

### 使用方法

### 创建文件目录
```shell
mkdir $(pwd)/checkdominssl
```
### 国外环境
```shell
wget https://raw.githubusercontent.com/lauren12133/CheckDominSSL/main/cdssl.sh -O $(pwd)/checkdominssl/cdssl.sh && chmod +x $(pwd)/checkdominssl/cdssl.sh
```
### 国内环境
```shell
wget https://ghproxy.com/https://raw.githubusercontent.com/lauren12133/CheckDominSSL/main/cdssl.sh -O $(pwd)/checkdominssl/cdssl.sh && chmod +x $(pwd)/checkdominssl/cdssl.sh
```
### 填写测试端口 TGbot等环境变量
```shell
vi $(pwd)/checkdominssl/cdssl.sh
```
### 添加域名
```shell
#方法1“echo”
echo '域名' >> $(pwd)/checkdominssl/https_list.txt
```
```shell
#方法2“vim”
vim $(pwd)/checkdominssl/https_list.txt
```
### 运行
```shell
bash $(pwd)/checkdominssl/cdssl.sh
```
# 结束
