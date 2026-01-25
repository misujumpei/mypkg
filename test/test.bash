#!/bin/bash
# SPDX-FileCopyrightText: 2026 misujumpei
# SPDX-License-Identifier: BSD-3-Clause

dir=~
[ "$1" != "" ] && dir="$1"

# ビルド
cd $dir/ros2_ws
colcon build
source install/setup.bash

# 環境変数をセット
export PYTHONUNBUFFERED=1

# 10秒だけtalkerを動かす。bash -c を使って設定を確実に読み込ませる
timeout 10 bash -c "source /opt/ros/humble/setup.bash; source $dir/ros2_ws/install/setup.bash; ros2 run mypkg talker" > /tmp/talker.log 2>&1

# ログ確認用
cat /tmp/talker.log

# 答えが入ってれば合格
grep '答え' /tmp/talker.log
