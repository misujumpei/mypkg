#!/bin/bash
# SPDX-FileCopyrightText: 2026 misujumpei
# SPDX-License-Identifier: BSD-3-Clause

dir=~
[ "$1" != "" ] && dir="$1"

cd $dir/ros2_ws  # ビルドとセットアップ
colcon build     #パッケージを作る 
source install/setup.bash

# talker, listener は10秒経ったら強制終了する
timeout 10 ros2 run mypkg talker > /tmp/talker.log 2>&1 &  
timeout 10 ros2 run mypkg listener > /tmp/listener.log 2>&1 &

# 通信してメッセージがでるまで5秒待つ
sleep 5

# listenerに 答え と出たら終了
cat /tmp/listener.log | grep '答え:'
