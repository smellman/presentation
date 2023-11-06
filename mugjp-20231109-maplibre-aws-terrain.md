---
marp: true
theme: default
footer: 'MUGJP 2023/11/09'
paginate: true
---

# MapLibre GL JSでAmazonが出してるTerrainタイルを使ってみよう

Taro Matsuzawa
Georepublic / JUS / OSGeo.JP / OSMFJ
https://smellman.hatenablog.com/

---

# 自己紹介

- Georepublic Japan GISエンジニア
- 日本UNIXユーザ会副会長
- OSGeo.JP理事
- OpenStreetMap Foundation Japan理事
- Breakcoreクラスタ

![bg right 80%](https://i.imgur.com/ntziIEx.png)

---

# 今日のお話

Amazonが出してるTerrainタイルをMapLibre GL JSで使ってみよう

---

# Terrainタイルとは？

- 標高データをタイル化したもの
- ラスタタイルとして配信されている
  - 1タイル256x256ピクセル
- 日本では地理院のDEMタイルが有名

![bg right 80%](https://i.imgur.com/6SB55fq.png)

---

# AmazonのTerrainタイル

- https://registry.opendata.aws/terrain-tiles/ で公開されているタイルセット
- 世界中の標高データをタイル化して配信している
- フォーマットは地理院DEMタイルとは違う
  - Mapzen format

---

![bg 80%](https://i.imgur.com/g8ScQOa.jpg)

---

# Maplibre GL JSでのTerrainタイルの取り扱い

- sourceのtypeに`raster-dem`を指定する
- encodingに"terrarium", "mapbox", "custom"が利用可能
  - "terrarium"はMapzen format
  - defaultは"mapbox"なので注意
- attributionをちゃんと書く事
  - https://github.com/tilezen/joerd/blob/master/docs/attribution.md

---

![bg 80%](https://i.imgur.com/cJl6CZf.jpg)

---

# 簡単な実装例 (1/3)

```js
const styleUrl = "https://tile.openstreetmap.jp/styles/maptiler-basic-ja/style.json"
const terrainUrl = "https://s3.amazonaws.com/elevation-tiles-prod/terrarium/{z}/{x}/{y}.png"
let style;
fetch(styleUrl).then(res=> res.json()).then(json => {
    style = json
    style['sources']['terrain'] = {
        type: "raster-dem",
        tiles:[terrainUrl],
        encoding: 'terrarium',
        tileSize: 256,
        maxzoom: 15,
        minzoom: 1,
        attribution: '...',
    }
```

---

# 簡単な実装例(2/3)

```js
style['layers'].push({
    id: 'hills',
    type: 'hillshade',
    source: 'terrain',
    paint: { 
        'hillshade-illumination-anchor': 'map',
        'hillshade-exaggeration': 0.2,
    },
})
```

---

# 簡単な実装例(3/3)

```js
const map = new maplibregl.Map({
    maxZoom: 20,
    container: 'map',
    style: style,
    maxPitch: 85,
    hash: true,
    center: [140.084556, 36.104611],
    zoom: 10,
})
map.addControl(
    new maplibregl.TerrainControl({
        source: 'terrain',
        exaggeration: 1
    })
)
```

---

# デモサイト

https://smellman.github.io/aws-terrain/

---

![bg 80%](https://i.imgur.com/JvcgUYM.png)

---

# まとめ

- AmazonのTerrainタイルはMapLibre GL JSで使える
- ただし、地理院DEMタイルとはフォーマットが違うので注意
- ちゃんとattributionを書こう
  - 僕は数日前まで忘れてました(てへ)