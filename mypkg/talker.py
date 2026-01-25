#!/usr/bin/env python3
# SPDX-FileCopyrightText: 2026 misujumpei
# SPDX-License-Identifier: BSD-3-Clause

import rclpy                      # ROS 2の基本ライブラリ
from rclpy.node import Node       # rclpyの中からNodeを取り出す
from std_msgs.msg import String   # 標準的なメッセージの型を読み込む 
import random                     # 乱数を生成する


class Quiz(Node):   #クラスの定義
    def __init__(self):
        super().__init__('talker') # ノード名を 'talker' に設定

        # トピック名: prefecture_topicでパブリッシャーの作成
        self.pub = self.create_publisher(String, 'prefecture_topic', 10)

        # クイズのリスト（47都道府県）
        self.prefectures = [
            "北海道", "青森県", "岩手県", "宮城県", "秋田県", "山形県", "福島県",
            "茨城県", "栃木県", "群馬県", "埼玉県", "千葉県", "東京都", "神奈川県",
            "新潟県", "富山県", "石川県", "福井県", "山梨県", "長野県", "岐阜県",
            "静岡県", "愛知県", "三重県", "滋賀県", "京都府", "大阪府", "兵庫県",
            "奈良県", "和歌山県", "鳥取県", "島根県", "岡山県", "広島県", "山口県",
            "徳島県", "香川県", "愛媛県", "高知県", "福岡県", "佐賀県", "長崎県",
            "熊本県", "大分県", "宮崎県", "鹿児島県", "沖縄県"
        ]

        # タイマーの設定（3.0秒ごとに実行） 
        self.timer = self.create_timer(3.0, self.timer_callback)


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
