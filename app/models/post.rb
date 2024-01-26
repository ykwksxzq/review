class Post < ApplicationRecord

  has_one_attached :image
  belongs_to :user
  belongs_to :genre
  belongs_to :shop
  
  has_many :reviews, dependent: :destroy
  has_many :post_comments, dependent: :destroy

end
