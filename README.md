# Rime auto deploy

一个自用的脚本，帮助无痛快速安装、部署 Rime 输入法（中州韵、小狼毫，鼠须管）以及部署配置。

* 集成 雾凇拼音配置，来源 https://dvel.me/posts/rime-ice/
* 集成 20款 输入法皮肤, 来源 https://ssnhd.com/2022/01/11/rime-skin/ 包括微信皮肤
* 新增主题。支持Linux、MacOS。

# 一、不同系统下使用说明

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

> Linux发行版和包管理太多，需要执行安装 Rime。MacOS 使用 brew 自动安装，需要拥有 brew。

step1: 克隆到本地

`git clone --depth=1 https://github.com/Mark24Code/rime-auto-deploy.git --branch v3.0.1`

step2: 进入项目目录

`cd rime-auto-deploy`

step3: 执行部署脚本

`./installer.rb`

## Windows 使用方法

[查看 Windows 下的说明文档](./WINDOWS_README.md)

# 二、工作模式说明

## 1. 自动模式 (Auto Mode)

适用于第一次安装输入法。

```
step01: 确认安装 Rime 输入法，自动安装

需要用户自行登出，重进系统，设置Rime输入法为系统输入法

step02: 备份 Rime 默认配置

step03: 自动安装 Rime-ice 配置

step04: 自动追加自定义配置模板
```

## 2. 手动模式 (Handle Mode)

手动模式可以自定义选择自动部署中 step 01~04 分别单独执行。
适用于想要单独对步骤进行运行，比如获取最新的 雾凇拼音配置、调试更新修改自定义配。

⚠️ 提示

1. 如果您已经安装了Rime，想手动执行：使用最新版本的 雾凇拼音

为了避免直接执行 `03` 会造成目录冲突，这里建议先执行 `02` 进行配置备份，再手动执行 `03` 进行配置下载。

> 备份文件并不会消失。而是会换个名字。放在同一个目录下。方便找回数据。如果觉得太冗余，可以手动删除历史备份的 `Rime.xxx.old` 的目录。

2. 如果想进行自定义配置

配置文件放在 `custom/` 目录中。在 `04` 步执行之后，会复制进入 Rime 的配置目录。

2.1 你可以把自己的配置放在  `custom` 中一起被复制

2.2 你可以修改 custom 中的配置

⚠️  RIME 配置使用了 YAML 格式，对空格、缩进保持敏感，尽可能地对齐。 `#` 前缀表示这行配置不生效，去除则生效。

配置文件可以对模糊拼音、皮肤、字体进行进一步的设置。

编辑完成保存文件，再手动执行 `04` 单独更新配置。

### 参考&感谢：

* 流程参考 Tiwtter： @lewangdev
* 配置来源：https://github.com/iDvel/rime-ice
