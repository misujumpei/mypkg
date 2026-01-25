#!/bin/bash
# SPDX-FileCopyrightText: 2026 misujumpei
# SPDX-License-Identifier: BSD-3-Clause

dir=~
[ "$1" != "" ] && dir="$1"

cd $dir/ros2_ws  # ビルドとセットアップ
colcon build     #パッケージを作る 
source install/setup.bash


# 出力を溜め込まず、すぐにファイルに書き込む設定
export PYTHONUNBUFFERED=1


# talker, listener は10秒経ったら強制終了する、ROS2の設定を読み込んでから実行するように
timeout 10 bash -c "source /opt/ros/humble/setup.bash; source install/setup.bash; ros2 run mypkg talker" > /tmp/talker.log 2>&1 &
timeout 10 bash -c "source /opt/ros/humble/setup.bash; source install/setup.bash; ros2 run mypkg listener" > /tmp/listener.log 2>&1 &

# 通信してメッセージがでるまで5秒待つ
sleep 5


# デバック用にログの中身を表示
echo "=== Listener Log Content ==="
cat /tmp/listener.log
echo "============================"

# listenerに 答え と出たら終了
grep '答え:' /tmp/listener.log
