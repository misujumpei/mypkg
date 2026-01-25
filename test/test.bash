#!/bin/bash
# SPDX-FileCopyrightText: 2026 misujumpei
# SPDX-License-Identifier: BSD-3-Clause

dir=~
[ "$1" != "" ] && dir="$1"

cd $dir/ros2_ws
colcon build
source install/setup.bash

# talkerを動かしてログを保存
ros2 run mypkg talker --once > /tmp/talker.log 2>&1

# ログ確認
cat /tmp/talker.log

# 答えが含まれてるか判定
grep '答え' /tmp/talker.log
