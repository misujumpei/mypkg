#!/bin/bash
# SPDX-FileCopyrightText: 2026 misujumpei
# SPDX-License-Identifier: BSD-3-Clause

cd /root/ros2_ws
colcon build
source /opt/ros/humble/setup.bash
source install/setup.bash

# 出力をリアルタイムに出す
export PYTHONUNBUFFERED=1

# Talkerを起動
timeout 10 ros2 run mypkg talker > /tmp/mypkg.log 2>&1 &
# Listenerを起動
sleep 2
timeout 10 ros2 run mypkg listener >> /tmp/mypkg.log 2>&1 &

# 通信が完了するまで待つ
sleep 10

# デバッグ用
cat /tmp/mypkg.log

# 「答え」という文字が含まれているか
grep -i '答え' /tmp/mypkg.log || exit 1
