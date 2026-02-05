#!/bin/bash
# SPDX-FileCopyrightText: 2026 misujumpei
# SPDX-License-Identifier: BSD-3-Clause

# 1. 環境の読み込みチェック
echo "--- ROS 2の読み込み ---"
source /opt/ros/humble/setup.bash && echo "ROS 2 OK"

# 2. ビルドができるかチェック
echo "--- ビルド実行 ---"
cd /root/ros2_ws
colcon build --packages-select mypkg && echo "Build OK!"
