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

    def cb(self, msg):   # 呼び出し、中身を取り出す
        # メッセージが届いた時に実行される
        self.get_logger().info(f'受信したクイズ: {msg.data}')

def main():
    rclpy.init()  
    node = QuizListener()
    rclpy.spin(node)　　# データが届くまで待ち続ける
    node.destroy_node()
    rclpy.shutdown()

if __name__ == '__main__':
    main()
