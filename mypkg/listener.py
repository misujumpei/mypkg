#!/usr/bin/env python3
# SPDX-FileCopyrightText: 2026 misujumpei
# SPDX-License-Identifier: BSD-3-Clause

import rclpy                     # ROS 2の基本ライブラリ
from rclpy.node import Node      # rclpyの中からNodeを取り出す
from std_msgs.msg import String  # 標準的なメッセージの型を読み込む


class QuizListener(Node):   # Nodeクラスから受信者を作成
    def __init__(self):
        super().__init__('listener')  # ノード名を 'listener' に設定

        # 書式: create_subscription(型, トピック名, コールバック関数, キューサイズ)
        self.sub = self.create_subscription(String, 'prefecture_topic', self.cb, 10)

        # 答え合わせ用のリスト
        self.answers = {
            "北海道": "札幌市", "青森県": "青森市", "岩手県": "盛岡市", "宮城県": "仙台市",
            "秋田県": "秋田市", "山形県": "山形市", "福島県": "福島市", "茨城県": "水戸市",
            "栃木県": "宇都宮市", "群馬県": "前橋市", "埼玉県": "さいたま市", "千葉県": "千葉市",
            "東京都": "新宿区", "神奈川県": "横浜市", "新潟県": "新潟市", "富山県": "富山市",
            "石川県": "金沢市", "福井県": "福井市", "山梨県": "甲府市", "長野県": "長野市",
            "岐阜県": "岐阜市", "静岡県": "静岡市", "愛知県": "名古屋市", "三重県": "津市",
            "滋賀県": "大津市", "京都府": "京都市", "大阪府": "大阪市", "兵庫県": "神戸市",
            "奈良県": "奈良市", "和歌山県": "和歌山市", "鳥取県": "鳥取市", "島根県": "松江市",
            "岡山県": "岡山市", "広島県": "広島市", "山口県": "山口市", "徳島県": "徳島市",
            "香川県": "高松市", "愛媛県": "松山市", "高知県": "高知市", "福岡県": "福岡市",
            "佐賀県": "佐賀市", "長崎県": "長崎市", "熊本県": "熊本市", "大分県": "大分市",
            "宮崎県": "宮崎市", "鹿児島県": "鹿児島市", "沖縄県": "那覇市"
        }

    def cb(self, msg):   # 呼び出し、中身を取り出す
        # メッセージが届いた時に実行される
        prefecture = msg.data
        capital = self.answers.get(prefecture, "不明")  # リストから答えを探す

        # 受信したクイズと答えを表示
        self.get_logger().info(f'受信したクイズ: {prefecture} -> 答え: {capital}')

def main():
    rclpy.init()  
    node = QuizListener()
    rclpy.spin(node)  # データが届くまで待ち続ける
    node.destroy_node()
    rclpy.shutdown()

if __name__ == '__main__':
    main()
