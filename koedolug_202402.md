---
marp: true
theme: default
footer: 'KoedoLUG 2024/02'
paginate: true
---

# Thinkpad E14 Gen4にUbuntu Studioをインストール

## Taro Matsuzawa ([@smellman](https://twitter.com/smellman))

### KoedoLUG 2024/02

---

# 自己紹介

- Georepublic Japan GIS Engineer
- Sub-President, Japan UNIX Society
- Director, OSGeo.JP
- Director, OpenStreetMap Foundation Japan
- Lead of United Nation OpenGIS/7 core
- Breakcore cluster

![bg right 80%](https://i.imgur.com/ntziIEx.png)

---

# 経緯

- Thinkpad X220を使っていたが、そろそろ限界
- 睡眠薬飲んで、酩酊している時にThinkpad E14 Gen4を買ってしまった
- とりあえず、音楽作成をしてみたいと思っていたのでUbuntu Studio 23.10を入れてみた

---

# Thinkpad E14 Gen4

- CPU: AMD Ryzen 7 7730U with Radeon Graphics
- Memory: 8GB + 32GB
  - 8GBは固定、32GBは増設
- Storage: Kioxia 2TB SSD
  - 元のストレージは外して、2TBのSSDを増設

![bg right 80%](https://i.gyazo.com/thumb/3024/0a56bd82580d5e90b51f44830e567a98-heic.jpg)

---

# Ubuntu Studio 23.10

- KDE Plasma をベースにしたデスクトップ環境
- オーディオ、ビデオ、画像、グラフィックスなどのアプリケーションがプリインストールされている
- カーネルはlowlantencyカーネルが使われている
- 現在のメイン用途はLinux上での開発
  - 音楽作成どこいった...
  - いちおうRenoiseはインストール済み
  - USB Audio Interfaceの動きが怪しい

---

# 主なパッケージなど

- Renoise
- Fcitx + SKK
- Firefox & Thunderbird
- VSCode
- Google Chrome (仕事のアカウント用)
- Slack(deb版)

---

# 入れなかったもの

- Zoom
  - ibusに依存しているため、Fcitxとの共存が難しい

---

# はまりどころ

- snapで配布しているパッケージが多いが、日本語入力周りが怪しいソフトが多い
  - とりあえず、deb版を使うことが多い
  - ex: Slack
- HDMI出力がうまくいかない
  - $HOME/.localを削除したら治ったが、原因は不明
  - とりあえず、HDMI出力は使わないことにした
    - .localを消すと色んなものが消えるので注意

---

# 使ってみて

- とりあえず、開発環境としては満足
  - amd64なDocker環境が欲しかったので、これは大きい
- 音楽作成環境はまだまだ
- アプリケーションのスイッチングがまだ慣れてない
  - Desktop単位でのスイッチングなのでmacOSのようにアプリケーション単位でのスイッチングができないのが不便
    - KDE Plasmaは使いやすい
- Emacsキーバインドが動かない
  - 地味に辛い
