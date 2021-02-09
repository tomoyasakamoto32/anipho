require 'rails_helper'

describe PostsController, type: :request do

  before do
    @post = FactoryBot.create(:post)
  end

  describe 'GET #index' do
    it 'indexアクションにリクエストすると正常にレスポンスが返ってくる' do 
      get root_path
      expect(response.status).to eq 200
    end
    it 'indexアクションにリクエストするとレスポンスに投稿済みのテキストが存在する' do 
      get root_path
      expect(response.body).to include(@post.title)
    end
    it 'indexアクションにリクエストするとレスポンスに投稿済みの画像が存在する' do 
      get root_path
      expect(response.body).to include('test_image.png')
    end
    it 'indexアクションにリクエストするとレスポンスに投稿検索フォームが存在する' do
      get root_path
      expect(response.body).to include('投稿を検索する')
    end
    it 'indexアクションにリクエストするとレスポンスにカテゴリー検索フォームが存在する' do
      get root_path
      expect(response.body).to include('カテゴリーで探す')
    end
  end

  describe 'GET #show' do
    it 'showアクションにリクエストすると正常にレスポンスが返ってくる' do 
    end
    it 'showアクションにリクエストするとレスポンスに投稿済みの情報が存在する' do 
    end
    it 'showアクションにリクエストするとレスポンスに投稿済みの画像が存在する' do 
    end
    it 'showアクションにリクエストするとレスポンスにコメント一覧表示部分が存在する' do 
    end
  end 
end