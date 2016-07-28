class Event < ActiveRecord::Base
  belongs_to :venue
  belongs_to :category
  has_many :ticket_types

  validates :name, :extended_html_description, :venue, :category, :starts_at, presence: true
  validates :name, uniqueness: { scope: [:venue_id, :starts_at] }

  scope :upcoming, -> { where('starts_at > ?', DateTime.current).order(:starts_at) }

  delegate :name, to: :category, prefix: true
  delegate :region_name, to: :venue

  def starts_at_to_s
    starts_at.strftime(FULL_DATE_FORMAT)
  end

  def starts_at_to_month
    starts_at.strftime(FULL_MONTH_FORMAT)
  end

  def starts_at_to_day
    starts_at.strftime(DAY_FORMAT)
  end

  def min_price
    ticket_types.map { |type| type.price  }.min
  end
end
