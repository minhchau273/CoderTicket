class Region < ActiveRecord::Base
  NAMES = ["Ho Chi Minh", "Ha Noi", "Binh Thuan", "Da Nang", "Lam Dong"]

  validates :name, presence: true, uniqueness: true, inclusion: { in: NAMES }

  def self.create_all
    NAMES.each do |name|
      Region.find_or_create_by!(name: name)
    end
  end
end
