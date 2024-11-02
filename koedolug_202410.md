---
marp: true
theme: default
footer: 'KoedoLUG 2024/10'
paginate: true
backgroundColor: #fff
backgroundImage: url('https://marp.app/assets/hero-background.svg')
---

# 2024/10 rio-terrariumを作ってみた

## Taro Matsuzawa ([@smellman](https://x.com/smellman))

### KoedoLUG 2024/10

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

## rio-terrariumを作ってみた

- Terarriumとは
- rasterioとは
- rio-terrariumとは
- インストール
- 使い方
- まとめ

---

## Terarriumとは

- MapLibre GL JSでサポートされている標高タイルの形式の一つで、TileZenによって開発をされたもの
- PNGのRGB値に高さ情報が埋め込まれている

![bg right 80%](https://i.gyazo.com/5b009289be863e86208fb1c1e1b84a50.png)

---

- 計算式は以下の通り

```python
v += 32768
r = floor(v/256)
g = floor(v % 256)
b = floor((v - floor(v)) * 256)
```

- AWSのオープンデータもこの形式でホスティングをしている

---

## rasterioとは

- Pythonでラスターデータを扱うためのライブラリ
  - 標高データや衛星画像などを扱うことができる

https://rasterio.readthedocs.io/en/stable/

---

## rio-terrariumとは

- rasterioを使ってTerarriumのデータを扱うためのライブラリ
- Mapbox形式の標高タイルを作成する[rio-rgbify](https://github.com/mapbox/rio-rgbify)というライブラリを元に作成
  - ぶっちゃけ計算式だけ入れ替えたり、不要なオプションを削除しただけ

https://github.com/smellman/rio-terrarium

---

## インストール

```bash
python3 -m venv venv
source venv/bin/activate
git clone https://github.com/smellman/rio-terrarium.git
cd rio-terrarium
pip3 install -e '.[test]'
```

---

## 使い方

```bash
# GeoTiffをvrtに変換
gdalbuildvrt -a_srs EPSG:4326 -hidenodata all.vrt test/*.tif
# vrtをGeoTiffに変換
gdal_translate -co compress=lzw \
  -co BIGTIFF=YES -of GTiff all.vrt all.tiff
# gdal_calc.pyで0以下の値を0に変換
gdal_calc.py --co="COMPRESS=LZW" \
  --co="BIGTIFF=YES" --type=Float32 -A all.tiff \
  --outfile=all_calc.tiff --calc="A*(A>0)" --NoDataValue=0
# rio-terrariumで変換
rio terrarium --format png \
  --max-z 18 --min-z 5 -j `nproc` \
  all_calc.tiff dem.mbtiles
```

なお、mbtilesのままだと何故か上手く表示できないのでmbutilで展開するとよい

---

![bg 100%](https://i.gyazo.com/237e1fead8fa2ea98cf5f3a0b30856af.jpg)

---

![bg 100%](https://i.gyazo.com/5c8791e2141afb97d2ed4af8076df0f6.jpg)

---

## まとめ

- 標高データも簡単にプロセッシングできます。
- 先人のコードを上手く活用しましょう。

---

## 今後の予定

- 10/18-19 Open Source Confenrece 2024 Online/Fall
  - jusで小林さんに発表してもらいます
- 10/26 Open Source Conference 2024 Tokyo/Fall
  - OpenStreetMap Japanでブース出展
- 11/9-10 FOSS4G 2024 Japan
  - 今年は神奈川県で開催
- 11/21 JICA講義@国土地理院