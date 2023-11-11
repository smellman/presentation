---
marp: true
theme: default
footer: 'KoedoLUG 2023/11'
paginate: true
---

# Marpではじめるスライド作成

## Taro Matsuzawa ([@smellman](https://twitter.com/smellman))
### KoedoLUG 2023/11

---

# 自己紹介

- Georepublic Japan GIS Engineer
- Sub-President, Japan UNIX Society
- Director, OSGeo.JP
- Director, OpenStreetMap Foundation Japan
- Lead of United Nation OpenGIS/7 core
- Breakcore cluster

![bg right 80%](https://i.imgur.com/ntziIEx.png)

---

# 元ネタ

![bg right 80%](https://i.imgur.com/i1hPi6Q.png)

---

# やりたいこと

- Markdownでスライドを作りたい
- PPTXに書き出しをしたい
- Github Actionでgh-pagesに書き出ししたい

---

# Marpでスライドを作る

- Markdownでスライドを*簡単に*作成できる
- PPTXに書き出しできる
- Github Actionでgh-pagesに書き出しできる

---

# footerなどの調整

```markdown
---
marp: true
theme: default
footer: 'KoedoLUG 2023/11'
paginate: true
---

# Marpではじめるスライド作成
```

`---`で囲んでYAML形式で指定する

---

# Pageの切り替え

```markdown
# Page 1

---

# Page 2
```

`---`がページ区切りになる。`---`の前後に空行が必要

---

# 変換コマンドの基本的な使い方

```bash
$ npx -y @marp-team/marp-cli@latest koedolug_202311.md -o koedolug_202311.pptx
```

- npm installとか不要
- 拡張子は自動判別される
- 他にもHTMLとPDFに対応

---

# 画像の埋め込みの注意点

- 画像はlocalのものを使う時は変換時に `--allow-local-files` をつける
  - このスライドでは面倒なので[imgur](https://imgur.com/)を使っている
- 画像のサイズは自動で調整される(調整しない方法もある)
- ちょっと癖が強いかも
- 詳細は[Image syntax](https://marpit.marp.app/image-syntax)を参考

---

# Github Actionsでの自動化

```yaml
name: GitHub Pages

on: [workflow_dispatch]

jobs:
  deploy:
    runs-on: ubuntu-22.04
    permissions:
      contents: write
    concurrency:
      group: ${{ github.workflow }}-${{ github.ref }}
    steps:
      - uses: actions/checkout@v3

      - name: Setup Node
        uses: actions/setup-node@v3
        with:
          node-version: '20'

      - name: Cache dependencies
        uses: actions/cache@v3
        with:
          path: ~/.npm
          key: ${{ runner.os }}-node-
          restore-keys: |
            ${{ runner.os }}-node-
      
      - run: mkdir -p public
      - run: touch public/.nojekyll
      - run: cp -fr images public/images
      - run: npx -y @marp-team/marp-cli@latest jica-seminar-2023.md -o public/index.html
      - run: npx -y @marp-team/marp-cli@latest jica-seminar-2023.md -o public/jica-seminar-2023.pptx --allow-local-files
      - run: npx -y @marp-team/marp-cli@latest jica-seminar-2023.md -o public/jica-seminar-2023.pdf --allow-local-files

      - name: Deploy
        uses: peaceiris/actions-gh-pages@v3
        if: github.ref == 'refs/heads/main'
        with:
          github_token: ${{ secrets.GITHUB_TOKEN }}
          publish_dir: ./public
```

---

# ポイント

- 毎回ビルドするとgitが肥大化するので、必要なときだけマニュアルでビルドさせる
  - ビルドしたものをgh-pagesにpushする
  - 画像はgh-pagesにcopyしてpushする(HTMLのリンクのため)

---

# で、何を作ってるの？

- [JICAの講義資料](https://github.com/smellman/jica_2023)を作成している
  - こっちにはGithub Actionsを仕込んでいる
- [MapLibre Meetup Japan #01](https://github.com/smellman/presentation/blob/master/mugjp-20231109-maplibre-aws-terrain.md)の資料
- [FOSS4G Asia 2023](https://foss4g.asia/2023/)の資料
  - これらはlocalで出力

---

# まとめ

- Marpで資料作りは便利
- Github Actionsで自動化すると便利
- 画像の埋め込みはちょっと癖がある
  - 画像はimgurを使うと便利
- この資料は10分程度で作りました
