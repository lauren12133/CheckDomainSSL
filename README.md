# CheckDominSSL
## 批量监测域名SSL证书过期并通知TGbot，支持自定义端口（bot-api以加入反代接口国内可用，不需要的可自行更改，不提供技术支持）

### 使用方法

### 创建文件目录
```shell
mkdir $(pwd)/checkdomainssl
```
### 国外环境
```shell
wget https://raw.githubusercontent.com/lauren12133/CheckDomainSSL/main/cdssl.sh -O $(pwd)/checkdominssl/cdssl.sh && chmod +x $(pwd)/checkdomainssl/cdssl.sh
```
### 国内环境
```shell
wget https://ghproxy.com/https://raw.githubusercontent.com/lauren12133/CheckDomainSSL/main/cdssl.sh -O $(pwd)/checkdomainssl/cdssl.sh && chmod +x $(pwd)/checkdominssl/cdssl.sh
```
### 填写测试端口 添加域名 TGbot等环境变量 
```shell
vi $(pwd)/checkdomainssl/cdssl.sh
```
### 运行
```shell
bash $(pwd)/checkdomainssl/cdssl.sh
```

## Docker
https://hub.docker.com/r/asirkk/checkdomain
# 结束
