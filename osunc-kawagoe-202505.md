---
marp: true
theme: default
footer: 'KoedoLUG 2025/04'
paginate: true
backgroundColor: #fff
backgroundImage: url('https://marp.app/assets/hero-background.svg')
---

# Raspberry Pi 4 デジタルサイネージ化計画

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

Raspberry Pi 4が背面にくっつけられる[7inch タッチスクリーン](https://amzn.to/3RBKlqZ)を買ったので、デジタルサイネージっぽいことをやってみようと思った

---

## 基本的なセットアップ

- Debian sid
- openbox
- fcitx + skk
- バーチャルキーボード
- openboxの起動設定

---

## Debian sidのインストール

- `/etc/apt/source.list`をdebian sidに変更
- `/etc/apt/sources.list.d/`にあるraspberry piのレポジトリを削除
- `apt update`と`apt dist-upgrade`

---

## openboxをインストール

```bash
apt install openbox
apt install tint2
apt install conky
```

---

## fcitx + skkをインストール

```bash
apt install fcitx fcitx-skk
fcitx-autostart
fcitx-config-gtk3
```

---

## バーチャルキーボード

今回は[onboard](https://launchpad.net/onboard)をインストール

右クリックのエミュレーションができるのでタッチスクリーンでも右クリックができるよ！

```bash
apt install onboard
```

---

## openboxの起動設定

`$HOME/.config/openbox/autostart`を以下のように設定

```bash
xmodmap ~/.Xmodmap &
tint2 &
fcitx-autostart &
sleep 1 &
onboard &
sleep 1 &
conky &
```

xmodmapは接続したキーボードでCapsLockをCtrlにするためのものです。

---

## こんな感じです(実機持ってきてます)

![openbox + onboard](https://i.gyazo.com/d85320378f4b57aa6ab7823770059084.png)

---

## 辛い点

- タッチスクリーンで画面上部のクリックがムズい
- 右クリックはやはりやりづらい
  - Thnkpad Keyboardは必須

---

## 今後の展望

- PyQtでアプリを作る
- 間違えて4GBのRaspberry Pi 4を買ってしまったので、8GBのRaspberry Pi 4を買う
- 慣れる
