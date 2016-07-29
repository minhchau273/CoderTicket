class Category < ActiveRecord::Base
  NAMES = ["Entertainment", "Learning", "Everything Else"]

  validates :name, presence: true, uniqueness: true, inclusion: { in: NAMES }

  def self.create_all
    NAMES.each do |name|
      Category.find_or_create_by!(name: name)
    end
  end
end
