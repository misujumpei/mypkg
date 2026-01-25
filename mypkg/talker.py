#!/usr/bin/env python3
# SPDX-FileCopyrightText: 2026 misujumpei
# SPDX-License-Identifier: BSD-3-Clause

import rclpy                     # ROS 2の基本ライブラリ
from rclpy.node import Node      # rclpyの中からNodeを取り出す
from std_msgs.msg import String  # 標準入力から文字列を読み込む
import random                    # 乱数を生成する
