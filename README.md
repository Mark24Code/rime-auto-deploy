# Rime auto deploy

⚠️ 支持：

* MacOS ✅
* Debian 发行版 ✅
  * Debian ✅
  * Ubuntu ✅
  * Mint ✅
  * 其他可以自行修改配置 ✅
* REDHAT 发行版 ❌
* Windows ❌

![rime](./images/rime.jpeg)
![result](./images/result.png)
![working](./images/working.png)

## Linux 说明

Debian发行版，默认注册了

* debian
* ubuntu
* linuxmint
* linux-mint

可以在 `lib/config` 中 `Config::DebianDistroLinux::DebianDistro` 中自行添加关键字支持。

### 参考&感谢：

* 流程参考 Tiwtter： @lewangdev
* 配置来源(fork了一版本）：https://github.com/iDvel/rime-ice


# 使用方法

step1: 克隆到本地

`git clone --depth=1 https://github.com/Mark24Code/rime-auto-deploy.git --branch v1.0.0`

step2: 执行部署脚本

`./installer.rb`

# 自动部署内容：

## step1: 确认安装 Rime 输入法，自动安装

需要用户自行登出，重进系统，设置Rime输入法为系统输入法

## step2: 备份 Rime 默认配置

## step3: 自动安装 Rime-ice 配置

## step4: 自动追加自定义配置模板


