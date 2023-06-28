# V2Ray-Trojan-ShadowSocks_DockerCompose

基于Docker Compose的简易的trojan, v2ray服务部署方案。

[English](README_EN.md)

## 准备工作

1. 用于部署的服务器
2. 已购买的域名，并将域名解析到对应的服务器，具体解析主域名还是子域名都可以
3. 服务器环境
   a. 安装Docker Compose，具体参考 [Install the Compose plugin](https://docs.docker.com/compose/install/linux/)
   b. 安装CertBot，用于域名免费证书的申请，具体可以参考 [CertBot官网](https://certbot.eff.org/)
   c. 安装Git，具体参考[Git Download](https://git-scm.com/downloads)

## 步骤

1. git clone 本项目
2. 替换本项目中所有的example.com，替换为已购买的域名，按需替换。需要替换的文件有：
   * nginx/cert.sh
   * nginx/nginx.conf
   * nginx/conf.d/ssl.conf
   * trojan/config.json
3. 根据部署的目录替换 **nginx/cert.sh** 中的**to_path**；**from_path**根据-d后的第一个域名，按情况修改
4. 添加 **v2fly_vless/config.json** 和 **v2fly_vmess/config.json** 中的id，此处的id对应v2ray配置中的用户ID，需要用户自己配置
5. 修改 **trojan/config.json** 文件中的password，此处也是对应trojan配置中的密码
6. 执行 nginx/cert.sh 文件，给域名自签免费证书 (3个月到期)
7. 启动docker compose 即可

## 说明

#### nginx

这里主要说明一下转发逻辑。以example.com为例子。

nginx监听了80端口、443端口和8443端口，其中仅80和443是对外开放接口，对应listen的conf是 **nginx/conf.d/default.conf**、**nginx/nginx.conf** 和 **nginx/conf.d/ssl.conf**

* 如果请求进入80端口，则会自动重定向到443端口
* 如果请求进入443端口，则会根据域名进行分流
  * 如果域名是trojan.example.com，则会直接打到trojan服务监听的端口号，即8080端口
  * 其余情况，nginx会打到自身监控的8443端口，请求进入8443端口后，分流如下
    * 如果 **path=/v2ray/vless** ，则请求转发到vless服务，端口号11000
    * 如果 **path=/v2ray/vmess** ，则请求转发到vmess服务，端口号12000

#### v2ray协议

默认支持vless和vmess两种协议，区别在于path不一样。

> vless只支持了ws(websocket)模式，如果想支持别的inbounds协议，需要自行修改**v2fly_vless/config.json**
> vmess也只支持了ws模式，同样的，如果需要支持别的模式，自行修改**v2fly_vmess/config.json**

修改配置的话，具体参考(v2ray-core)[https://github.com/v2fly/v2ray-core]

#### trojan协议

trojan协议也主要支持了websocket模式，如果需要支持别的模式，请自行修改 **trojan/config.json**。具体参考[trojan-go](https://github.com/p4gefau1t/trojan-go)

#### 镜像

nginx、v2ray和trojan均使用的官方镜像，即nginx、v2fly/v2fly-core、p4gefau1t/trojan-go。

> 需要注意的一点是，目前本项目的v2ray配置，只能支持到4.45.2版本的v2ray镜像。如果需要支持5.0以上版本，需要自行修改**v2fly_vless/config.json**和**v2fly_vmess/config.json**

![img.png](img.png)

最后附图一张，图里的shadowsocks已经去掉了，不过懒得改了。
