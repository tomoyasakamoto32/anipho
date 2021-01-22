class Post < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category
  belongs_to :user
  has_one_attached :image
  has_many :comments, dependent: :destroy
  has_many :likes

  with_options presence: true do
   validates :image
   validates :title
   validates :category_id, numericality: { other_than: 1 , message: "は--以外から選んでください"} 
  end

  def self.search(search)
    if search != ""
      Post.where(['title LIKE(?) OR explanation LIKE(?) OR animal_name LIKE(?)', "%#{search}%", "%#{search}%", "%#{search}%"])
    else
      Post.includes(:user).order('created_at DESC')
    end
  end
end