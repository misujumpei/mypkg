#!/bin/bash
# SPDX-FileCopyrightText: 2026 misujumpei
# SPDX-License-Identifier: BSD-3-Clause

set -e

source /opt/ros/humble/setup.bash
cd $(dirname $0)/../..
colcon build --packages-select mypkg
source install/setup.bash

export ROS_LOG_DIR=/tmp/ros_log
mkdir -p /tmp/ros_log

export PYTHONUNBUFFERED=1

timeout 15 ros2 run mypkg region_publisher > /tmp/region_publisher.log 2>&1 &
timeout 15 ros2 run mypkg city_resolver > /tmp/city_resolver.log 2>&1 &

sleep 20

echo "--- Publisher Log ---"
cat /tmp/region_publisher.log
echo "--- Resolver Log ---"
cat /tmp/city_resolver.log

grep -E '市|区' /tmp/city_resolver.log
