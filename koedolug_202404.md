---
marp: true
theme: default
footer: 'KoedoLUG 2024/04'
paginate: true
---

# Redmineにパッチを書いてみた & COSCUP のCfPに応募してみた

## Taro Matsuzawa ([@smellman](https://twitter.com/smellman))

### KoedoLUG 2024/04

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

- 入門eBPF
- Rustの練習帳
- ストレンジコード
- 応用情報技術者の教本など

---

# Redmineにパッチを書いてみた

---


## 経緯

- お客さんからRedmineの改修を依頼された
- プラグインで作る事もできるが、パッチを書いて本家に送ってみた
  - まだマージされていない

---

## パッチの内容

- https://www.redmine.org/issues/2024
- RedmineのGanttチャートでドラッグ&ドロップでタスクの開始日を変更できるようにする
- すでに先人が何度もパッチを書いてるが、マージされていない
- 今回は先人のパッチをベースに、最新のRedmineに対応するように書いた
  - また指摘事項の修正(大幅なリファクタリング)を行った

---

## コーディング環境

- Thinkpad E14 Gen4
- Ubuntu Studio 23.10
- MulitpassでUbuntu22.04を作ってRedmineの開発環境を構築
  - VSCodeでリモートコーディング
  - ブラウザで確認

---

# COSCUP のCfPに応募してみた

---

## COSCUP 2024

- 台湾で開催される大きなオープンソースカンファレンス
- まぁ、みんな知ってますよね

---

## CfPに応募

- https://blog.coscup.org/2024/03/coscup-2024-coscup-2024-call-for.html
  - Trackは OpenStreet x Wikidata 開放內容議程軌／OpenStreetMap x Wikidata Open Content Track を選択
  - タイトルは OpenStreetMap Community in Japan です。

---

## 応募内容

This presentation introduces OpenStreetMap Community in Japan's activities.

- Introduce of OpenStreetMap Japan Community.
- Introduce of Plateau import activity.
- Introduce of the vector/raster tile server.
- Introduce of the Overpass API server.
- Other GIS topics from Japan.

---

# 今日のまとめ

- Redmineにパッチを投げてみた
  - まだマージされていない
- COSCUPにCfPを投げてみた
- State of the Map 2024にもCfPを投げてみたいと思っている
  - こっちはテキストエディタでスタイルを書く話をしたい