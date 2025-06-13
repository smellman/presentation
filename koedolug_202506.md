---
marp: true
theme: default
footer: 'KoedoLUG 2025/06'
paginate: true
backgroundColor: #fff
backgroundImage: url('https://marp.app/assets/hero-background.svg')
---

# Ansibleで作るWordpress環境

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

## 転籍しました

- 2025/06/01よりGeoloniaに転籍しました
- Georepublic Japanは来年まで存続します
- GeoloniaはOSGeo.JP及びOpenStreetMap Foundation Japanのスポンサー企業です
- 会社の所在地が良く行っていた場所です(わら)

---

## 今日のお題

OSGeo.JPのインフラ整備で、AnsibleでWordpress環境を作ったのでその内容を紹介します。

なお、Ansibleの内容は非公開にしているので、概要のみを紹介します。

(概要のみなのはYAMLファイルが大きいので、プレゼンテーションファイルにするのが厳しいからです)

ちなみにサーバ自体はAWS CDKで構築しています。EC2インスタンスとElastic IPぐらいですが...

---

## Ansibleのインストール

macOS + uv を利用

```bash
uv init .
uv add ansible
```

---

## ディレクトリ構成

```
.
├── group_vars (secretなどを保存)
├── roles (各種役割を定義)
│   ├── (省略)
│   └── wordpress (Wordpressの役割)
├── inventory.ini
├── osgeojp.yml
├── pyproject.toml
└── uv.lock
```

---

## wordpressディレクトリの構成

```
❯ tree roles/wordpress
roles/wordpress
├── tasks
│   ├── common.yml
│   ├── main.yml
│   ├── old.yml
│   ├── packages.yml
│   ├── stg.yml
│   └── www.yml
└── templates
    ├── old.osgeo.jp.conf.j2
    ├── stg.osgeo.jp.conf.j2
    ├── wp-config-old.php.j2
    ├── wp-config-stg.php.j2
    ├── wp-config-www.php.j2
    └── www.osgeo.jp.conf.j2
```

---

## wordpress/tasks/www.yml

このファイルによってwordpressを本番環境にインストールする

やってることは以下の通り。

1. インストール済みのwordpressのバージョンチェック
2. wordpress本家の最新バージョンをAPIから取得
3. バージョンが異なる場合は、最新バージョンをダウンロード
4. ダウンロードしたファイルを展開
5. wp-config.phpをテンプレートから生成
6. apacheの設定ファイルをテンプレートから生成して有効化

---

## wordpressのバージョンチェック

```yaml
- name: fetch version of WordPress
  shell: php -r "include '{{ wordpress_dir }}/wp-includes/version.php'; echo \$wp_version;"
  register: wordpress_version_result
  when: wordpress_version_file.stat.exists
  changed_when: false
  failed_when: false
```

ポイントとしてはphpのコマンドを使って、ちゃんとevalをしているところです。

---

## wordpress本家の最新バージョンをAPIから取得

```yaml
- name: check current version of WordPress via API
  shell: curl "https://api.wordpress.org/core/version-check/1.7/?locale=ja" | jq -r '.offers | first | .version'
  register: wordpress_upstream_version_result
  changed_when: false
  failed_when: false
```

curlコマンドとjqコマンドは別のタスクでインストールしておく必要があります。

---

## バージョンが異なる場合は、最新バージョンをダウンロード (1/2)

```yaml
- name: check if WordPress needs update
  set_fact:
    install_wordpress: "{{ wordpress_upstream_version_result.stdout != wordpress_version }}"
  when: wordpress_upstream_version_result.stdout is defined
```

---

## バージョンが異なる場合は、最新バージョンをダウンロード (2/2)

```yaml
- name: install and configure Wordpress
  block:
    - name: Download WordPress
      get_url:
        url: https://wordpress.org/latest.tar.gz
        dest: /tmp/wordpress.tar.gz
    - name: Extract WordPress
      ansible.builtin.unarchive:
        src: /tmp/wordpress.tar.gz
        dest: /srv/www/wordpress
        remote_src: yes
        extra_opts: [--strip-components=1]
  (省略)
  when: install_wordpress | default(true)
```

メモ: 省略した部分はwww-dataユーザの所有権を設定するタスクです。

---

## wp-config.phpをテンプレートから生成

```yaml
- name: Copy wp-config.php
  template:
    src: wp-config-www.php.j2
    dest: /srv/www/wordpress/wp-config.php
    owner: www-data
    group: www-data
    mode: "0644"
```

テンプレートには変数としてmysqlのパスワードぐらいしか入っていません。

mysqlのパスワードは`group_vars/all/valut.yml`に定義していて、`anbible-vault`で暗号化しています。

---

## apacheの設定ファイルをテンプレートから生成して有効化

```yaml
- name: Copy Apache2 vhost config for wordpress
  template:
    src: www.osgeo.jp.conf.j2
    dest: /etc/apache2/sites-available/www.osgeo.jp.conf
    owner: root
    group: root
    mode: "0644"

- name: Enable Apache2 vhost config for wordpress
  command: a2ensite www.osgeo.jp.conf

- name: Reload Apache2
  service:
    name: apache2
    state: reloaded
```

---

## Ansibleの実行

```bash
uv run ansible-playbook -i inventory.ini osgeojp.yml --ask-vault-pass
```

`--ask-vault-pass`オプションをつけることで、暗号化された変数を復号化して実行できます。

---

## おまけ

他にもいくつか自動化しています。

- Prometheus関係
  - Node Exporterのインストール
  - Apache Exporterのインストール
- Let's Encryptのインストール
- Postfixのインストール
- Redisのインストール
- バックアップスクリプトのセットアップ

---

## まとめ

Ansible最高！
