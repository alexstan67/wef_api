class Airport < ApplicationRecord
  ACCEPTED_COUNTRIES = [ "LU", "DE", "FR", "CH" ].freeze
  ACCEPTED_AIRPORT_TYPES = [ "small_airport", "medium_airport", "large_airport" ].freeze
  validates :icao, presence: true
  validates :name, format: { without: /ET[A-Z]{2}/, message: "No German military airbase" }
  validates :name, format: { without: /(Air Base)/, message: "No French military airbase" }
  validates :continent, presence: true, length: { maximum: 2 }
  validates :country, presence: true, length: { maximum: 2 }, inclusion: { in: ACCEPTED_COUNTRIES }
  validates :airport_type, presence: true, inclusion: { in: ACCEPTED_AIRPORT_TYPES }
end
