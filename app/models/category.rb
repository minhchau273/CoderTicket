class Category < ActiveRecord::Base
  NAMES = ["Entertainment", "Learning", "Everything Else"]

  validates :name, inclusion: { in: NAMES }
  validates :name, uniqueness: true
  validates :name, presence: true

  def self.create_all
    NAMES.each do |name|
      Category.find_or_create_by!(name: name)
    end
  end
end
