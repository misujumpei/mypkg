#!/bin/bash
# SPDX-FileCopyrightText: 2026 misujumpei
# SPDX-License-Identifier: BSD-3-Clause

set -e

source /opt/ros/humble/setup.bash
cd /root/ros2_ws
colcon build --packages-select mypkg
source install/setup.bash

export ROS_LOG_DIR=/tmp/ros_log
mkdir -p /tmp/ros_log

export PYTHONUNBUFFERED=1

# 15秒間動かす
timeout 15 ros2 run mypkg talker > /tmp/talker.log 2>&1 &
timeout 15 ros2 run mypkg listener > /tmp/listener.log 2>&1 &

# 通信が行われるまで待機
sleep 20

# デバッグ用
echo "--- Talker Log ---"
cat /tmp/talker.log
echo "--- Listener Log ---"
cat /tmp/listener.log

# 最終チェック
grep '問題' /tmp/talker.log
grep '変換・送信' /tmp/listener.log
