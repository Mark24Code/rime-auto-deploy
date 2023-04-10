

# Windows下的说明


# 一、环境准备

## 01 安装 Ruby

Ruby 类似于 Python 是一个脚本语言，为了能运行脚本，需要在系统中提前安装 Ruby 解释器。不同于 MacOS、Linux 系统有包管理器（一种方便通过命令行自动安装软件的软件）。Windows 用户需要自己准备好环境安装。

### Windows 上通过 RubyInstaller 安装 Ruby

全部版本下载地址： https://rubyinstaller.org/downloads/


也可以点击下面直接下载 Ruby 3.2.2（截至2023年4月10日最新版本），选择适合你的架构版本。

* [Ruby+Devkit 3.2.2-1 (x64) ](https://github.com/oneclick/rubyinstaller2/releases/download/RubyInstaller-3.2.2-1/rubyinstaller-devkit-3.2.2-1-x64.exe)
* [Ruby+Devkit 3.2.2-1 (x86) ](https://github.com/oneclick/rubyinstaller2/releases/download/RubyInstaller-3.2.2-1/rubyinstaller-devkit-3.2.2-1-x86.exe)


####  Ruby 安装设置建议

1. 按照默认工作的方式进行勾选

参考仓库 `/images/windows/01-install-ruby` 中图示，列举的步骤

2. 运行的过程中可能存在网络访问问题，参考终端设置代理

Terminal 设置代理

例子如下： “7890” 替换成你本地梯子的端口，有的需要打开“局域网内允许代理”。
```
set http_proxy=127.0.0.1:7890
set https_proxy=127.0.0.1:7890
```

更多可以参考: 

* [windows终端命令行下如何使用代理？ ](https://github.com/shadowsocks/shadowsocks-windows/issues/1489)



## 02 安装 Git

Windows 可以去 Git 的官网安装 Git。

[https://git-scm.com/downloads](https://git-scm.com/downloads)

按照默认的设置，一路确认安装即可。

（下载配置仓库需要 Git）

## 03 下载脚本

有两种方式

1. 可以通过 git 下载

打开终端（Powershell、Cmd.exe、GitBash都可以）

`git clone https://github.com/Mark24Code/rime-auto-deploy.git`

或者到下面的路径下载压缩包

https://github.com/Mark24Code/rime-auto-deploy/releases



## 04 安装 Rime 中州韵 

在这里自行下载安装 Windows

[https://rime.im/download/](https://rime.im/download/)


⚠️采用默认路径
![default-path](/images/windows/04-install-rime/step1-default-path.png)

## 05 执行脚本

第一次执行脚本，需要执行中止 Rime小狼毫 的服务。后者正在执行的程序会无法替换配置文件夹。

也可以直接在项目管理器中推出进程（推荐）。

![stop-service](/images/windows/05-run-script/step1-quit-servce.png)


打开下载脚本目录，右击使用终端打开。执行 `ruby installer.rb`

![run-script](/images/windows/05-run-script/step2-open-terminal.png)