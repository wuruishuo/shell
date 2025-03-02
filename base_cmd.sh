#!/bin/bash

#RED=$"\e[31m"

GREEN=$'\e[32m' # 正确！变量值为 ANSI 转义序列
YELLOW=$'\e[33m'
BLUE=$'\e[34m'

#RESET=$'\e[0m' # 重置颜色m"

NC=$'\033[0m'  # 恢复默认颜色
Operation=(基础命令 基础显示 版本号显示 磁盘 进程 内核 硬件)
base_command=(neofetch fastfetch)
Display_Version=("lsb_release -a" "cat /etc/os-release" "cat /proc/version")
#basic_display=("echo $XDG_CURRENT_DESKTOP" "echo $XDG_SESSION_TYPE" "echo $DESKTOP_SESSION" "systemctl status display-manager | head -n 1 | cut -c 4-20 |  cut -d '.' -f1")
basic_display=("查看桌面环境" "查看显示服务器" "显示桌面会话" "查看显示管理器")
disk=("磁盘详细分区" "磁盘关系" "磁盘空间/挂载" "内存查看")
process=("查看全部进程" "查看当前用户进程")
kernel=("内核全部信息" "显示内核发行版本号" "处理器架构")
cpu=("cpu基本信息" "详细信息需要安装hwinfo（全线程）" "温度")
gpu=("查看显卡型号" "图像显示")
while true; do
    for index in "${!Operation[@]}"; do
        num=$((index + 1))
        echo -e $num"." $GREEN ${Operation[index]} $NC
    done
    read -p $"请选择操作：${YELLOW}" OperNum
    printf ${NC} #颜色清除
    case $OperNum in
    1)

        for index in "${!base_command[@]}"; do
            num=$((index + 1))
            echo $num"."$GREEN ${base_command[index]} $NC
        done
        read -p "输入操作1：${YELLOW}" operation1

        case $operation1 in
        1)
            ${base_command[0]}
            ;;
        2)
            ${base_command[1]}
            ;;
        esac
        printf ${NC} #颜色清除
        echo ""
        ;;
    2)

        for index in "${!basic_display[@]}"; do
            num=$((index + 1))
            echo $num"."$GREEN ${basic_display[index]} $NC
        done
        read -p "输入的操作2：${YELLOW}" operation2
        case $operation2 in
        1)
            echo $XDG_CURRENT_DESKTOP
            ;;
        2)
            echo $XDG_SESSION_TYPE
            ;;
        3)
            echo $DESKTOP_SESSION
            ;;
        4)
            printf "现在的显示管理器为: "
            systemctl status display-manager | head -n 1 | cut -c 4-20 | cut -d '.' -f1
            ;;

        esac
        printf ${NC} #颜色清除
        echo ""
        ;;

    3)

        for index in "${!Display_Version[@]}"; do
            num=$((index + 1))
            echo $num"."$GREEN ${Display_Version[index]} $NC
        done
        read -p "输入的操作3：${YELLOW}" operation3
        case "$operation3" in
        1)
            ${Display_Version[0]}
            ;;
        2)
            ${Display_Version[1]}
            ;;
        3)
            ${Display_Version[2]}
            ;;
        esac
        printf ${NC} #颜色清除
        echo ""
        ;;
    4)
        for index in "${!disk[@]}"; do
            num=$((index + 1))
            echo $num"."$GREEN ${disk[index]} $NC
        done
        read -p "输入的操作4：${YELLOW}" operation4
        case $operation4 in
        1)
            sudo fdisk -l
            ;;
        2)
            lsblk
            ;;
        3)
            df -h
            ;;
        4)
            free -h
            ;;
        esac
        printf ${NC} #颜色清除
        echo ""
        ;;
    5)
        for index in "${!process[@]}"; do
            num=$((index + 1))
            echo $num"."$GREEN ${process[index]} $NC
        done
        read -p "输入的操作5：${YELLOW}" operation5
        case "$operation5" in
        1)
            ps -aux
            ;;
        2)
            ps -l
            ;;

        esac
        printf ${NC}
        echo ""
        ;;
    6)
        for index in "${!kernel[@]}"; do
            num=$((index + 1))
            echo $num"."$GREEN ${kernel[index]} $NC
        done
        read -p "输入的操作6：${YELLOW}" operation6
        case $operation6 in
        1)
            uname -a
            ;;
        2)
            uname -r
            ;;
        3)
            uname -m
            ;;
        esac
        printf ${NC}
        echo ""
        ;;
    7)
        echo "1.$GREEN CPU" $NC
        echo "2.$GREEN GPU" $NC
        read -p "输入的操作7：${YELLOW}" operation7
        printf $NC

        case $operation7 in
        1)
            for index in "${!cpu[@]}"; do
                num=$((index + 1))
                echo $num"."$GREEN ${cpu[index]} $NC
            done

            read -p "输入的操作7.1：${YELLOW}" operation7_1

            case $operation7_1 in
                1)
                   lscpu
                    ;;
                2)
                   sudo hwinfo --cpu | less
                    ;;
                3)
                # echo "1.不适用于fish"
                # echo "2.适用于fish"
                # read -p "输入的操作7.1.1：${YELLOW}" operation7_1_1
                # case $operation7_1_1 in
                #     1)
                        echo "CPU温度: $(($(cat /sys/class/thermal/thermal_zone0/temp)/1000))°C"
                #         ;;
                #     2)
                #       echo "CPU温: "(math (cat /sys/class/thermal/thermal_zone0/temp) / 1000)"°C"度）
                #         ;;
                # esac

            esac
            printf ${NC}
            ;;
        2)
            for index in "${!gpu[@]}"; do
                num=$((index + 1))
                echo $num"."$GREEN ${gpu[index]} $NC
            done
            read -p "输入的操作7.2：${YELLOW}" operation7_2

            case $operation7_2 in
                1)
                    read -p "详细还是简单（1/2）: ${YELLOW}" operation7_2
                    printf ${BLUE}
                    case $operation7_2 in
                        1)
                            lspci | grep -i vga
                            ;;
                        2)
                            sudo lshw -C display
                            ;;
                    esac
                    ;;
                2)
                   inxi -G
                    ;;
            esac
            printf ${NC}

            ;;

        esac
        echo ""
        ;;

    esac

done
