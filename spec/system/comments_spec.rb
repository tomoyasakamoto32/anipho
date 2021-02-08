require 'rails_helper'

RSpec.describe 'コメント投稿', type: :system do
  before do
    @post = FactoryBot.create(:post)
    @comment = Faker::Lorem.sentence
  end

  it 'ログインしたユーザーは詳細ページでコメント投稿できる' do
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
    expect  do
      visit current_path
    end.to change { Comment.count }.by(1)
    # 詳細ページ上に先ほどのコメント内容が含まれていることを確認する
    expect(page).to have_content(@comment)
  end
end

RSpec.describe 'コメント削除', type: :system do
  before do
    @comment1 = FactoryBot.create(:comment)
    @comment2 = FactoryBot.create(:comment)
  end

  context 'コメント削除ができるとき' do
    it 'ログインしたユーザーは詳細ページで、自分のコメントは削除できる' do
      # comment1を投稿したユーザーでログインする
      visit new_user_session_path
      fill_in 'メールアドレス', with: @comment1.user.email
      fill_in 'パスワード', with: @comment1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # 投稿詳細ページに遷移する
      visit post_path(@comment1.post.id)
      # comment1に「削除する」ボタンがあることを確認する
      expect(page).to have_link '削除する', href: post_comment_path(@comment1.post.id, @comment1.id)
      # コメントを削除するとレコードの数が1減ることを確認する
      find_link('削除する', href: post_comment_path(@comment1.post.id, @comment1.id)).click
      expect  do
        visit current_path
      end.to change { Comment.count }.by(-1)
      # 詳細ページに削除したコメントがないことを確認する
      expect(page).to have_no_content(@comment1)
    end
  end

  context 'コメント削除ができないとき' do
    it 'ログインしたユーザーは自分が投稿したコメント以外は削除できない' do
      # comment1を投稿したユーザーでログインする
      visit new_user_session_path
      fill_in 'メールアドレス', with: @comment1.user.email
      fill_in 'パスワード', with: @comment1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # 投稿詳細ページに遷移する
      visit post_path(@comment2.post.id)
      # comment2に「削除する」ボタンがないことを確認する
      expect(page).to have_no_link '削除する', href: post_comment_path(@comment2.post.id, @comment2.id)
    end
    it 'ログインしていないユーザーはコメントの削除ができない' do
      # comment1が投稿されている詳細ページに移動する
      visit post_path(@comment1.post.id)
      # comment1に「削除する」ボタンがないことを確認する
      expect(page).to have_no_link '削除する', href: post_comment_path(@comment1.post.id, @comment1.id)
      # comment2が投稿されている詳細ページに移動する
      visit post_path(@comment2.post.id)
      # comment2に「削除する」ボタンがないことを確認する
      expect(page).to have_no_link '削除する', href: post_comment_path(@comment2.post.id, @comment2.id)
    end
  end
end
