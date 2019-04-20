#!/usr/bin/expect
#上半部分以.exp结尾
#这里要注意执行环境为：#!/usr/bin/expect ）
#注意，如果没有expect，请先安装，yum -y install expect 或apt-get -y install expect
set timeout 10  
set username [lindex $argv 0] #传入第一个参数，用户名
set password [lindex $argv 1] #传入第二个参数，密码
set hostname [lindex $argv 2] #传入第三个参数 主机
 
spawn ssh-copy-id -i /root/.ssh/id_rsa.pub $username@$hostname #这里为主要动作
 
expect {
            # irst connect, no public key in ~/.ssh/known_hosts
            "Are you sure you want to continue connecting (yes/no)?" { #捕获输出的提示，一般第一次ssh连接的时候回出现这个安全提示
            send "yes\r"    #实现自动交互，通过send自动输入yes并回车
            expect "password:" #捕获提示输入密码的字符串
            send "$password\r" #实现自动交互输入密码
            }
            #already has public key in ~/.ssh/known_hosts
            "password:" {
            send "$password\r" #实现自动交互输入密码
            }
            "Now try logging into the machine" {
                #it has authorized, do nothing!
            }
        }
expect eof






#!/usr/bin/env bash
 
user="root"
passwd="1qaz#EDC"
 
for i in `seq 150 155`; do
ip="192.168.100.$i"
/root/auto_except_ssued_publickey.sh $user $passwd $ip    #调用下发ssh公钥的脚本，且传入三个对应的参数
done