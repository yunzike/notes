## 1、WSL 2 的安装

- 官方文档：https://docs.microsoft.com/zh-cn/windows/wsl/install-win10#manual-installation-steps



- 设置 root 密码

  ```bash
  sudo passwd root
  ```

- 切换 root 账户

  ```bash
  su root
  ```

- 查看 ubuntu 版本

  ```bash
  lsb_release -a
  ```

  



## 2、安装 Docker

- 安装脚本

  ```bash
  # install docker
  curl -fsSL https://get.docker.com -o get-docker.sh
  sudo sh get-docker.sh
  
  if 【 ! $(getent group docker) 】;
  then
      sudo groupadd docker;
  else
      echo docker user group already exists
  fi
  
  sudo gpasswd -a $USER docker
  sudo service docker restart
  
  rm -rf get-docker.sh
  ```

- 启动 docker

  ```bash
  sudo service docker start
  ```

  

## 3、Win10 与 WSL2 文件操作

- WSL2 中访问 win10 的文件

  ```bash
  # 因为 Windows 文件被挂载到 WSL2 的 /mnt/ 目录，直接操作即可
  $ cd /mnt
  ```

- 在 win10 中查看WSL2 的文件

  ```bash
  # 进入要访问的目录后,执行以下命令
  $ explorer.exe .
  ```

  



