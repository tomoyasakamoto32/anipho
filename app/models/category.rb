class Category < ActiveHash::Base
  self.data = [
    { id: 1, name: '--' },
    { id: 2, name: 'いぬ' },
    { id: 3, name: 'ねこ' },
    { id: 4, name: 'ウサギ' },
    { id: 5, name: 'ハムスター' },
    { id: 6, name: 'リス' },
    { id: 7, name: 'インコ・オウム' },
    { id: 8, name: 'フクロウ' },
    { id: 9, name: 'カメ' },
    { id: 10, name: 'カワウソ' },
    { id: 11, name: 'その他' }
  ]

  include ActiveHash::Associations
  has_many :posts
end
