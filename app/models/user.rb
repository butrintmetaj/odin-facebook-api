class User < ApplicationRecord
  has_secure_password

  enum gender: {
    not_specified: 0,
    female: 1,
    male: 2
  }

  validates :first_name, presence: true, length: { in: 2..50 }
  validates :last_name, presence: true, length: { in: 2..50 }
  validates :email, presence: true, uniqueness: true, length: { maximum: 250 }
  validates :password, presence: true, length: { in: 8..16 }, confirmation: true
  validates :birthday, date: { before: Proc.new { Date.today } }
  validates :gender, presence: true, inclusion: { in: %w[not_specified female male], message: '%{value} is not a valid status' }

end
