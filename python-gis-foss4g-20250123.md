---
marp: true
theme: default
footer: '気象予報とPython - こんなところにPythonが Vol.1'
paginate: true
backgroundColor: #fff
backgroundImage: url('https://marp.app/assets/hero-background.svg')
---

# PythonではじめるGIS処理とFOSS4Gの世界

## Taro Matsuzawa ([@smellman](https://x.com/smellman))

### 気象予報とPython - こんなところにPythonが Vol.1

---

## 自己紹介

- Georepublic Japan GIS Engineer
- 日本UNIXユーザ会副会長
- OSGeo.JP理事
- OpenStreetMap Foundation Japan理事
- Lead of United Nation OpenGIS/7 core
- Breakcore cluster

![bg right 80%](https://i.imgur.com/ntziIEx.png)

---

## 書いた本

- React Native＋Expoではじめるスマホアプリ開発
  - 内容が古すぎるので**絶対に**買わないでください。
- 他にもFirefox Hacks Rebooted(O'Reilly Japan)など
- キオクシアの同人誌にも寄稿しています。

![bg right 80%](https://book.mynavi.jp/files/topics/92636_ext_06_0.jpg)

---

## 本日のお話

- GISとは
- PythonでのGIS処理
- FOSS4Gの世界
- QGISの紹介
- まとめ

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

- PythonでGIS処理を行うためには、いかのライブラリが利用できる
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
　　- GDALの場合、numpyの配列を使ってデータを処理することが多い

---

## FOSS4Gの世界

---

## FOSS4Gの代表的なライブラリ/ツール

- QGIS
- GDAL/OGR
- PostGIS
- 
---

## QGISの紹介

---

## QGISの使い方

---

## QGISプラグイン

---

## まとめ

---

ご清聴ありがとうございました
