---
marp: true
theme: default
footer: 'KoedoLUG 2024/06'
paginate: true
---

# 2024/06 KoedoLUG 定期報告

## Taro Matsuzawa ([@smellman](https://twitter.com/smellman))

### KoedoLUG 2024/06

---

## 自己紹介

- Georepublic Japan GIS Engineer
- Sub-President, Japan UNIX Society
- Director, OSGeo.JP
- Director, OpenStreetMap Foundation Japan
- Lead of United Nation OpenGIS/7 core
- Breakcore cluster

![bg right 80%](https://i.imgur.com/ntziIEx.png)

---

## 最近読んでる本

- 入門eBPF
- Rustの練習帳
- プロになるJava

---

## 活動報告 2024/06

- 国交省 不動産情報ライブラリ Viewerの作成
- MapLibre GL JS へのコミット
- MapLibre Style Specへのコミット
- OSGeo.JP の運営
- OpenStreetMap Foundation Japan の運営

---

## 国交省 不動産情報ライブラリ Viewerの作成

- 国土交通省が出している不動産情報ライブラリがタイル形式でデータを出力しているのでその Viewer を作成しました
  - CORSを回避するためにProxyサーバを立てる必要があった
    - Proxy: https://github.com/smellman/reinfolib-proxy
    - Viewer: https://github.com/smellman/reinfolib-site
  - CORSは現状セキュリティ上の理由で無効化できないとのこと

---

## MapLibre GL JS へのコミット

- MapLibre GL JSにいくつかコミット
  - https://github.com/maplibre/maplibre-gl-js/pull/4098
    - ベンチマークプログラムへ引数で固有のstyleを渡すことができる機能にバグがあったので修正
  - https://github.com/maplibre/maplibre-gl-js/pull/4135
    - devDependencyにいらないものがあったので削除
- 他、WIPのものもあります

---

## MapLibre Style Specへのコミット

- MapLibre Style Specにも一つコミット
  -　https://github.com/maplibre/maplibre-style-spec/pull/670
    - システム固有のstringifyがあったのでそれを削除するコミット
    - 全部上書きしていいよということなので、大量のJSONをまるっと置き換え

---

## OSGeo.JP の運営

- もくもく会を開催
  - 第一回(2024/04/27)のテーマはQGIS
  - 第二回(2024/05/18)のテーマはJavaScriptライブラリ
  - 第三回(2024/06/22)のテーマは公共交通
    - https://osgeojp.connpass.com/event/320202/
- OSC 2024 Nagoyaに出展
  - デモ: https://smellman.github.io/osm-sound-demo/
- FOSS4G 2025招致ならず。

---

## OpenStreetMap Foundation Japan の運営

- ジオ展(2024/04/19)に参加
  - えぐいぐらい人が満杯でした
  - 翌日筋肉痛でOSunCに行けなかった
- tile.openstreetmap.jpの更新
  - OpenMapTiles 3.15ベースに更新

---

## その他

- たぶん、応用情報落ちました
  - 午前問題で失敗したっぽい
- Interface 誌に記事を書きました

![bg right 80%](https://interface.cqpub.co.jp/wp-content/uploads/MIF202407-scaled.jpg)

---

## 今後の予定

- 6/21 GTFSxOSGeo勉強会
- 6/22 OSGeo.JP もくもく会
- 6/24 OSGeo.JP 総会
- 6/29 OSC 2024 Hokkaido
- 8/3-4 Coscup 2024
- 8/10-12 三宅島
- 9/6-8 State of the Map 2024
  - ケニアのナイロビで開催