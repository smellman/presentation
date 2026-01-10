---
marp: true
theme: default
footer: 'KoedoLUG 2026/01'
paginate: true
backgroundColor: #fff
backgroundImage: url('https://marp.app/assets/hero-background.svg')
---

# カーニハンのUNIX回顧録読了、OpenStreetMap Japanのサイト再構築の話、Debian sidのシンクライアント？化

## Taro Matsuzawa ([@smellman](https://x.com/smellman))

https://smellman.hatenablog.com/

---

## 自己紹介

- Geolonia GIS Engineer
- Sub-President, Japan UNIX Society
- Director, OSGeo.JP
- Director, OpenStreetMap Foundation Japan
- Lead of United Nation OpenGIS/7 core
- 東京電機大学卒、CySec修了生
- Breakcore cluster

![bg right 80%](https://i.imgur.com/ntziIEx.png)

---

## 本日のお題

- カーニハンのUNIX回顧録の話
- OpenStreetMap Japanのサイト再構築の話
- Debian sid端末をシンクライアントみたいにする話

---

## カーニハンのUNIX回顧録

- プログラミング言語CやUNIXプログラミング環境の共著者、ブライアン・W・カーニハンの自伝的エッセイ
  - AWKの著者の一人としても有名
- 原著は2020年に出版、日本語訳は2025年に出版

---

## Amazonの内容紹介から引用:

Unixは1969年にAT&Tのベル研究所で誕生して以来コンピュータ技術の歩みそのものを変え,今日,その派生物は社会に欠かせない数多くのシステムの中核にある.

本書はUnixの起源に目を向け,Unixとは何であり,どのようにして生まれ,なぜ重要なのかを説明しており,コンピュータあるいは発明の歴史に興味のある人なら誰にでも読んでもらえるように書かれている.

---

## 引用続き:

Unixの物語は,ソフトウェアの設計と構築,そしてコンピュータの効果的な使用方法について多くの洞察を与えてくれる.
また,技術革新がどのように起こるのかという,関連した興味深い物語もある.

なぜUnixはこれほど成功したのか? それは二度と起こりそうにない特異な出来事だろうか? これほど影響力のある結果は計画しうるのだろうか?
コンピュータの歴史において特に生産的な形成期にあった時代の素晴らしい物語のいくつかを本書で伝えたい.

---

## 読んだ感想

- Unixの歴史を知る上で非常に有益な資料
  - ケン・トンプソン氏とデニス・リッチー氏の話がメインになる傾向があるけど、第三者としてダグ・マキロイ氏がかなり影響を与えていたという視点が面白かった
- ベル研の雰囲気やさまざまな人々の貢献がいろんな物を生んでいった
  - パイプなんかもその一つ
- 読み物として非常に面白かった
  - 歴史に興味がある人にはオススメ

---

## OpenStreetMap Japanのサイト再構築

- OpenStreetMap Japan (OSM Japan) https://openstreetmap.jp/ は古くからあるOSMの日本向けコミュニティサイト
  - 現在、Ubuntu 18.04 LTS + Drupal 7 で構築されている
    - さすがに古すぎる

---

## リプレイス方針

- できればCMSを排除したい。
  - 三浦さんとはCMSレスの話で合意ができていた
    - Github Pagesで運営してコンテンツはPull Requestで管理
- せっかくなのでModernな技術スタックを使いたい

---

## リプレイス検討

- 簡単な実装をastroで試してみた
  - Markdownで記事を書いて、GitHub Pagesでホスティングするイメージ
- 試しにOpenStreetMap JapanのDrupal 7のmysql dumpをChatGPTに食わせて見たところ、ある程度の変換はできた
  - 頑張ってスクリプトを作らせ続けたところ、Astro用のMarkdown及び画像のスクレピングができるようになった
  - ただし、細かい修正は必要だった

---

## 現状の開発状況

- https://openstreetmap-japan.github.io/
- https://github.com/openstreetmap-japan/openstreetmap-japan.github.io
- コンテンツだけ移した状態になっている。
- UIなどはこれから実装する予定

---

## Debian sid端末をシンクライアントみたいにする話

- 実家で使っているDebian sid端末がある
- 自宅にVPN貼ってからSSHでトンネルしてRemote Desktop Protocol (RDP)で接続して使っていたが、さすがに手順が多い
- もっと簡単に使いたい
- というわけで、Cloudflaredを使ってみた

---

## Cloudflaredの設定

- Cloudflaredは公式のdebパッケージを利用
- RDPの設定は以下の通り

```yaml
tunnel: hoge-tunnel
credentials-file: /home/btm/.cloudflared/xxx.json

ingress:
  - hostname: hoge.smellman.org
    service: ssh://localhost:22
  - hostname: hoge-remote.smellman.org
    service: rdp://localhost:3389
  - service: http_status:404
```

---

## 接続元での実行

```bash
cloudflared access rdp --hostname hoge-remote.smellman.org --url localhost:13389
```

これで、RDPクライアントでlocalhost:13389に接続すればOK

---

## シンクライアントとして

- GmailのPOP3アクセスが無くなったので、プロバイダのメールをThunderbirdで読むようにした
  - Gmailのようにフィルタリング機能が無いので、ローカルでは見たくなかった
- マシンリソースがあるので、開発にも利用可能
  - ただし、開発環境自体会社で用意してもらった MINIS FORUM MS-S1 MAX を使うことが多い
- VPNやSSHトンネルをいちいち張る必要が無いので、非常に楽

