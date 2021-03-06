require 'rails_helper'

RSpec.describe '新規投稿', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @post = FactoryBot.build(:post)
    @tag = FactoryBot.build(:tag)
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
      attach_file 'message_image', 'public/images/test_image.png'
      fill_in 'post_text', with: @post.title
      fill_in 'animal_name', with: @post.animal_name
      select 'ねこ', from: 'posts_tag[category_id]'
      fill_in 'explanation', with: @post.explanation
      fill_in 'tag', with: @tag.name
      # 投稿するとPostモデルとTagモデルのカウントが1上がることを確認する
      expect  do
        find('input[name="commit"]').click
      end.to change { Post.count }.by(1)
      change { Tag.count }.by(1)
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
    @tag = FactoryBot.create(:tag)
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
        find('#posts_tag_category_id').value
      ).to eq @post1.category_id.to_s
      expect(
        find('#explanation').value
      ).to eq @post1.explanation
      # 投稿内容を編集する
      attach_file 'message_image', 'public/images/header.png'
      fill_in 'post_text', with: "#{@post1.title}編集"
      fill_in 'animal_name', with: "#{@post1.animal_name}編集"
      select 'いぬ', from: 'posts_tag[category_id]'
      fill_in 'explanation', with: "#{@post1.explanation}編集"
      fill_in 'tag', with: "#{@tag.name}編集"
      # 編集してもPostモデルのカウントが上がらないことを確認する
      expect  do
        find('input[name="commit"]').click
      end.to change { Post.count }.by(0)
      # 編集した場合でもTagモデルのカウントは上がることを確認する
      change { Tag.count }.by(1)
      # 投稿詳細ページに遷移する
      visit post_path(@post1)
      # 投稿詳細ページに先ほどの変更が反映された投稿が存在することを確認する(画像)
      expect(page).to have_selector "img[src$='header.png']"
      # 投稿詳細ページに先ほどの変更が反映された投稿が存在することを確認する(タイトル、ペットの名前、カテゴリー、説明)
      expect(page).to have_content("#{@post1.title}編集")
      expect(page).to have_content("#{@post1.animal_name}編集")
      expect(page).to have_content('いぬ')
      expect(page).to have_content("#{@post1.explanation}編集")
    end
  end
  context '投稿編集ができないとき' do
    it 'ログインしたユーザーは自分以外の投稿の編集画面には遷移できない' do
      # post1を投稿したユーザーでログインする
      visit new_user_session_path
      fill_in 'メールアドレス', with: @post1.user.email
      fill_in 'パスワード', with: @post1.user.password
      find('input[name="commit"]').click
      # post2の詳細ページに遷移する
      visit post_path(@post2)
      # post2詳細ページに編集ボタンが表示されていないことを確認する
      expect(page).to have_no_link '編集する', href: edit_post_path(@post2)
    end
    it 'ログインしていないと投稿編集画面には遷移できない' do
      # post1の詳細ページに遷移する
      visit post_path(@post1)
      # post1の詳細ページに編集ボタンがないことを確認する
      expect(page).to have_no_link '編集する', href: edit_post_path(@post1)
      # post2の詳細ページに遷移する
      visit post_path(@post2)
      # post2の詳細ページに編集ボタンがないことを確認する
      expect(page).to have_no_link '編集する', href: edit_post_path(@post2)
    end
  end
end

RSpec.describe '投稿削除', type: :system do
  before do
    @post1 = FactoryBot.create(:post)
    @post2 = FactoryBot.create(:post)
  end

  context '投稿削除ができるとき' do
    it 'ログインしたユーザーは自分の過去にした投稿を削除できる' do
      # post1を投稿したユーザーでログインする
      visit new_user_session_path
      fill_in 'メールアドレス', with: @post1.user.email
      fill_in 'パスワード', with: @post1.user.password
      find('input[name="commit"]').click
      # post1の詳細ページに遷移する
      visit post_path(@post1.id)
      # 削除ボタンがあることを確認する
      expect(page).to have_link '削除する', href: post_path(@post1)
      # 投稿を削除するとレコードの数が1減ることを確認する
      expect do
        find_link('削除する', href: post_path(@post1.id)).click
      end.to change { Post.count }.by(-1)
      # 投稿を削除してもタグのレコードは変わらないことを確認する
      change { Tag.count }.by(0)
      # トップページに遷移する
      visit root_path
      # トップページにはpost1の内容が存在しないことを確認する（画像)
      expect(page).to have_no_selector "img[src$='#{@post1.images}']"
      # トップページにはpost1の内容が存在しないことを確認する（テキスト）
      expect(page).to have_no_content(@post1.title)
    end
  end
  context '投稿削除ができないとき' do
    it 'ログインしたユーザーは自分以外がした投稿を削除できない' do
      # post１を投稿したユーザーでログインする
      visit new_user_session_path
      fill_in 'メールアドレス', with: @post1.user.email
      fill_in 'パスワード', with: @post1.user.password
      find('input[name="commit"]').click
      # post2の詳細ページに遷移する
      visit post_path(@post2.id)
      # post2の削除ボタンがないことを確認する
      expect(page).to have_no_link '削除する', href: post_path(@post2.id)
    end
    it 'ログインしていないと詳細ページに削除ボタンがない' do
      # post1の詳細ページに遷移する
      visit post_path(@post1.id)
      # post1の削除ボタンがないことを確認する
      expect(page).to have_no_link '削除する', href: post_path(@post1.id)
      # post2の詳細ページに遷移する
      visit post_path(@post2.id)
      # post2の削除ボタンがないことを確認する
      expect(page).to have_no_link '削除する', href: post_path(@post2.id)
    end
  end
end

RSpec.describe '投稿詳細', type: :system do
  before do
    @post = FactoryBot.create(:post)
  end
  it 'ログインしたユーザーは詳細ページに遷移してコメント投稿欄が表示される' do
    # ログインする
    visit new_user_session_path
    fill_in 'メールアドレス', with: @post.user.email
    fill_in 'パスワード', with: @post.user.password
    find('input[name="commit"]').click
    # 投稿に「クリックして詳細を見る」があることを確認する
    expect(page).to have_link 'クリックして詳細を見る', href: post_path(@post.id)
    # 詳細ページに遷移する
    visit post_path(@post.id)
    # 詳細ページに投稿の内容が含まれている
    expect(page).to have_selector "img[src$='test_image.png']"
    expect(page).to have_content(@post.title)
    expect(page).to have_content(@post.animal_name)
    expect(page).to have_content('いぬ')
    expect(page).to have_content(@post.explanation)
    # コメント投稿用のフォームが存在する
    expect(page).to have_selector 'form'
  end
  it 'ログインしていない状態で詳細ページに遷移できるもののコメント投稿欄が表示されない' do
    # トップページに移動する
    visit root_path
    # 投稿に「クリックして詳細を見る」があることを確認する
    expect(page).to have_link 'クリックして詳細を見る', href: post_path(@post.id)
    # 詳細ページに遷移する
    visit post_path(@post.id)
    # 詳細ページに投稿の内容が含まれている
    expect(page).to have_selector "img[src$='test_image.png']"
    expect(page).to have_content(@post.title)
    expect(page).to have_content(@post.animal_name)
    expect(page).to have_content('いぬ')
    expect(page).to have_content(@post.explanation)
    # フォームが存在しないことを確認する
    expect(page).to have_no_selector 'form'
    # 「コメントの投稿には新規登録/ログインが必要です」が表示されていることを確認する
    expect(page).to have_content('コメントの投稿には新規登録/ログインが必要です')
  end
end
