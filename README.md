# mypkg
 ロボットシステム学授業用課題2。やり直しました。
 ROS 2を用いて、47都道府県の県庁所在地クイズを出題・回答するパッケージです。

 出題者（talker）がランダムに都道府県名を送信し、回答者（listener）がそれを受信して県庁所在地を答えます。

## インストールとビルド方法
 ROS 2のワークスペース（`~/ros2_ws/src`）にリポジトリをクローンし、ビルドを行います。

```bash
cd ~/ros2_ws/src
git clone [https://github.com/misujumpei/mypkg.git](https://github.com/misujumpei/mypkg.git)
cd ~/ros2_ws
colcon build --symlink-install
source install/setup.bash
```

## 実行方法
 ターミナルを2つ開き、それぞれのノードを実行することで通信を開始します。

### 1. 回答者（Listener）の起動
 まず、回答側のノードを立ち上げて待機させます。
 ```bash
 cd ~/ros2_ws
. install/setup.bash
ros2 run mypkg listener
 ```

### 2. 出題者（Talker）の起動
別のターミナルで、出題側のノードを立ち上げます。
```bash
cd ~/ros2_ws
. install/setup.bash
ros2 run mypkg talker
```

## 実行結果の例
 通信が確立すると、listener側のターミナルに以下のようなログが表示されます。 Talkerからは3秒ごとに新しい問題が出題されます。
 ```bash
 [INFO] [1769319531.805915687] [listener]: 受信したクイズ: 神奈川県 -> 答え: 横浜市
 [INFO] [1769319534.788449511] [listener]: 受信したクイズ: 北海道 -> 答え: 札幌市
 [INFO] [1769319537.790004609] [listener]: 受信したクイズ: 沖縄県 -> 答え: 那覇市
 ...
 ```
## テストの実行
 本パッケージには自動テストが含まれています。
 ```bash
 colcon test --packages-select mypkg
 colcon test-result --all --verbose
 ```

## ノードの仕様
### talker (出題者)
* **トピック名**: `prefecture_topic`
* **メッセージ型**: `std_msgs/msg/String`
* **動作**:
    * 47都道府県のリストからランダムに1つを選択します。
    * 3.0秒ごとにトピックへ送信します。

### listener (回答者)
* **トピック名**: `prefecture_topic`
* **メッセージ型**: `std_msgs/msg/String`
* **動作**:
    * メッセージを受信すると、内部の47都道府県リストを参照します。
    * 対応する県庁所在地をログに出力します。


## テスト環境
 以下の環境で動作確認を行っています。

 Ubuntu 22.04 LTS

 ROS 2 Humble Hawksbill

 Python 3.10

## ライセンス
 このソフトウェアパッケージは，3条項BSDライセンスの下，再頒布および使用が許可されます．

 © 2026 misujumpei

 このパッケージのコードの一部やディレクトリ構成は、千葉工業大学 ロボットシステム学（2025）の講義資料を参考にしています。
 * [千葉工業大学 ロボットシステム学（2025）の講義資料](https://github.com/ryuichiueda/slides_marp/tree/master/robosys2025)
