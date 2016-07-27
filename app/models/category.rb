class Category < ActiveRecord::Base
  NAMES = ["Entertainment", "Learning", "Everything Else"]

  validates :name, inclusion: { in: NAMES }
  validates :name, uniqueness: true
  validates :name, presence: true
end
