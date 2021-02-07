# README

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