---
marp: true
theme: default
footer: 'KoedoLUG 2025/04'
paginate: true
backgroundColor: #fff
backgroundImage: url('https://marp.app/assets/hero-background.svg')
---

# KDE Plasma + RDP でリモートデスクトップ

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

## 最近やってること

- 会社のzenn.devを作成しました
  - [https://zenn.dev/p/georepublic](https://zenn.dev/p/georepublicc)
  - 技術的な記事はここがメインになっていく予定
- QGISのプラグインのQt6対応のパッチを投げてる

---

## 今日のお題

- やったきっかけ
- スペック
- KDE Plasmaをインストール
- RDPをインストール
- ファイアウォールの設定
- Microsoft Remote Desktopで接続
- KDE Plasmaの設定
- おまけ

---

## やったきっかけ

- 実家のPCが一台ほぼ使ってない状態になっていた
- ちょうどDebianのメンテナーになりたいという気持ちが高ぶっていた
  - QGISが使えるDebianを作りたい
    - 具体的にはApache ArrowをDebianで簡単に使えるようにしたい

---

## スペック

- ベアボーン: [ASRock DeskMini A300](https://www.asrock.com/nettop/AMD/DeskMini%20A300%20Series/index.jp.asp)
- CPU: AMD Ryzen 5 3400G with Radeon Vega Graphics
  - 4コア8スレッド
  - GPU内蔵
- RAM: 64GB
- Storage: 1TB NVMe SSD
- OS: Debian sid

---

## KDE Plasmaをインストール

KDE Plasmaをインストールします。

```bash
sudo apt install task-kde-desktop
sudo apt install task-japanese-kde-desktop
```

---

## RDPをインストール

Remote Desktop Protocol (RDP)をインストールします。

```bash
sudo apt install xrdp
sudo systemctl enable xrdp
sudo systemctl start xrdp
```

一般ユーザで、`~/.xsession`を作成してKDE PlasmaのX11版が起動するようにします。

```bash
echo "startplasma-x11" > ~/.xsession
```

wayland版は対応していないようです。

---

## ファイアウォールの設定

KDE Plasma関係のパッケージが勝手に`firewalld`をインストールしてしまうので、`firewall-cmd`を使ってRDPのポートを開ける必要があります。

```bash
sudo firewall-cmd --add-port=3389/tcp --permanent
sudo firewall-cmd --reload
```

ここまでやったら一旦rebootしておきましょう。

---

## Microsoft Remote Desktopで接続

クライアントはmacOSなのでMicrosoft Remote Desktopを使います。

.oO(なんか名前変わるらしいけど...)

---

### PCの設定

![Add PC](https://i.gyazo.com/5f3f4fc33d9489e4285e16441c8319a3.png)

---

### ID/Passwordを入力

![User Account](https://i.gyazo.com/cb7bfa2f72858140ee73d4f6e1d2b66f.png)

---

### 警告がでます

![Warning](https://i.gyazo.com/8adf8db190f0bc8b0ca73fae8947e053.png)

xrdpの証明書をインストールしていないので、警告が出る。証明書を許可します。

---

### Always trust を選択

![Always Trust](https://i.gyazo.com/a319c11078ef674a3c3e53de9f4ae469.png)

---

### 接続完了

KDE Plasmaのデスクトップが表示されます。

---

## KDE Plasmaの設定

Linuxのデスクトップ環境はロックがかかると挙動がおかしくなるケースがあるので、そもそもロックをしないようにします。
具体的には、スクリーンロックと電源管理を無効にします。

---

### スクリーンロック

![Screen Lock](https://i.gyazo.com/8dccf85dfee986fa52bf196c82ef76f3.png)

---

### 電源管理

![Power Management](https://i.gyazo.com/19d8b4f46966adce26ac7f13a929ede4.png)

---

## おまけ

---

### 日本語入力

```bash
sudo apt install -y fcitx5 fcitx5-skk
```

一旦リブートすればfcitx5が起動します。
Ctrl+Spaceで日本語入力に切り替えます。

---

### 再起動のメモ

- KDE Plasmaから再起動すると上手くいきません。
  - `sudo reboot`を使いましょう。

---

### 外出先から接続

自宅のVPN経由でSSHのポートフォワードを使ってます。

```bash
ssh -L 3389:192.168.0.xxx:3389 user@myraspberrypi
```

---

### Prometheus node-exporterのportを開ける

Firewalldが勝手にインストールされて、Prometheusにnode-exporterの情報が飛ばなくなっていたので、ポート9100を開けておきます。

```bash
sudo firewall-cmd --add-port=9100/tcp --permanent
sudo firewall-cmd --reload
```

---

以上、ご静聴ありがとうございました。
