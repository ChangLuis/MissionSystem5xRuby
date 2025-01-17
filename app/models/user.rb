class User < ApplicationRecord
  before_destroy -> { throw :abort }, if: -> { is_admin? && User.is_admin.count.eql?(1) }

  validates :account, presence: true, uniqueness: { case_sensitive: true }
  validates :name, presence: true, length: { in: 2..30 }

  PASSWORD_REGEX = /\A[a-zA-Z0-9]+\z/.freeze
  validates :password,
            confirmation: true,
            length: { in: 8..20 },
            format: { with: PASSWORD_REGEX },
            allow_nil: true

  has_secure_password

  has_many :missions, primary_key: :id, foreign_key: :user_id, dependent: :delete_all

  scope :include_missions, -> { includes(:missions) }
  scope :not_admin, -> { include_missions.where(is_admin: false) }
  scope :is_admin, -> { where(is_admin: true) }
  scope :fetch_specific_user, ->(id) { include_missions.find(id) }
end
