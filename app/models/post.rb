class Post < ApplicationRecord

  has_one_attached :image
  belongs_to :user

  validates :image, blob: { content_type: ['image/png', 'image/jpg', 'image/jpeg'], size_range: 1..(5.megabytes) },
                    presence: true, if: -> { self.body.blank? }
  validates :body, length: { in: 10..100 }, presence: true, if: -> { self.image.blank? }

end
