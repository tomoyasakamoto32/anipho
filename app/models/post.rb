class Post < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category
  belongs_to :user
  has_one_attached :image
  has_many :comments, dependent: :destroy

  with_options presence: true do
   validates :image
   validates :title
   validates :category_id, numericality: { other_than: 1 , message: "は--以外から選んでください"} 
  end
end