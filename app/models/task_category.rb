class TaskCategory < ApplicationRecord
    has_many :tasks  # TaskCategory จะมีงานหลายงาน
  end
  