#!/bin/bash
# SPDX-FileCopyrightText: 2026 misujumpei
# SPDX-License-Identifier: BSD-3-Clause

dir=~
[ "$1" != "" ] && dir="$1" 

cd $dir/ros2_ws
colcon build
source /opt/ros/humble/setup.bash # 環境読み込み
source install/setup.bash

# 10秒動かしてログへ代入。&で裏で動かす
timeout 10 ros2 run mypkg talker > /tmp/mypkg.log 2>&1 &
timeout 10 ros2 run mypkg listener >> /tmp/mypkg.log 2>&1 &

sleep 5 # 通信を待つ

# 判定
cat /tmp/mypkg.log | grep '答え'
