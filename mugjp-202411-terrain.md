---
marp: true
theme: default
footer: 'MapLibre User Group Japan 2024/11'
paginate: true
backgroundColor: #fff
backgroundImage: url('https://marp.app/assets/hero-background.svg')
---

# MapLibreで使えるいろんなTerrainを作ってみよう

## Taro Matsuzawa ([@smellman](https://x.com/smellman))

### MapLibre User Group Japan 2024/11

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

## いろんなTerrain

- Mapbox Terrain RGBとは
- Terarriumとは
- GSI DEMとは
- rasterioとは
- 使い方
- まとめ

---

## Mapbox Terrain RGBとは

- MapLibre GL JSでサポートされている標高タイルの形式の一つで、Mapboxによって開発をされたもの
- PNGのRGB値に高さ情報が埋め込まれている

![bg right 80%](https://i.gyazo.com/8f482504bc30cf669aabd4343ef1bca8.png)

---

- 計算式は以下の通り

```python
v -= 10000
v /= 0.1
r = ((((v // 256) // 256) / 256) - (((v // 256) // 256) // 256)) * 256
g = (((v // 256) / 256) - ((v // 256) // 256)) * 256
b = ((v / 256) - (v // 256)) * 256
```

MapTilerもこの形式でホスティングをしている

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

## GSI DEMとは

- 国土地理院が提供している標高タイルの形式の一つ
- PNGのRGB値に高さ情報が埋め込まれている(またかよ)
- MapLibre GL JSで使う場合は[maplibre-gl-gsi-terrain](https://github.com/mug-jp/maplibre-gl-gsi-terrain)を使う

![bg right 80%](https://maps.gsi.go.jp/help/image/map-dem_tile.png)

---

- 計算式は以下の通り

```python
u = 0.01
x = v / u
if x > 2 ** 23:
     x = v / u + (2 ** 24)
r = int(int(x) / 2 ** 16)
x = x - (r * (2 ** 16))
g = int(int(x) / 2 ** 8)
x = x - (g * (2 ** 8))
b = int(x)
```

---

## rasterioとは

- Pythonでラスターデータを扱うためのライブラリ
  - 標高データや衛星画像などを扱うことができる

https://rasterio.readthedocs.io/en/stable/

---

## rioでプロセッシング

- [rio-rgbify](https://github.com/mapbox/rio-rgbify)
  - Mapbox形式の標高タイルを作成するライブラリ
- [rio-terrarium](https://github.com/smellman/rio-terrarium)(拙作)
  - Terarrium形式の標高タイルを作成するライブラリ
- [rio-gsidem](https://github.com/smellman/rio-gsidem)(拙作)
  - GSI DEM形式の標高タイルを作成するライブラリ

ぶっちゃけrio-rgbifyを改造しただけ

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

なお、mbtilesのままだと何故か上手く表示できないので`mbutil`で展開するとよい

---

![bg 100%](https://i.gyazo.com/237e1fead8fa2ea98cf5f3a0b30856af.jpg)

---

![bg 100%](https://i.gyazo.com/5c8791e2141afb97d2ed4af8076df0f6.jpg)

---

## TODO

- rio-gsidemはまだnodata(テキスト標高タイルのe)に対応していない
  - nodataの場合はR=128, G=0, B=0となる
  - 他のプログラムもnodataの場合どうするかを決めたい
    - でもnodataの場合の定義がないので難しい

---

## まとめ

- 標高データも簡単にプロセッシングできます。
- 先人のコードを上手く活用しましょう。
