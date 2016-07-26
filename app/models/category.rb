class Category < ActiveRecord::Base
  validates :name, inclusion: { in: ["Entertainment", "Learning", "Everything Else"] }
  validates :name, uniqueness: true
  validates :name, presence: true
end
