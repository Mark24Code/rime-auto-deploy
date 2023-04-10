# Rime auto deploy

一个自用的脚本，帮助无痛快速安装、部署 Rime 输入法（中州韵、小狼毫，鼠须管）以及部署配置。

* 集成 雾凇拼音配置，来源 https://dvel.me/posts/rime-ice/
* 集成 20款 输入法皮肤, 来源 https://ssnhd.com/2022/01/11/rime-skin/ 包括微信皮肤
* 新增主题。支持Linux、MacOS。

## 系统

⚠️ 支持：

* MacOS ✅
* Linux 发行版 ✅
* Windows ✅  [查看 Windows 下的说明文档](./WINDOWS_README.md)

![rime](./images/rime.jpeg)
![result](./images/result.png)
![working](./images/working.png)

## 依赖

安装 `Ruby 3`

* Mac OS `brew install ruby`
* Debian Linux distro `sudo apt install ruby`
* 其他 Linux 根据自己情况判断。有些 Linux 可能自带 Ruby

⚠️ MacOS脚本会自动帮助安装 Rime，Linux下由于发行版、Rime 衍生方式太多，需要自行提前安装 Rime。

```
For Fcitx5, install fcitx5-rime.
For Fcitx, install fcitx-rime.
For IBus, install ibus-rime.

more: https://wiki.archlinux.org/title/Rime
```

## MacOS/Linux 使用方法

>> Linux发行版和包管理太多，需要执行安装 Rime。MacOS 使用 brew 自动安装，需要拥有 brew。

step1: 克隆到本地

`git clone --depth=1 https://github.com/Mark24Code/rime-auto-deploy.git --branch v3.0.1`

step2: 执行部署脚本

`./installer.rb`

## Windows 使用方法

[查看 Windows 下的说明文档](./WINDOWS_README.md)


## 自动部署内容：

step1: 确认安装 Rime 输入法，自动安装

需要用户自行登出，重进系统，设置Rime输入法为系统输入法

step2: 备份 Rime 默认配置

step3: 自动安装 Rime-ice 配置

step4: 自动追加自定义配置模板


### 参考&感谢：

* 流程参考 Tiwtter： @lewangdev
* 配置来源：https://github.com/iDvel/rime-ice
