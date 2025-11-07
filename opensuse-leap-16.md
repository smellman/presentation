---
marp: true
theme: default
footer: 'OpenSUSE Leap 16.0 リリースイベント'
paginate: true
backgroundColor: #fff
backgroundImage: url('https://marp.app/assets/hero-background.svg')
---

# OpenSUSE Leap 16.0をUTMにインストール

## Taro Matsuzawa ([@smellman](https://x.com/smellman))

https://smellman.hatenablog.com/

---

## 自己紹介

- Geolonia GIS Engineer
- Sub-President, Japan UNIX Society
- Director, OSGeo.JP
- Director, OpenStreetMap Foundation Japan
- Lead of United Nation OpenGIS/7 core
- 東京電機大学卒、CySec修了生
- Breakcore cluster

![bg right 80%](https://i.gyazo.com/d8daf8386e6c30b8f5c9c845dd527760.png)

---

## なんかバズりました

![X](https://i.gyazo.com/327540b98cfe2a58b6558bed43d53101.jpg)

---

## 所有マシン

- MacBook Air 2021, Apple M1 / macOS Tahoe
- ThinkPad E14 Gen 5 AMD / Ubuntu Studio 25.10
- 自作マシン / Debian sid
- MINIS FORUM の古いやつ / Windows 11
- Raspberry Pi 4GB / Raspberry Pi OS

## 会社のマシン

- MacBook Pro 2023, Apple M2 Pro / macOS Tahoe
- MINIS FORUM MS-S1 MAX / Debian trixie <- New!

---

## 本日のお題

- UTMとは
- インストール方法
- 基本的な設定

---

## UTMとは

- macOS向けの仮想化ソフトウェア
- QEMUをベースにしており、ARM64および様々なアーキテクチャをサポート
- 無料で利用可能

---

## インストール方法

1. UTMのダウンロードとインストール
2. OpenSUSE Leap 16.0のISOイメージのダウンロード
3. 新しい仮想マシンの作成
4. 仮想マシンの設定
5. OpenSUSE Leap 16.0のインストール

ソフトウェアのところで何も選ばなかったので、最小構成でインストールされた

---

## KDE Plasmaのインストール

```bash
sudo zypper install -t pattern kde
sudo reboot
```

---

## KDEの設定

スクロール方向を反転させる

![設定画面](https://i.gyazo.com/02a38dae8322423348b94cdfdb6b7f6b.png)

---

## SKKをインストール

```bash
sudo zypper install fcitx5-skk
sudo fcitx5-config-qt
```

ここでSKKを有効化

![fcitx5-config-qt](https://i.gyazo.com/69b997dfd9dcf196f1fb0e0ccba59fd1.png)

---

## QGISをインストール

```bash
sudo zypper install qgis
```

教育の所にQGISが入る

![QGIS](https://i.gyazo.com/0bb25e6587ae14b3e855c97584a02349.png)

---

## おまけ

- `/tmp`がtmpfsになっているので、ディスクに変更したい場合
  - Debianでも同じ処理をいつもやってる

```bash
sudo systemctl mask tmp.mount
sudo reboot
```

---

## うれしかったこと

- QGISが簡単に導入できた。
- gdalコマンドも最新のものが入った。
  - (Geo)Parquet(Apache Arrow)はまだサポートされてなかったので今後のアップデートに期待
