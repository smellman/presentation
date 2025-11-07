---
marp: true
theme: default
footer: 'KoedoLUG 2025/11'
paginate: true
backgroundColor: #fff
backgroundImage: url('https://marp.app/assets/hero-background.svg')
---

# MINIS FORUM MS-S1 MAX に Debian trixie を導入

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

## なんかバズりました

![X](https://i.gyazo.com/327540b98cfe2a58b6558bed43d53101.jpg)

---

## 本日のお題

- MINIS FORUM MS-S1 MAX について
- Debian trixie の導入手順
- もろもろの設定

---

## MINIS FORUM MS-S1 MAX の概要

https://www.minisforum.jp/products/ms-s1-max

- CPU: AMD Ryzen Al Max+ 395 (16 cores / 32 threads)
- GPU: AMD Radeon Graphics
- Memory: 128GB DDR4
- Storage: 2TB NVMe SSD
- Network: 10GbE + Wi-Fi 7
- Price: 約30万円
- なぜかゲームコントローラが付属

---

## Debian trixie の導入手順

- Debian trixie のnetinst ISOイメージをダウンロード
- USBメモリに書き込み(Balena Etcher)
- F7キーでブートメニューを表示して、USBメモリから起動
- インストーラーの指示に従ってインストール
  - Ethernetが認識されないので、Wi-Fiで接続
  - パーティションは自動設定でOK
  - GUIなどは入れずにsshだけインストール
- 再起動して、インストール完了

---

## Linux Kernel 6.16の導入

- Debian trixie のデフォルトカーネルは6.12系
- Ethernet(Realtek 8127)を認識させるために、6.16系にアップデート
  - Debian Backportsを導入する
  - `/etc/apt/sources.list`に以下を追加

```
deb http://deb.debian.org/debian/ trixie-backports main non-free-firmware
deb-src http://deb.debian.org/debian/ trixie-backports main non-free-firmware
```

- あとは以下のコマンドでインストール

```bash
sudo apt update
sudo apt install linux-image-6.16.3+deb13-amd64
```

---

## Networkの設定(1)

- `ip addr`コマンドで10GbEが`enp193s0`と`enp194s0`として認識されていることを確認
- `/etc/systemd/network/10-enp193s0.network`と`/etc/systemd/network/11-enp194s0.network`を作成
  - Static IPとして設定(以下、11-enp194s0.networkの例)

```
[Match]
Name=enp194s0

[Network]
Address=192.168.0.251/24
Gateway=192.168.0.1
DNS=1.1.1.1
```

---

## Networkの設定(2)

- `systemctl restart systemd-networkd`でNetworkを再起動
  - `ip addr`でIPアドレスが設定されていることを確認
- `systemctl enable systemd-networkd`で起動時にNetworkが有効になるように設定

---

## /tmp の設定

- Debianではデフォルトで`/tmp`がtmpfsとしてマウントされる
  - RAMを消費するので、/tmpをディスクに変更する

```bash
sudo systemctl mask tmp.mount
sudo reboot
```

---

## cloudflaredをインストール(1)

- cloudflaredをインストールして、Cloudflare Tunnelを利用できるようにする

```bash
wget https://github.com/cloudflare/cloudflared/releases/download/2025.10.1/cloudflared-linux-amd64.deb
sudo dpkg -i cloudflared-linux-amd64.deb
cloudflared tunnel login
cloudflared tunnel create hogehoge
vim .cloudflared/config.yaml
cloudflared tunnel route dns hogehoge hogehoge.smellman.org
cloudflared tunnel route dns hogehoge dev-hogehoge.smellman.org
cloudflared tunnel run hogehoge
```

---

## cloudflaredをインストール(2)

- `/etc/systemd/system/cloudflared-hogehoge.service`を作成して、起動時に自動でCloudflare Tunnelが起動するように設定

```
[Unit]
Description=Cloudflare Tunnel (hogehoge)
After=network.target

[Service]
TimeoutStartSec=0
Type=simple
ExecStart=/usr/local/bin/cloudflared tunnel --config /home/btm/.cloudflared/config.yml run hogehoge
Restart=always
RestartSec=3
User=btm

[Install]
WantedBy=multi-user.target
```

---

## cloudflaredのインストール(3)

- `sudo systemctl enable cloudflared-hogehoge`で起動時にCloudflare Tunnelが有効になるように設定する

```bash
sudo systemctl daemon-reload
sudo systemctl enable cloudflared-hogehoge
sudo systemctl start cloudflared-hogehoge
```

- ローカルマシンからsshできるようにconfigを設定

```
Host hogehoge.smellman.org
  HostName hogehoge.smellman.org
  ProxyCommand cloudflared access ssh --hostname %n
```

- これで外出先からでもsshで接続可能に

---

## その他やったこと

- git/dockerなどをインストール
- sshは公開鍵認証のみ許可

---

## まとめ

- MINIS FORUM MS-S1 MAX に Debian trixie を無事導入できた
  - Kernelが新しくないと動かないのはちょっとびびった