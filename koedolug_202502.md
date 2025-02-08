---
marp: true
theme: default
footer: 'KoedoLUG 2025/02'
paginate: true
backgroundColor: #fff
backgroundImage: url('https://marp.app/assets/hero-background.svg')
---

# 2025/02 KoedoLUG 定期報告

## Taro Matsuzawa ([@smellman](https://x.com/smellman))

https://smellman.hatenablog.com/

---

## 自己紹介

- Georepublic Japan GIS Engineer
- Sub-President, Japan UNIX Society
- Director, OSGeo.JP
- Director, OpenStreetMap Foundation Japan
- Lead of United Nation OpenGIS/7 core
- 東京電機大学卒、CySec修了生
- Breakcore cluster

![bg right 80%](https://i.imgur.com/ntziIEx.png)

---

## 今日のお題

- 最近のネタ
- 活動とか
- コントリビューションとか
- 今後の予定

---

## 最近のネタ

- [FOSS4G 2026 Hiroshima開催決定](https://www.osgeo.jp/archives/4501)
  - Globalカンファレンスが広島で開催されることになりました
- [国土数値情報のファイル形式に関する意見募集](https://www.mlit-gis-lab.jp/ksj/)
  - Shapefile must die!
- [UTMにKali Linux 2024.4をインストール](https://smellman.hatenablog.com/entry/2025/01/16/032845)
  - macOSでもKali Linuxが使えるようになった

---

## 活動とか

- MapLibreのsnippetを作るツールを作成
- MapLibreのiframe表示用サイトを作成
- Overture Maps 2025-01-22.0をPMTilesにコンバート
- QGIS mac build for qt6を中止
- 地球とPython - こんなところにPythonが Vol.1 登壇
- OpenTopoMap MapLibre

---

## MapLibreのsnippetを作るツールを作成

- GUIで簡単にsnippetを作成できるツールを作成
- 作成したsnippetはCodepenなどで確認できる
- iframeでも使う事ができる(後述)

https://smellman.github.io/generate-maplibre-snippet/

---

## MapLibreのiframe表示用サイトを作成

- 前述のサイトからiframeで表示する専用のサイトを作成
- Query Stringからstyleなどを変更できる

https://smellman.github.io/embed-maplibre/

---

## Overture Maps 2025-01-22.0をPMTilesにコンバート

- Overture Maps 2025-01-22.0が出ていたのでPMTilesにコンバートして https://tile.openstreetmap.jp/static にアップロードした
- Overture Mapsは450GBほどあるので大容量なストレージが必要
  - Kioxiaのデータセンター用ストレージを使用(詳細はキオクシアの同人誌vol.3を見てね)

---

## QGIS mac build for qt6を中止

- QGISのmac buildがQt6に対応していないので、Qt6に対応するようなビルドシステムを作成開始したのだが
- 本家が対応し始めたので中止
  - 良かった

https://github.com/qgis/QGIS/pull/60039

---

## 地球とPython - こんなところにPythonが Vol.1 登壇

- 1/23に登壇
- PythonでGIS処理をするときに使うライブラリやFOSS4Gについて話した

https://www.docswell.com/s/smellman/K22W6M-2025-01-23-python-gis-foss4g

---

## OpenTopoMap MapLibre

- OpenTopoMapというサイトの(古い)スタイルがあったのでMapLibreに移植
  - Contour Pluginを使って標高を表示するようにした

https://smellman.github.io/opentopomap-maplibre/

---

## コントリビューションとか

- OpenStreetMapを毎日描くようにしている
- Githubへのコミットも毎日している(案件もしくは個人プロジェクト)

---

## OpenStreetMap

- 2025年からだいたい毎日描いてる
  - 主に建物や道路を描いてる

https://hdyc.neis-one.org/?smellman

![bg right 80%](https://i.gyazo.com/14b171ed0b62b028ba959c071c226954.png)

---

## Github

- 2025年からだいたい毎日コミットしている
  - 会社の仕事と個人プロジェクトがいりまじってる
![github](https://i.gyazo.com/cf3aaaffb072a66fe152bf1cc1500423.png)

---

## 今後の予定

- 2025/02/14-15 - [State of the Map 2024](https://stateofthemap.jp/2024/) & [FOSS4G Hokkaido 2024](https://foss4g.hokkaido.jp/2024/)
  - 北海道でイベントスタッフをやってきます
- 2025/02/21-22 - [OpenSource Conference Tokyo/Spring](https://event.ospn.jp/osc2025-spring/)
  - 会社としてブースを出します
