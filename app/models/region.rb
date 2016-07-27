class Region < ActiveRecord::Base
  NAMES = ["Ho Chi Minh", "Ha Noi", "Binh Thuan", "Da Nang", "Lam Dong"]

  validates :name, inclusion: { in: NAMES }
  validates :name, uniqueness: true
  validates :name, presence: true
end
