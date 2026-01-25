#!/bin/bash
# SPDX-FileCopyrightText: 2026 misujumpei
# SPDX-License-Identifier: BSD-3-Clause

dir=~
[ "$1" != "" ] && dir="$1"

# ビルド
cd $dir/ros2_ws
colcon build
source install/setup.bash

# 5秒talker動かしてログに保存
# 設定読み込み
timeout 5 bash -c "source /opt/ros/humble/setup.bash; source $dir/ros2_ws/install/setup.bash; export PYTHONUNBUFFERED=1; ros2 run mypkg talker" > /tmp/talker.log 2>&1

# ログ確認
cat /tmp/talker.log

# 判定
grep '答え' /tmp/talker.log
