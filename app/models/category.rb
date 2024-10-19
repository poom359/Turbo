# app/models/category.rb
class Category < ApplicationRecord
    has_many :tasks, dependent: :destroy  # หมวดหมู่หนึ่งเชื่อมโยงกับหลายงาน
    validates :name, presence: true
  end
  