require 'rails_helper'

RSpec.describe Comment, type: :model do
  before do
    @comment =  FactoryBot.build(:comment)
  end

  describe 'コメント投稿' do
    context 'コメント投稿がうまくいくとき' do
      it 'contentがあればコメント投稿ができる' do
        expect(@comment).to be_valid
      end
    end
    context 'コメント投稿がうまくいかないとき' do
      it 'contentが空だと登録できない' do
        @comment.content = ""
        @comment.valid?
        expect(@comment.errors.full_messages).to include('Contentを入力してください')
      end
      it 'ユーザーが紐づいていなければ登録できない' do
        @comment.user = nil
        @comment.valid?
        expect(@comment.errors.full_messages).to include('Userを入力してください')
      end
      it '投稿が紐付いていなければ登録できない' do
        @comment.post = nil
        @comment.valid?
        expect(@comment.errors.full_messages).to include('Postを入力してください')
      end
    end
  end
end
