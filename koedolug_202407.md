---
marp: true
theme: default
footer: 'KoedoLUG 2024/07'
paginate: true
---

# 2024/07 KoedoLUG 定期報告

## Taro Matsuzawa ([@smellman](https://twitter.com/smellman))

### KoedoLUG 2024/07

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

- Googleのソフトウェアエンジニアリング
- Beginning PyQt
- Prometheus: Up & Running, 2nd Edition

実質積ん読

---

## 活動報告 2024/07

- Planetiler でOverture Mapsのインポート
- Redmine good_job プラグインの作成
- OSC 2024 Hokkaido に出展
- OSGeo.JP の運営

---

## Planetiler でOverture Mapsのインポート

- [Planetiler-example](https://github.com/onthegomap/planetiler-examples) で [Overture Maps](https://docs.overturemaps.org/release/latest/) のインポートに対応したのでやってみた。
  - 400GBのデータをインポートするのに3時間ほどで完了
  - java22が必須なので注意
  - PMTilesは https://tile.openstreetmap.jp/static にて公開中
  
---

## Redmine good_job プラグインの作成

- Redmineのジョブ管理がデフォルトでは安定しない
  - メールが不通になるなど不具合があった
- PostgreSQL専用のジョブ管理、[good_job](https://github.com/bensheldon/good_job)をredmineに簡単に入れれるようにした
- [Redmine good_job](https://github.com/gtt-project/redmine_good_job)
- 使い方はREADMEに書いてある

---

## OSC 2024 Hokkaido に出展

- [OSC 2024 Hokkaido](https://event.ospn.jp/osc2024-do/) にOpenStreetMap Japanとしてブースを出展
  - MapLibre GL JSの[sky APIを使ったデモ](https://github.com/smellman/aws-terrain)
  - [OSM Sound demo](https://smellman.github.io/osm-sound-demo/)

![bg right 80%](https://i.gyazo.com/e982b4eb98c186603a748fdf504a01b3.jpg)

---

## OSGeo.JP の運営

- もくもく会を開催
  - [OSGeo.JP](https://osgeo.jp/) でもくもく会を開催
  - 6/22 テーマ: 公共交通
  - 7/20 テーマ: OpenStreetMap
- FOSS4G Japan 2024の実行委員長になりました
- イベント情報は随時HPにて更新中

---

## その他

- 応用情報落ちました
- 英会話サボってたら英会話学校から直電がかかってきてびびった
- 老眼が始まった気がする

---

## 今後の予定

- 7/20 OSGeo.JP FOSS4Gもくもく会 #004
- 8/2-6 Coscup 2024
  - 8/3に登壇
- 8/7 なんかやります(今日発表予定)
- 8/8-12 三宅島 (一日早くなった)
- 8/23-24 FOSS4G Tokai 2024
- 9/6-8 State of the Map 2024
  - ケニアのナイロビで開催