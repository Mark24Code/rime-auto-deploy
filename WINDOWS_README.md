

# Windows下的说明

不同于 MacOS、Linux 大部分的工具内置、亦或者系统有包管理器（一种方便通过命令行自动安装软件的软件）可以方便安装软件。Windows 用户需要自己准备好环境安装。

## 01 安装 Ruby

Ruby 类似于 Python 是一个脚本语言。如果把他们都比喻做发动机，Ruby 的发动机更精致、性能高。 为了能运行脚本，需要在系统中提前安装 Ruby 解释器。

### Windows 上通过 RubyInstaller 安装 Ruby

全部版本下载地址： https://rubyinstaller.org/downloads/


也可以点击下面直接下载 Ruby 3.2.2（截至2023年4月10日最新版本），选择适合你的架构版本。

最小安装推荐（14.3M），运行脚本足以：

* [ Ruby 3.2.2-1 (x64) ](https://github.com/oneclick/rubyinstaller2/releases/download/RubyInstaller-3.2.2-1/rubyinstaller-3.2.2-1-x64.exe)
* [Ruby 3.2.2-1 (x86) ](https://github.com/oneclick/rubyinstaller2/releases/download/RubyInstaller-3.2.2-1/rubyinstaller-3.2.2-1-x86.exe)


> 官网提供 Ruby + DevKit 的 RubyInstaller 适合开发者，可以在本地构建C拓展。我们暂时不需要，感兴趣的可以自行探索。

####  Ruby 安装设置建议

1. 按照默认工作的方式进行勾选

⚠️ 关注添加到 PATH 的选项，如果出现请务必勾选 ⚠️

文件夹 `/images/windows/01-install-ruby` 给出 Ruby + DevKit 版本的完整图示。

安装其实一路默认点`继续`就好了

第一次打开终端，可能会有询问窗口，是否要安装开发者工具。普通用户选择 `1` 就好了。 Ruby开发者 `3` 更加合适。

![dev-chain](/images/windows/01-install-ruby/step6-dev-chain.png)


2. Windows 终端设置代理


终端，比如下载 `MSYS2 development toolchain` 如果遇到网络问题，可能需要设置代理。

例子如下： “7890” 替换成你本地梯子的端口，有的需要打开“局域网内允许代理”。
```
set http_proxy=127.0.0.1:7890
set https_proxy=127.0.0.1:7890
```

参考:  [windows终端命令行下如何使用代理？ ](https://github.com/shadowsocks/shadowsocks-windows/issues/1489)



## 02 安装 Git

下载配置仓库需要 Git。 Windows 可以去 Git 的官网安装 Git。

[https://git-scm.com/downloads](https://git-scm.com/downloads)

按照默认的设置，一路确认安装即可。

⚠️ 关注添加到 PATH 的选项，如果出现请务必勾选 ⚠️



## 03 下载脚本

有两种方式

1. 可以通过 git 下载

终端里，先进入想要存放的目录，执行：

`git clone https://github.com/Mark24Code/rime-auto-deploy.git`

2. 或者到下面的路径下载最新版本源码压缩包,解压到目录

https://github.com/Mark24Code/rime-auto-deploy/releases



## 04 安装 Rime 中州韵 

在这里自行下载安装 Windows 版本的 Rime 中州韵

[https://rime.im/download/](https://rime.im/download/)

自行安装， 务必 ⚠️采用默认路径安装⚠️。

![default-path](/images/windows/04-install-rime/step1-default-path.png)


## 05 执行脚本

第一次执行脚本，需要执行中止 Rime小狼毫 的服务。后者正在执行的程序会无法替换配置文件夹。

也可以直接在项目管理器中推出进程（推荐）。

![stop-service](/images/windows/05-run-script/step1-quit-servce.png)


打开下载脚本目录，右击使用终端打开所在目录。

![run-script](/images/windows/05-run-script/step2-open-terminal.png)


执行 `ruby .\installer.rb`

![success](/images/windows/05-run-script/step3-success-run.png)
