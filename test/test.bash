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

echo "--- Step 4: TalkerとListenerの起動テスト ---"
export PYTHONUNBUFFERED=1

# Talkerを10秒間動かして、ログに残す
timeout 10 ros2 run mypkg talker > /tmp/talker.log 2>&1 &

# 2秒待ってから、Listenerも10秒間動かして、別のログに残す
sleep 2
timeout 10 ros2 run mypkg listener > /tmp/listener.log 2>&1 &

# 終わるまで10秒待つ
sleep 10

# 両方のファイルが空でないことを確認
[ -s /tmp/talker.log ] && [ -s /tmp/listener.log ] && echo "Double Execution OK"

echo "--- 2つのログをチェック ---"

echo "--- Talkerの確認 ---"
cat /tmp/talker.log
grep '問題' /tmp/talker.log

echo "--- Listenerの確認 ---"
cat /tmp/listener.log
grep '受信' /tmp/listener.log && echo "Final Result: ALL OK!"
