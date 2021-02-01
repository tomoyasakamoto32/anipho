require 'rails_helper'

RSpec.describe "コメント投稿", type: :system do
  before do
    @post = FactoryBot.create(:post)
    @comment = Faker::Lorem.sentence
  end

  it 'ログインしたユーザーはツイート詳細ページでコメント投稿できる' do
    # ログインする
    visit new_user_session_path
    fill_in 'メールアドレス', with: @post.user.email
    fill_in 'パスワード', with: @post.user.password
    find('input[name="commit"]').click
    expect(current_path).to eq root_path
    # 投稿詳細ページに移動する
    visit post_path(@post.id)
    # フォームに情報を入力する
    fill_in 'comment_content', with: @comment
    # コメントを送信すると、Commentモデルのカウントが1上がることを確認する
    find('input[name="commit"]').click
    expect{
      visit current_path
    }.to change {Comment.count}.by(1)
    # 詳細ページ上に先ほどのコメント内容が含まれていることを確認する
    expect(page).to have_content(@comment)
  end
end
