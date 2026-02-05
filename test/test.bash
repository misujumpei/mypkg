#!/bin/bash
# SPDX-FileCopyrightText: 2026 misujumpei
# SPDX-License-Identifier: BSD-3-Clause


echo "--- ROS 2の読み込み ---"
source /opt/ros/humble/setup.bash && echo "ROS 2 OK"


echo "--- ビルド実行 ---"
cd /root/ros2_ws
colcon build --packages-select mypkg && echo "Build OK"

echo "--- プログラムの存在確認 ---"
# 設定を読み込む
source install/setup.bash
# ファイルがあるか確認して、あればメッセージを出す
ls install/mypkg/lib/mypkg/talker && echo "Program File OK"
