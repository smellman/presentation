---
marp: true
theme: default
footer: '地球とPython - こんなところにPythonが Vol.1'
paginate: true
backgroundColor: #fff
backgroundImage: url('https://marp.app/assets/hero-background.svg')
---

# PythonではじめるGIS処理とFOSS4Gの世界

## Taro Matsuzawa ([@smellman](https://x.com/smellman))

### 地球とPython - こんなところにPythonが Vol.1

---

## 自己紹介（1）

- Georepublic Japan GIS Engineer
- 日本UNIXユーザ会副会長
- OSGeo.JP理事
- OpenStreetMap Foundation Japan理事
- Lead of United Nation OpenGIS/7 core
- Breakcore cluster

![bg right 80%](https://i.imgur.com/ntziIEx.png)

---

## 自己紹介（2）

- 本業はGISエンジニア
  - Python/Ruby on Rails/Typescript/React Nativeなどでインフラからフロントエンドまで面倒を見ています
  - Rust/Java/Swiftもちょっと書ける
- [Lobsta](https://www.lobsta.jp/)というサービスをやっています
  - Redmine+位置情報プラグインという仕組み

---

## Python歴

- 2000年ごろPython 1.x時代から触っている
  - 2002年: バイト先でユーティリティをPython+Visual Basic 6で書く
  - 2004年: 大学の卒検をPythonで実装
- しばらくは趣味で使っていた
- 2012年(現職)から仕事でもPythonも使うようになる
  - 2022年: 国土地理院業務でSAR衛星データ解析のサーバでPythonを利用

---

## 書いた本

- React Native＋Expoではじめるスマホアプリ開発
  - 内容が古すぎるので**絶対に**買わないでください。
- 他にもFirefox Hacks Rebooted(O'Reilly Japan)など
- キオクシアの同人誌にも寄稿しています。

![bg right 80%](https://book.mynavi.jp/files/topics/92636_ext_06_0.jpg)

---

## 本日のお話

- 関連書籍のご紹介
- GISとは
- PythonでのGIS処理
- FOSS4Gの世界
- QGISの紹介
- Python以外の言語でのGIS処理

---

## 本日の関連書籍 (1)

- 位置情報エンジニア養成講座
  - 入門として最適な一冊
  - クライアントサイドのコードなどを紹介している

![bg right 80%](https://www.shuwasystem.co.jp//images/book/622507.jpg)

---

## 本日の関連書籍 (2)

- 位置情報デベロッパー養成講座
  - 開発者向けに最適な一冊
  - サーバサイドのコードなどを紹介している
  - ちなみに査読しました

![bg right 80%](https://www.shuwasystem.co.jp//images/book/651631.jpg)

---

## GISとは

- Geographic Information Systemの略
  - 日本語では地理情報システムと呼ばれている
- 代表的なソフトウェア
  - QGIS(OSS)
  - ArcGIS(商用ソフト)
  - GRASS GIS(OSS)

---

## GIS処理の種類

- ラスタデータの処理
  - 標高データ
  - 衛星/航空写真データ
- ベクタデータの処理
  - 点データ
  - 線データ
  - 面データ
- 点群の処理
  - LiDARデータ

だいたいこの6つぐらいを押さえておけばOK

---

## ラスタデータの処理の例

- 標高を含むGeoTiffファイルを読み込んで、標高タイルを作成する
- 衛星データ(SAR)を解析して、地球の変動を観測する

---

## GeoTiffとは

- 地理情報を含むTIFFファイルのこと
- 標高データの場合、高さの情報がTIFFの1pxごとに格納されている
- 例えば、標高が1000mの場合、1000という値が格納されている
- 単一のデータを持つものはグレースケールのTIFFとして扱われる(標高データなど)
- 3つのデータを持つものはRGBのTIFFとして扱われる(衛星データなど)

---

## タイルとは

- 画像データやベクトルデータを分割して格納仕組み
- 例えば、地図データをズームレベルごとに分割して格納する
  - Google MapsやOpenStreetMapなど
  - 1つの画像タイルは256px x 256pxが一般的
  - 画像データの場合、JPEGやPNGなどが使われる
  - ベクタデータの場合、MVT(MapBox Vector Tile)などが使われる

---

## タイルの概要図

https://maps.gsi.go.jp/development/siyou.html から引用

![bg right 80%](https://maps.gsi.go.jp/help/image/tileNum.png)

---

## ベクターデータの処理の例

- 都道府県ごとの人口データを含むShapefileファイルを読み込んで、人口が100万人以上の都道府県を抽出する
- 都道府県ごとに色分けした地図を作成する
- OpenStreetMapのデータを読み込んで、特定の地点の情報を取得する

---

## Shapefileとは

- ベクターデータを格納するためのファイルフォーマットの一つ
- 以下のファイルで構成される
  - .shp: データ本体
  - .shx: インデックスファイル
  - .dbf: 属性データ
  - .prj: 投影情報
  - .cpg: 文字コード情報
- 個人的にはもう使いたくないフォーマット

---

## [Shapefile Must Die](http://switchfromshapefile.org/)

- Shapefileは滅ぶべきと解説したサイト
- Shapefileのなにが悪い？
  - 一ファイルじゃなくて複数ファイルが必須
  - データベースが.dbfファイル(dBaseファイル)である
  - 2GBもしくは4GBまでのファイルしか扱えない
  - そもそも古い

---

## Shapefileの代替フォーマット

- OGC GeoPackage
- GeoJSON
- FlatGeobuf
- GeoParquet

---

## OGC GeoPackageとは

- OGC(Open Geospatial Consortium)が策定したファイルフォーマット
- SQLite3ベース
- ラスタデータ、ベクタデータ、タイルデータを格納できる
- 1ファイルで完結する(複数のレイヤーが格納できる)

---

## GeoJSONとは

- 地理情報を含むJSONファイルのこと
- 例えば、緯度経度の情報を持つ場合、以下のような形式で記述される

```json
{
  "type": "Feature",
  "geometry": {
    "type": "Point",
    "coordinates": [125.6, 10.1]
  },
  "properties": {
    "name": "Dinagat Islands"
  }
}
```

若干ファイルが大きくなるが、人間が*まだ*読みやすい(かもしれない)

---

## FlatGeobufとは

- FlatBuffersベースのファイルフォーマット
- ベクターデータを格納するためのファイルフォーマット
- 1ファイル1レイヤー
- ファイルサイズが小さい
- Cloud Nativeフォーマット

---

## Cloud Native フォーマットとは

- クラウド環境での利用を意識したファイルフォーマット
- HTTP Range Requestsに対応しているのが特徴

![bg right 100%](https://guide.cloudnativegeo.org/images/flatgeobuf_file_layout.png)

---

## GeoParquetとは

- Apache Arrowベースのファイルフォーマット
- ベクターデータを格納するためのファイルフォーマット
- 1ファイル1レイヤー
- ストリーミング処理などに向いている
- QGIS for macOSでは利用できないので注意(後述)

---

## OpenStreetMapとは

- 地図のWikipediaとも言われるプロジェクト
- 世界中の地図と単一のデータベース(Subversionベース)で管理
- データはODbLライセンスで提供されている
  - 商用利用可能なオープンなライセンス
- データはXML形式で提供されている
  - アーカイブはProtocolBuffer形式でも提供されている

---

## PythonでのGIS処理

- PythonでGIS処理を行うためには、以下のライブラリが利用できる
  - GDAL
  - Fiona
  - Shapely
  - GeoPandas
  - Rasterio
  - Pyproj
  - Cartopy

実際にはもっとある

---

## PythonでのGIS処理の例 (1)　ラスター処理

- GeoTiffファイルを読み込んで、標高タイルを作成する
  - Rasterioを使う
    - 実際にはプラグインを使う
- 航空写真を画像タイルに変換する
  - gdal2tiles.pyを使う

---

## PythonでのGIS処理の例 (2)　ベクター処理

- 線のデータにbufferをかける
  - GeoPandasを使う

![bg right 80%](https://geopandas.org/en/stable/_images/buffer.png)

---

## PythonでのGIS処理の例 (3)　OpenStreetMapのデータ処理

- OpenStreetMapのデータを解析して、特定の地域のコミット数を取得する
  - PyOsmiumを使う

---

## おまけ、点群の処理をする

- LiDARデータを変換する
  - PDALを使う
    - Pythonインターフェイスあり

---

## Pythonでよくある話

- PythonでGIS処理をすると内部的にnumpyが使われる事が多い
  - numpyの高度な機能を使うことで、高速に処理ができる
  - GDALの場合、numpyの配列を使ってデータを処理することが多
    - gdal_calc.pyなどそのまんまPythonのスクリプトもGDALに付属している
- その他、一緒にpandasやgeoPandasを使うなど
- Jupiter Notebookを使うことも多い
  - 僕はvenv派！

---

## FOSS4Gの世界

---

## FOSS4Gとは

- Free and Open Source Software for Geospatialの略
- 地理空間情報を扱うためのOSSの総称
- OSGeo(Open Source Geospatial Foundation)が中心となって開発されている
- イベント名としてFOSS4Gというカンファレンスがある
  - 毎年日本でもFOSS4G Japanが開催されている
    - その他FOSS4G Tokai/FOSS4G Hokkaidoなどがある
  - Globalイベントは毎年異なる国で開催される

---

## FOSS4Gの代表的なライブラリ/ツール

- QGIS
- GDAL/OGR
- PostGIS
- OpenLayers
- GeoServer/MapServer
- GRASS GIS

---

## QGISの紹介

- QGISはQt5及びGDAL/OGRをベースにしたOSSのGISソフトウェア
  - 本年度中にQt6に移行する予定

![bg right 80%](https://i.gyazo.com/dd1fe7a34dedd91672eeed006349d6fb.jpg)

---

## QGISの仕組み

- PyQt5を使ってGUIを構築
- 主にGDAL/OGRを使ってデータを読み込み

---

## QGISの注意点

- OSごとにサポートされているライブラリが異なる
  - Windows版は新しいライブラリがサポートされている
  - Linux版はdistributionに依存する
  - macOSはGDALのバージョンが古い
    - そのため、GeoParquetを使う場合は注意が必要
    - [conda-forge](https://anaconda.org/conda-forge/qgis)を使うという手もあるが未検証

---

## QGISプラグイン

- QGISはプラグインを用いて拡張が可能
  - プラグイン自体もPythonで書かれている
    - 基本的にCross Platform
  - プラグイン自体も自作することが可能
  - プラグインは公式レポジトリに登録することができる

---

## QGISのプラグインの例

- [Japanese Grid Mesh](https://github.com/MIERUNE/qgis-japan-mesh)
  - メッシュコードを表示する便利なプラグイン
- [GTFS-GO](https://github.com/MIERUNE/GTFS-GO)
  - 路線図などのGTFSデータを表示するプラグイン

---

## GTFS-GOのデモ

---

## Python以外の言語でのGIS処理

---

## R言語

- 数値計算言語として有名
  - 統計解析などに使われる
- Rのライブラリとしてsfが有名
  - Rのライブラリとしてはかなり高機能

---

## Ruby

- RubyのライブラリとしてRGeoが有名
- Ruby on Railsでも利用可能
  - [rgeo activerecord-postgis-adapter](https://github.com/rgeo/activerecord-postgis-adapter)など

---

## JavaScript/TypeScript

- JavaScript/TypeScriptのライブラリとしてLeaflet/MapLibre GL JSが有名
- Turf.jsによる地理空間解析も可能、ブラウザだけでなくNode.jsでも利用可能
  - React Native上で空間解析もできる
- サーバサイドの実装も結構ある
  - TileServer GLなど

---

## Rust

- MIERUNE社の[PLATEAU GIS CONVERTER](https://github.com/MIERUNE/plateau-gis-converter)など
  - Rustで書かれたGISデータ変換ツール
- [Martin](https://martin.maplibre.org/) (ベクタタイルサーバ)
  - MapLibre界隈では最近MapLibre NativeがRustをサポートしたりなど、Rustが活発に検討されている

---

ご清聴ありがとうございました
