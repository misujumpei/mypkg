#!/bin/bash
# SPDX-FileCopyrightText: 2026 misujumpei
# SPDX-License-Identifier: BSD-3-Clause

# エラー発生時にスクリプト終了
set -e

# ビルドと環境設定
source /opt/ros/humble/setup.bash
cd /root/ros2_ws
colcon build --packages-select mypkg
source install/setup.bash

# 10秒間動かし、ログをとる
timeout 10 ros2 run mypkg talker > /tmp/talker.log 2>&1 &
timeout 10 ros2 run mypkg listener > /tmp/listener.log 2>&1 &

# 終わるまで待機
sleep 11

# ログの中に文字があるかチェック
grep '問題' /tmp/talker.log
grep '変換・送信' /tmp/listener.log
