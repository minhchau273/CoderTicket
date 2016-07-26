class Venue < ActiveRecord::Base
  belongs_to :region
  validates :name, uniqueness: true
  validates :name, presence: true
end
