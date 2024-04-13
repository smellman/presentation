---
marp: true
theme: default
footer: 'OSC 2023 Fukuoka LT'
paginate: true
---

# makeを使った講義を実施してみた

Taro Matsuzawa (@smellman)
JUS / OSGeo.JP / OSMFJ
https://smellman.hatenablog.com/

---

# 自己紹介

- GISエンジニア
- 日本UNIXユーザ会副会長
- OSGeo.JP理事
- OpenStreetMap Foundation Japan理事
- Breakcoreクラスタ
- 今年はコソボと韓国に行きました

![bg right 80%](https://i.imgur.com/ntziIEx.png)

---

# 今日のお話

国土地理院でのJICAの研修でmakeを使った講義を実施してみた

---

# JICAの研修

- JICAでは海外から研修生を招いて研修を実施している
- 僕は毎年Web地図の講義を担当

---

# 今回の研修

- Raspberry Piを使ってWeb地図を作る
  - 以前はWindows + Docker Desktopを使ったが、HWから仮想化がオフになっていたりトラブルがあった
  - Linuxを動かす環境はやはり欲しい
  - ちょうど国土地理院でRaspberry Piを運用していた
- そのために、makeを使った講義を実施してみた

---

# Raspberry Pi

![](https://i.imgur.com/2wTGQFy.jpg)

---

# 講義の様子

![](https://i.imgur.com/i8cIMJo.jpg)

---

# 講義内容


- Raspberry Pi 4 に各自ログインして必要なコマンドなどを一式インストール
- Tileという仕組みについての講義
- Mapbox GL JSは良いソフトだけどプロプライエタリなのでMapLibre GL JSをお勧めするという一連の儀式(何
- gdal2tiles.pyを使ったラスタタイルの変換
- tippecanoeを使ったベクトルタイルの変換
- Charitesを使ったベクトルタイルのスタイリング
- Webホスティングについての注意点などの紹介、IPFSの紹介と実践


---

# やってみたこと

- 環境セットアップを全部makeでやってみた
- 講義の各プロセスをmakeで実行してみた

---

# 環境セットアップ

```bash
sudo apt install -y git make
git clone https://github.com/smellman/jica_scripts.git
cd jica_scripts/system
sudo HOME=$HOME USER=$USER make install
```

---

# 講義の各プロセス

```bash
cd ~/jica_scripts/raster_tile_gm
make fetch # Download GeoTIFF file from Global Map archive.
make transparent # Enable transparency.
make generate_tile # Convert GeoTIFF to XYZ tile using gdal2tiles.
make serve # run nginx
```

---

# はまりどころ、課題

- Ctrl+Cで止めるなどを知らないのでその説明が必要だった
- Makefileの読み方は解説しているけど、実際に読むのは難しい
  - less, catなどのコマンドも紹介しないといけない
- nanoの編集が難しい
  - とはいえvimはもっと難しいので、nanoで我慢してもらう

---

# まとめ

- makeを使った講義を実施してみた
- はまりどころ、課題があった
- でも、makeを使った講義は面白いと思う
- 来年もmakeでやるぞ！
