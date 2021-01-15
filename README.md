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

## commentsテーブル

| Column          | Type       | Options                        |
| --------------- | ---------- | ------------------------------ |
| user            | references | null: false, foreign_key: true |
| post            | references | null: false, foreign_key: true |
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

- belongs_to :order