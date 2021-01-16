require 'rails_helper'

RSpec.describe Post, type: :model do
  before do
    @post = FactoryBot.build(:post)
  end
  describe "新規投稿" do
    context '投稿がうまくいくとき' do
      it 'imageとtitleとexplanationとanimal_nameとcategory_idが存在すれば投稿できる' do
        expect(@post).to be_valid
      end
      it 'explanationが空でも投稿できる' do
        @post.explanation = ""
        expect(@post).to be_valid
      end
      it 'animal_nameが空でも投稿できる' do
        @post.animal_name = ""
        expect(@post).to be_valid
      end
    end
    context '投稿がうまくいかないとき' do
      it 'imageが空だと登録できない' do
        @post.image = nil
        @post.valid?
        expect(@post.errors.full_messages).to include('ペットの写真を入力してください')
      end
      it 'titleが空だと投稿できない' do
        @post.title = ""
        @post.valid?
        expect(@post.errors.full_messages).to include('写真のタイトルを入力してください')
      end
      it 'category_idが1だと投稿できない' do
        @post.category_id = 1
        @post.valid?
        expect(@post.errors.full_messages).to include('ペットの種類は--以外から選んでください')
      end
      it 'ユーザーが紐づいていなければ登録できない' do
        @post.user = nil
        @post.valid?
        expect(@post.errors.full_messages).to include('Userを入力してください')
      end
    end
  end
end
