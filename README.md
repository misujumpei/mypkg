# mypkg

[![test](https://github.com/misujumpei/mypkg/actions/workflows/test.yml/badge.svg)](https://github.com/misujumpei/mypkg/actions)

都道府県名から県庁所在地を導き出すROS 2パッケージです。

## トピック
* `/prefecture_topic` (型: `std_msgs/msg/String`)
  * 都道府県名(入力用)
* `/capital_topic` (型: `std_msgs/msg/String`)
  * 県庁所在地(出力用)

## ノード
### 1. `talker`
`/prefecture_topic` へランダムな都道府県名を3秒ごとにパブリッシュします。

### 2. `listener`
`/prefecture_topic` から都道府県名をサブスクライブし、対応する県庁所在地を `/capital_topic` へパブリッシュします。

## 実行例

### `listener` ノード単体の動作確認
**ターミナル1:**
まず、変換を行う `listener` ノードを起動して待機状態にします。

```bash
$ ros2 run mypkg listener
```

**ターミナル2 (外部からのデータ入力):**

```bash
$ ros2 topic pub --once /prefecture_topic std_msgs/msg/String "{data: '北海道'}"
```

**ターミナル3 (結果の確認)**

```bash
$ ros2 topic echo /capital_topic
data: '札幌市'
```

## テスト環境
* Ubuntu 22.04 LTS
* ROS 2 Humble Hawksbill
```bash
$ bash test/test.bash
```

## ライセンス
* このソフトウェアパッケージは、3条項BSDライセンスの下、再頒布および使用が許可されます。
* © 2026 misujumpei

このパッケージのコードの一部やディレクトリ構成は、千葉工業大学 ロボットシステム学（2025）の講義資料を参考にしています。
 * [千葉工業大学 ロボットシステム学（2025）の講義資料](https://github.com/ryuichiueda/slides_marp/tree/master/robosys2025)
