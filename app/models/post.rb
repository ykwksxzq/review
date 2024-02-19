class Post < ApplicationRecord

  has_one_attached :image
  belongs_to :user
  belongs_to :genre
  belongs_to :shop

  has_many :reviews, dependent: :destroy
  has_many :post_comments, dependent: :destroy

  has_many :post_tags,dependent: :destroy
  has_many :tags,through: :post_tags

  enum status: { published: 0, draft: 1 }
  #0:公開中　1:下書き

  def get_image(width,height)
   unless image.attached?
     file_path = Rails.root.join('app/assets/images/no_image.jpg')
     image.attach(io: File.open(file_path), filename: 'no_image.jpg', content_type: 'image/jpeg')
   end
     image.variant(resize_to_limit: [width, height]).processed
  end

  def save_tag(sent_tags)
  # タグが存在していれば、タグの名前を配列として全て取得
    current_tags = self.tags.pluck(:name) unless self.tags.nil?
    # 現在取得したタグから送られてきたタグを除いてoldtagとする
    old_tags = current_tags - sent_tags
    # 送信されてきたタグから現在存在するタグを除いたタグをnewとする
    new_tags = sent_tags - current_tags

    # 古いタグを消す
    old_tags.each do |old|
      self.tags.delete　Tag.find_by(name: old)
    end

    # 新しいタグを保存
    new_tags.each do |new|
      new_post_tag = Tag.find_or_create_by(name: new)
      self.tags << new_post_tag
    end
  end

end
