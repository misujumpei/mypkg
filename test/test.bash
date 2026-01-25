#!/bin/bash
# SPDX-FileCopyrightText: 2026 misujumpei
# SPDX-License-Identifier: BSD-3-Clause

cd /root/ros2_ws
colcon build
source /opt/ros/humble/setup.bash
source install/setup.bash
export PYTHONUNBUFFERED=1

timeout 10 bash -c "source /opt/ros/humble/setup.bash; source /root/ros2_ws/install/setup.bash; ros2 run mypkg talker" > log.txt 2>&1 &
timeout 10 bash -c "source /opt/ros/humble/setup.bash; source /root/ros2_ws/install/setup.bash; ros2 run mypkg listener" >> log.txt 2>&1 &

sleep 8
cat log.txt
grep '答え' log.txt
