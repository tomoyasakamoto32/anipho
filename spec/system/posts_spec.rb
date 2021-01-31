require 'rails_helper'

RSpec.describe "新規投稿", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @post = FactoryBot.build(:post)
  end
  
  context '新規投稿ができるとき' do
    it 'ログインしたユーザーは新規投稿できる' do
      # ログインする
      visit new_user_session_path
      fill_in 'メールアドレス', with: @user.email
      fill_in 'パスワード', with: @user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # 新規投稿ページへのリンクがあることを確認する
      expect(page).to have_content('投稿する')
      # 新規投稿ページに移動する
      visit new_post_path
      # フォームに情報を入力する
      attach_file 'message_image', "public/images/test_image.png"
      fill_in 'post_text', with: @post.title
      fill_in 'animal_name', with: @post.animal_name
      select 'ねこ', from: 'post[category_id]'
      fill_in 'explanation', with: @post.explanation
      # 投稿するとPostモデルのカウントが1上がることを確認する
      expect{
        find('input[name="commit"]').click
      }.to change {Post.count}.by(1)
      # トップページに遷移することを確認する
      expect(current_path).to eq root_path
      # トップページには先ほど投稿した内容が存在することを確認する（画像)
      expect(page).to have_selector "img[src$='test_image.png']"
      # トップページには先ほど投稿した内容が存在することを確認する(タイトル)
      expect(page).to have_content(@post.title)
    end
  end
  context '新規投稿ができないとき' do
    it 'ログインしていないと新規投稿ページに遷移できない' do
      # トップページに遷移する
      visit root_path
      # 新規投稿ページへのリンクがあることを確認する
      expect(page).to have_content('投稿する')
      # 新規投稿ページへの遷移するボタンを押す
      visit new_post_path
      # ログインページに遷移する
      expect(current_path).to eq new_user_session_path
    end
  end
end
