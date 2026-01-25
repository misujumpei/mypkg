#!/usr/bin/env python3
# SPDX-FileCopyrightText: 2026 misujumpei
# SPDX-License-Identifier: BSD-3-Clause

import rclpy                     # ROS 2の基本ライブラリ
from rclpy.node import Node      # rclpyの中からNodeを取り出す
from std_msgs.msg import String  # 標準入力から文字列を読み込む
import random                    # 乱数を生成する


class Quiz(Node):   #クラスの定義
    def __init__(self):
        super().__init__('talker') # ノード名を 'talker' に設定

        # トピック名: prefecture_topicでパブリッシャーの作成
        self.pub = self.create_publisher(String, 'prefecture_topic', 10)

        # クイズのリスト
        self.prefectures = ["千葉県", "東京都", "神奈川県", "埼玉県", "茨城県", "栃木県", "群馬県"]

        # タイマーの設定（1.0秒ごとに実行）
        self.timer = self.create_timer(1.0, self.timer_callback)


    def timer_callback(self):
        msg = String()  
        msg.data = random.choice(self.prefectures)  # リストからランダムに県名を選ぶ
        self.pub.publish(msg)   # 送信

        # 自分の画面にも何を送ったかログを出す
        self.get_logger().info(f'問題：{msg.data}の県庁所在地は？')

def main():
    rclpy.init()    # 初期化
    node = Quiz()   # 実体化
    rclpy.spin(node)  #（Ctrl+C）が入力されるまで継続
    node.destroy_node()
    rclpy.shutdown()  # 終了

if __name__ == '__main__':  # talker.pyが直接実行された時だけ関数を動かす
    main()
