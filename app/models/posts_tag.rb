class PostsTag
  include ActiveModel::Model
  attr_accessor :title, :explanation, :category_id, :animal_name, :name, :images, :user_id, :post_id

  with_options presence: true do
    validates :images
    validates :title
    validates :name
    validates :category_id, numericality: { other_than: 1 , message: "は--以外から選んでください"} 
  end

  def save
    post = Post.create(title: title, explanation: explanation, category_id: category_id, animal_name: animal_name, user_id: user_id, images: images)
    tag = Tag.where(name: name).first_or_initialize
    tag.save

    PostTagRelation.create(post_id: post.id, tag_id: tag.id)
  end

  def update
    @post = Post.where(id: post_id)
    post = @post.update(title: title, explanation: explanation, category_id: category_id, animal_name: animal_name, user_id: user_id, images: images)
    tag = Tag.where(name: name).first_or_initialize
    tag.save
    
    map = PostTagRelation.where(post_id: post_id )
    map.update(post_id: post_id, tag_id: tag.id)
  end
end