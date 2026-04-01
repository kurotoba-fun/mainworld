# 黒帳キャラクター集（Jekyll / GitHub Pages）

Markdownファイルを編集して公開できる、GitHub Pages向けのJekyllサイト雛形です。

## ページ構成

- `/` トップページ（世界観・作者紹介・導線）
- `/characters/` キャラクター一覧ページ
- `/characters/<slug>/` キャラクター詳細ページ

## 更新する場所

### 1. キャラクターを追加・更新する
`_characters/` の中にある Markdown ファイルを編集します。

例：`_characters/arata.md`

最低限ここを編集すれば反映されます。

```yaml
---
name: 鍛炭 灼
ruby: かすみ あらた
role: エース級暗殺者
order: 1
summary: 一覧ページに出る短い紹介文
---
```

その下に本文を書くと、詳細ページ本文として表示されます。

### 2. 作者名やTwitterリンクを変える
`_data/site.yml` を編集します。

- 作者名
- 作者紹介文
- X / Twitter の表示名
- X / Twitter のURL

をここで一括管理しています。

### 3. 世界観説明を変える
`index.md` を編集します。

## 画像を入れる場所

- キャラクター画像：`assets/images/characters/`
- サイト用画像：`assets/images/site/`

各キャラMarkdownの `image:` に画像パスを書けば表示されます。

例：

```yaml
image: /assets/images/characters/arata.jpg
```

## GitHub Pagesで公開する手順

1. この一式を GitHub リポジトリにアップロード
2. GitHub の `Settings` → `Pages` を開く
3. `Deploy from a branch` を選ぶ
4. Branch は `main` / フォルダは `/ (root)` を選ぶ
5. 保存すると公開されます

## ローカル確認（任意）

Ruby / Bundler が使える環境なら以下で確認できます。

```bash
bundle install
bundle exec jekyll serve
```

## 追加しやすい拡張

- 更新履歴ページ
- 世界観詳細ページ
- タグ別一覧
- 画像ギャラリー
- 外部リンク集
