# アプリケーション情報

### アプリケーション名

#### Anipho

<img width="1792" alt="スクリーンショット 2021-02-15 21 49 54" src="https://user-images.githubusercontent.com/76158766/107950572-39e82180-6fda-11eb-81e2-5d32a11172af.png">

### アプリケーション概要(コンセプト)
飼い主が、写真と文章を通して、手軽にペットを自慢できる記事投稿型のサービスです。  

ペットの飼い主の「自慢のペットを見て欲しい」、「ペットを通して動物好きな人たちと繋がりたい」というニーズに対して、現状のSNSの「動画をアップするのが手間(YouTube)」という欠点と、「ユーザーの属性が限定的ではない(InstagramやTwitter)」という欠点が課題であると考え、その課題を解決すべく開発しました。

また、裏テーマとして、「人々のストレスと攻撃性の高まりを感じる世の中で、ペットを通じて少しでも心が安らぐ空間を作りたい」という思いもあり、このサービスを考えました。

### URL(デプロイ)
https://anipho-app.com/

### 採用担当者様へ
お忙しい中ご覧いただき誠にありがとうございます。トップページのヘッダーにゲストログインを設けてありますので、ログインが必要な機能(投稿機能、いいね機能、コメント機能、フォロー機能)をお試し頂く際はご利用ください。


# 使用技術
### フロントエンド
- HTML
- CSS
- JavaScript

### バックエンド
- ruby 2.6.5
- Ruby on Rails 6.0.0
- Facebook API
- Google API

### インフラ
- Docker 20.10.2
- docker-compose 1.27.4
- nginx 1.18.0
- mysql 5.6
- AWS(EC2, ALB, Route53)

### その他
- RSpec
- rubocop
- capistrano

# 機能一覧
- ユーザー管理機能(新規登録、ログイン、ログアウト)
- ゲストログイン機能
- SNSログイン機能
- 投稿機能
- 投稿一覧表示機能
- ページネーション機能
- 投稿詳細表示機能
- 投稿編集・削除機能
- フォロー機能(Ajax)
- フォローユーザー投稿一覧機能
- いいね機能(Ajax)
- コメント投稿機能(Ajax)
- コメント一覧表示機能
- 検索機能
- カテゴリー検索機能
- タグ付け機能

# テスト
- 単体テスト
- 統合テスト


# DB設計

## ER図
<img width="821" alt="スクリーンショット 2021-02-15 22 32 10" src="https://user-images.githubusercontent.com/76158766/107952873-ae708f80-6fdd-11eb-9b15-fa666d77796b.png">

## users テーブル

| Column             | Type   | Options                   |
| ------------------ | ------ | ------------------------- |
| nickname           | string | null: false               |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false               |

### Association

- has_many :posts
- has_many :comments
- has_many :likes
- has_many :relationships
- has_many :sns_credentials

## postsテーブル

| Column             | Type       | Options                         |
| ------------------ | ---------- | ------------------------------- |
| title              | string     | null: false                     |
| explanation        | text       |                                 | 
| category_id        | integer    | null: false                     |
| animal_name        | string     |                                 |
| user               | references | null: false, foreign_key: true  |

### Association

- belongs_to :user
- has_many   :comments
- has_many   :likes
- has_many   :tags
- has_many   :post_tag_relations

## commentsテーブル

| Column          | Type       | Options                        |
| --------------- | ---------- | ------------------------------ |
| user            | integer    | null: false                    |
| post            | integer    | null: false                    |
| content         | string     | null: false                    |

### Association

- belongs_to :user
- belongs_to :post

## likesテーブル

| Column           | Type       | Options                        |
| ---------------- | ---------- | ------------------------------ |
| user             | references | null: false, foreign_key: true |
| post             | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :post

## tagsテーブル

| Column           | Type       | Options                        |
| ---------------- | ---------- | ------------------------------ |
| name             | string     | null: false, uniqueness:: true |

### Association

- has_many :posts
- has_many :post_tag_relations

## post_tag_relationsテーブル

| Column           | Type       | Options                        |
| ---------------- | ---------- | ------------------------------ |
| tag              | references | null: false, foreign_key: true |
| post             | references | null: false, foreign_key: true |

### Association

- belongs_to :post
- belongs_to :tag

## relationshipsテーブル

| Column           | Type       | Options                        |
| ---------------- | ---------- | ------------------------------ |
| user             | references |  foreign_key: true             |
| follow           | references |  foreign_key: true             |

### Association
- belongs_to :user
- belongs_to :follow, class_name: 'User'

## sns_credentialsテーブル

| Column           | Type       | Options                        |
| ---------------- | ---------- | ------------------------------ |
| provider         | string     |                                |
| uid              | string     |                                |
| user             | references |  foreign_key: true             |

### Association

- belongs_to :user