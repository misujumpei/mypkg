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

echo "---  起動テスト (5秒) ---"
export PYTHONUNBUFFERED=1
timeout 5 ros2 run mypkg talker > /tmp/test.log 2>&1
# timeoutは終了時に124というコードを出すので、ここでは中身があるかだけ確認
[ -s /tmp/test.log ] && echo "Execution OK"

echo "--- 文字のチェック ---"
# 中身を全部表示
cat /tmp/test.log
# 「問題　」という文字があるか探して、あれば成功とする
grep '問題' /tmp/test.log && echo "Final Result: ALL OK"
