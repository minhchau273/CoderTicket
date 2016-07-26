class Region < ActiveRecord::Base
  validates :name, inclusion: { in: ["Ho Chi Minh", "Ha Noi", "Binh Thuan", "Da Nang", "Lam Dong"] }
  validates :name, uniqueness: true
  validates :name, presence: true
end
