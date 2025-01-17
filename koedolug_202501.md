---
marp: true
theme: default
footer: 'KoedoLUG 2025/01'
paginate: true
backgroundColor: #fff
backgroundImage: url('https://marp.app/assets/hero-background.svg')
---

# 2025/01 KoedoLUG 定期報告

## Taro Matsuzawa ([@smellman](https://x.com/smellman))

https://smellman.hatenablog.com/

### KoedoLUG 2025/01

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

## 今日のお題

- 年末に読んだ本
- 年末の活動とか
- コントリビューションとか
- 今後の予定

---

## 年末に読んだ本

- Tidy First?
- GitLabに学ぶ 世界最先端のリモート組織のつくりかた
- GitLabに学ぶ パフォーマンスを最大化させるドキュメンテーション技術
- みんなの高校地学
- データ可視化の基本が全部わかる本

---

## Tidy First?

- Kent Beckの本
- 個人がいつ「コードを整頓するか」にフォーカスを当てた一冊
- 値段に比べて分量がちょっと少なすぎる気がする

![bg right 80%](https://www.oreilly.co.jp/books/images/picture_large978-4-8144-0091-1.jpeg)

---

## GitLabに学ぶ 世界最先端のリモート組織のつくりかた

- GitLab Handbookという公に出ているコンテンツをベースにリモート組織をどうつくっていくかという視点からGitLabの実例を元に解説しまくるという本
- 会社としてどうリモートっていうものに対応していくかっていう良い指針になる本

![bg right 80%](https://www.seshop.com/static/images/product/25794/L.png)

---

## GitLabに学ぶ パフォーマンスを最大化させるドキュメンテーション技術

- ドキュメンテーション技術とありますが、単なるライティングだけでなく組織のカルチャーと深く結びついたドキュメンテーション技術という感じ
- これもGitLab Handbookを元にしているので、GitLabの文化を知るためにも良い本

![bg right 80%](https://www.seshop.com/static/images/product/26594/L.png)

---

## みんなの高校地学

- 序章の「日本列島と巨大地震」から始まり、最後は宇宙の始まりについてと幅広い地学の世界を学ぶことができる。
- 地震や台風などの身近な自然現象を科学的に理解することができる

![bg right 80%](https://cv.bkmkn.kodansha.co.jp/9784065377970/9784065377970_obi_w.jpg)

---

## データ可視化の基本が全部わかる本

- データ可視化について何から学んでいけばよいかという良い指針となる本で、新しい知見がたくさんあった
- 特に色の選び方だけでちゃんと章があって、いままでなんとなく色を選んでいたんだなというのに気づかされて、大変学びが多かった
- 学術的な解説が多いため、ちょっと難易度は高いかも

![bg right 80%](https://www.seshop.com/static/images/product/26393/L.png)

---

## 年末の活動とか

- OpenStreetMapでくそでかいSVGを作るツールを作った
- maplibre-react-nativeで作るトイレマップと実装
- Overture Maps 2024-12-18.0をPMTilesにコンバート
- PG-StromのDocker imageを作成
- QGIS mac build for qt6を開始

---

## OpenStreetMapでくそでかいSVGを作るツールを作った

- OpenStreetMapでたまにデカいSVGを作りたい時がある
  - 例えば、地図の一部を切り出して印刷したいとか
- そのためのツールをDocker + Pythonで作った

https://github.com/smellman/osm-mapnik-svg-render

---

## maplibre-react-nativeで作るトイレマップと実装

- 過去に書いた本でMapbox + React Nativeでトイレマップを作っていた
- 今回はそのmaplibre-react-nativeでの実装をやってみた
- 実機でもmaplibre-react-native v10.0.beta19で動作チェックができた
  - ちなみにv10.0.0は最近出たのでアップグレードが必要

https://github.com/smellman/ToiletMap-maplibre

---

## Overture Maps 2024-12-18.0をPMTilesにコンバート

- Overture Maps 2024-12-18.0が出ていたのでPMTilesにコンバートして https://tile.openstreetmap.jp/static にアップロードした
- Overture Mapsは450GBほどあるので大容量なストレージが必要
  - Kioxiaのデータセンター用ストレージを使用(詳細はキオクシアの同人誌vol.3を見てね)
- 処理時間は131m8.815sと二時間強かかりました

https://smellman.hatenablog.com/entry/2025/01/07/213222

---

## PG-StromのDocker imageを作成

- PG-StromはPostgreSQLの拡張機能で、GPUを使って高速にデータ処理を行うことができる
- OpenMapTilesで検証するためにとりあえずDocker imageを作成
  - 作成中にPG-StromがPostgreSQL 15に対応していない事を確認したので、アップストリームに連絡

https://github.com/smellman/pg-strom-docker-ubuntu

---

## QGIS mac build for qt6を開始

- QGISのmac buildがQt6に対応していないので、Qt6に対応するようなビルドシステムを作成開始
  - というかQGIS Projectが配布しているQt5がmacでもうビルドできなくなった
- とりあえずQt6のビルドと依存関係のビルドシステムとして動く所まではできた

https://github.com/smellman/qgis-with-qt6-mac

---

## コントリビューションとか

- PDALにPR送ってマージされた(ドキュメントの修正)
- OpenStreetMapを毎日描くようにしている
- Githubへのコミットも毎日している(案件もしくは個人プロジェクト)

---

## OpenStreetMap

- 2025年から毎日描いてる
  - 主に建物や道路を描いてる

https://hdyc.neis-one.org/?smellman

![bg right 80%](https://i.gyazo.com/bdcc2439aa995a669301e8fab81f31f7.png)

---

## Github

- 2025年から毎日コミットしている
  - 会社の仕事と個人プロジェクトがいりまじってる

https://github.com/smellman

![bg right 80%](https://i.gyazo.com/ba7d2f8c05848e928c311c6b06c89de8.png)

---

## 今後の予定

- 2025/01/23 - [地球とPython - こんなところにPythonが Vol.1](https://peatix.com/event/4259553)登壇
  - PythonではじめるGIS処理とFOSS4Gの世界というタイトルで発表
- 2025/02/14-15 - [State of the Map 2024](https://stateofthemap.jp/2024/) & [FOSS4G Hokkaido 2024](https://foss4g.hokkaido.jp/2024/)
  - 北海道でイベントスタッフをやってきます
- 2025/02/21-22 - [OpenSource Conference Tokyo/Spring](https://event.ospn.jp/osc2025-spring/)
  - 会社としてブースを出します
