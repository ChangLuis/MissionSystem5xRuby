class Mission < ApplicationRecord
  enum status: { pending: 0, processing: 1, finish: 2 }
  enum priority_order: { low_priority: -1, nomal_priority: 0, high_priority: 1 }

  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 10 }
  validates :contents, presence: true
  validates :status, presence: true
  validates :priority_order, presence: true
  validates :initial_time_at, presence: true
  validates :finish_time_at, presence: true
end
