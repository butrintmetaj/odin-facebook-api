class Comment < ApplicationRecord
  include Likeable

  belongs_to :user
  belongs_to :post

  validates :body, length: { in: 10..100 }, presence: true

end
