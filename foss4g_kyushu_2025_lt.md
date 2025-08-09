---
marp: true
theme: default
footer: 'FOSS4G KYUSHU 2025 LT'
paginate: true
backgroundColor: #fff
backgroundImage: url('https://marp.app/assets/hero-background.svg')
---

# OpenStreetMap Sound Demo

## FOSS4G KYUSHU 2025 LT

### 2025/08/09

### Taro Matsuzawa ([@smellman](https://x.com/smellman))


https://smellman.hatenablog.com/

---

## 自己紹介

- Geolonia GIS Engineer
  - ex: Georepublic Japan
- Sub-President, Japan UNIX Society
- Director, OSGeo.JP
- Director, OpenStreetMap Foundation Japan
- Lead of United Nation OpenGIS/7 core
- 東京電機大学卒、CySec修了生
- Breakcore cluster

![bg right 80%](https://i.imgur.com/ntziIEx.png)

---

## OpenStreetMap Sound Demoの概要

- OpenStreetMapの建物データを使って再生した音楽に応じて建物が変化するデモ
  - 元々はMapboxが作っていたロジックを参考にしている
- 音楽の再生及び建物の高さ生成にはWeb Audio APIを使用
- 音源は全てOtherman Recordsのものを使用

---

## デモ

https://youtu.be/unNvqxxyvMY

---

## デモの技術スタック

- [Vite](https://vite.dev/) + [TypeScript](https://www.typescriptlang.org/)
- [MapLibre](https://maplibre.org/)
  - tile.openstreetmap.jpの建物データを使用
  - Location APIを使用して現在地を取得
  - PMTilesを利用(負荷低減のため)
- [Bootstrap](https://getbootstrap.com/)でUIを構築
- [Web Audio API](https://developer.mozilla.org/ja/docs/Web/API/Web_Audio_API)

---

## Otherman Recordsの紹介

- [Otherman Records](https://www.otherman-records.com/)は、ブレイクコアをメインに高クオリティな楽曲を配信する日本のネットレーベル
  - 主催のOthermoonは友人です
- Archive.orgを活用して、全ての楽曲をCC-BYライセンスで公開

---

## Otherman Recordsのスクレイピング

- Otherman Records自体JSON API及びNuxt.jsでサイトを構築している
- JSON APIのエンドポイントを解析して、楽曲のリリース一覧を取得及びアルバムの情報を取得している
  - 勝手にやった
- 詳しい事は [otherman-records.ts](https://github.com/smellman/osm-sound-demo/blob/main/src/otherman-records.ts)を参考にしてください

---

## Web Audio APIの活用

- 初期バージョンは単に音源自体をローカルにコピーしていてそれをFetchしていた
  - ローカルでの開発ではちゃんと動くが、一度にデータを全部読まないと音楽が再生できないため、展示会などでのデモが厳しかった
- Web Audio APIを使う事で、ストリーミング再生に対応
  - ネットワークごしでも軽快に動作

---

## CORS突破のproxyサーバーの構築

- archive.orgでCORSが有効になっていないものが大半
  - 一部楽曲だけはCORSが有効という謎な状態
  - 今、Othermoonにコンタクト取って確認してもらってる
- proxyサーバーをPythonで実装して、CORSを突破している

https://github.com/smellman/archive-org-proxy

---

## VJモードの爆誕

- VJモードは任意の音楽に合わせて建物が変化するモード
  - macOSならLoopback、LinuxならPipeWireを使って音楽をキャプチャ
- 60秒ごとにランダムで場所を移動

---

## あらためてデモ

![QRコード](https://smellman.github.io/osm-sound-demo/qr.png)

https://smellman.github.io/osm-sound-demo/

---

## おまけ

今週水曜日までOtherman Records自体がメンテナンスで停止していた。
なお、停止理由は内緒です。