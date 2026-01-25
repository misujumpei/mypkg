#!/usr/bin/env python3
# SPDX-FileCopyrightText: 2026 misujumpei
# SPDX-License-Identifier: BSD-3-Clause

import rclpy                     # ROS 2の基本ライブラリ
from rclpy.node import Node      # rclpyの中からNodeを取り出す
from std_msgs.msg import String   # 標準的なメッセージの型を読み込む


class QuizListener(Node):   # Nodeクラスから受信者を作成
    def __init__(self):
        super().__init__('listener')  # ノード名を 'listener' に設定

        
        # 書式: create_subscription(型, トピック名, コールバック関数, キューサイズ)
        self.sub = self.create_subscription(String, 'prefecture_topic', self.cb, 10)
