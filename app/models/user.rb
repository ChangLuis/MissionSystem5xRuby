class User < ApplicationRecord
  validates :account, presence: true, uniqueness: { case_sensitive: true }
  validates :name, presence: true, length: { in: 2..30 }
  validates :password, presence: true, length: { in: 8..20 }

  has_secure_password

  has_many :missions, primary_key: :id, foreign_key: :user_id
end
