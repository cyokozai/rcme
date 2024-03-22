# PXIシステムをLinuxで運用する

## Hello👋 > 💻:===:💻 < Hi👋

---

## はじめに

### PXIとは

> PXIはテストエンジニア用コンピュータです。これは、マルチスロットシャーシにコントローラと計測器を組み合わせたテストおよび計測用プラットフォームです。エンジニアはNI PXIを使用して、検証と製造テストのための高性能な複合測定システムを構築します。

つまり、OSを搭載した万能計測器。やばすぎ🤯

### 主な構成パーツ

- シャーシ

> シャーシはPXIシステムの基幹部分であり、PCの機械的な筐体およびマザーボードに相当します。これが電源、冷却、通信バスを提供し、計測器モジュールを同期します。シャーシのスロット数は4～18と種々のサイズがあり、ポータブル、ベンチトップ、ラックマウント、組み込みシステムなど、さまざまな用途とニーズに対応しています。

イメージとしては、デスクトップPCのマザーボードと筐体が一体化したようなもの。シャーシに各種コンポーネントを取り付けてカスタマイズできる。

- コントローラ

> PXIコントローラには、組込コントローラとリモートコントローラがあります。組込コントローラは、リモートコントローラでPXIシステムをデスクトップ、ノートブック、サーバコンピュータから制御できる一方、外部PCなしでPXIシステムを実行するのに必要なすべてが含まれています。ニーズに合ったコントローラを選択してください。組み込みコントローラは性能が高く、リモートコントローラはコストパフォーマンスが高くなります。

要はコンピュータ本体として機能する部分。ここには一般的なパソコン同様にCPU, RAM, Storage, NIC, Display Portなどの各インターフェースがひとつのコンポーネントとして提供される。ここだけなら本当にただのパソコン。

- モジュール

> NIでは、DCからミリ波まで、600以上の入出力PXIモジュールを提供しています。その中には、オシロスコープやデジタルマルチメータなどのモジュール式計測器が含まれます。オープンな業界規格であるPXIは、60社を超える計測器ベンダがおよそ1,500種類の製品を提供しています。

PXIシステムの計測器全般を指す。用途に応じて使い分けるっぽい。

---

## PXIシステムの概要

以降はPXIコントローラのことを単にPXIと表記します。（例: PXIにUbuntu 22.04をインストール）

- シャーシ:
  - PXIe-1092
- コントローラ:
  - PXIe-8862
- モジュール:
  - PXIe-4481
  - PXIe-5163
  - PXIe-6739
- OS:
  - Ubuntu Server 22.04 LTS
- NI Driver
  - [README(LTSはまだ出てない)](https://www.ni.com/pdf/manuals/ni-linux-device-drivers-2023-q3.html)
  - [インストール方法](https://www.ni.com/docs/ja-JP/bundle/ni-platform-on-linux-desktop/page/installing-ni-products-ubuntu.html)

---

## PXIにUbuntuをインストール

- Ubuntu Desktop/Serverのイメージをダウンロード
  [公式](https://jp.ubuntu.com/download)からLTS版をインストール
- ISOファイルをUSBに書き込んで起動USBを作成(Windows: rufus, Mac: Etchar)
- BIOSを開く（deleteキーで入れた）
  - BIOSで起動順序をUSBに変更
    ただしこれだけでは上手く起動できない
  - secure bootの項目をcustomからstandardに変更
    やはりセキュアブートは悪、滅ぶべし
- Ubuntuのインストーラが起動したら言う通りに基本セットアップをする
  ※ 最小インストールが望ましい
- 再起動し、起動USBを抜いてインストール完了

---

## NI DriverをUbuntuにセットアップ

別に手動でやるような作業じゃないから...気が向いたらshell書いておきます。

- `sudo apt -y update`, `sudo apt dist-upgrade`を実行して最新版のカーネルにアップデート
- `reboot`で再起動
- `sudo apt install ./filename.deb`を実行してリポジトリ登録パッケージをインストール
  ※ filename.debは任意のパッケージを使用
- `sudo apt -y install filename`で使用するNIドライバをインストール
- `reboot`で再起動

---

## Ubuntuのネットワーク設定

基本的にはUbuntu Serverを構築する時と変わらない。サクサク進めよう！

### まずはじめにnetplanあり

- 基本はここから、PXIのIPアドレスをDHCPから固定に変更する
- 必要なツールのインストール
  最小インストールはvimやnanoなどのテキストエディタすら入っていないのだ！

  ```bash
  sudo apt -y install inetutils-ping &&\
  sudo apt -y install netcat &&\
  sudo apt -y install tcpdump &&\
  sudo apt -y install ufw &&\
  sudo apt -y install nano # vim
  ```

- `sudo nano /etc/netplan/00-installer-config.yaml`でUbuntuのネットワーク設定を行う（viでも可）
- 以下の設定を行う（$X, Y \in \mathbb{N} \ | \ 1 < X < 256, 1 < Y < 256$）
  
  ```yaml
  network:
  ethernets:
    eno0:
      dhcp4: true
      dhcp6: false
    eno1:
      dhcp4: false
      dhcp6: false
      addresses:
      - 192.168.X.Y/24
      nameservers:
        addresses: []
        search: []
  version: 2
  ```

- 編集内容を保存したら`sudo netplan apply`を実行して変更を適用する

### OpenSSHでリモート接続できるようにしちゃおう

PXIに対して別のパソコンからSSHを用いてリモート接続できるようにします。
まあ、ローカルで使うならあまり必要ない機能なのでここは飛ばしていいです。

### ncとtcpdampでいい感じにやりとりできないかな

---

## デーモンを使った同期/非同期式による処理

### systemdにNIデバイスを用いたpythonコードの実行を自動化させる

1. bashとpythonを使用した実行
2. 2台のサーバ（GPUサーバとPXIシステム）を一本の線（LAN、SFT）で接続
3. systemdにデーモンを登録 - [参考リンク](https://qiita.com/DQNEO/items/0b5d0bc5d3cf407cb7ff)

---

## ansibleで自動セットアップまでできたらいいな
