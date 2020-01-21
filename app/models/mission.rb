class Mission < ApplicationRecord
  enum status: { pending: 0, processing: 1, finish: 2 }
  enum priority_order: { low_priority: -1, nomal_priority: 0, high_priority: 1 }
end
