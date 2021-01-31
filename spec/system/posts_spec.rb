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

RSpec.describe '投稿編集', type: :system do

  before do
    @post1 = FactoryBot.create(:post)
    @post2 = FactoryBot.create(:post)
  end

  context '投稿編集ができるとき' do
    it 'ログインしたユーザーは自分が過去にした投稿を編集できる' do
      # post1を投稿したユーザーでログインする
      visit new_user_session_path
      fill_in 'メールアドレス', with: @post1.user.email
      fill_in 'パスワード', with: @post1.user.password
      find('input[name="commit"]').click
      # 投稿詳細ページに遷移する
      visit post_path(@post1.id)
      # 編集ボタンがあることを確認する
      expect(page).to have_link '編集する', href: edit_post_path(@post1)
      # 編集ページに遷移する
      visit edit_post_path(@post1)
      # すでに投稿済みの内容がフォームに入っていることを確認する
      expect(
        find('#post_text').value
      ).to eq @post1.title
      expect(
        find('#animal_name').value
      ).to eq @post1.animal_name
      expect(
        find('#post_category_id').value
      ).to eq "#{@post1.category_id}"
      expect(
        find('#explanation').value
      ).to eq @post1.explanation
      # 投稿内容を編集する
      attach_file 'message_image', "public/images/header.png"
      fill_in 'post_text', with: "#{@post1.title}編集"
      fill_in 'animal_name', with: "#{@post1.animal_name}編集"
      select 'いぬ', from: 'post[category_id]'
      fill_in 'explanation', with: "#{@post1.explanation}編集"
      # 編集してもPostモデルのカウントが上がらないことを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Post.count }.by(0)
      # 投稿詳細ページに遷移する
      visit post_path(@post1)
      # 投稿詳細ページに先ほどの変更が反映された投稿が存在することを確認する(画像)
      expect(page).to have_selector "img[src$='header.png']"
      # 投稿詳細ページに先ほどの変更が反映された投稿が存在することを確認する(タイトル、ペットの名前、カテゴリー、説明)
      expect(page).to have_content("#{@post1.title}編集")
      expect(page).to have_content("#{@post1.animal_name}編集")
      expect(page).to have_content("いぬ")
      expect(page).to have_content("#{@post1.explanation}編集")
    end
  end
  context '投稿編集ができないとき' do
    it 'ログインしたユーザーは自分以外の投稿の編集画面には遷移できない' do
      # post1を投稿したユーザーでログインする
      # post2の詳細ページに遷移する
      # post2詳細ページに編集ボタンが表示されていないことを確認する
    end
    it 'ログインしていないと投稿編集画面には遷移できない' do
      # post1の詳細ページに遷移する
      # post1の詳細ページに編集ボタンがないことを確認する
      # post2の詳細ページに遷移する
      # post2の詳細ページに編集ボタンがないことを確認する
    end
  end
end
