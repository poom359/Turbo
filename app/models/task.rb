class Task < ApplicationRecord
  belongs_to :task_category  # เปลี่ยนจาก category เป็น task_category
  validates :title, presence: true
  validates :status, inclusion: { in: %w[incomplete complete] }
end
