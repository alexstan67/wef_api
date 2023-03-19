class Country < ApplicationRecord
  validates :code, presence: true
  validates :name, presence: true
  validates :continent, presence: true

  validates_length_of :code, is: 2
  validates_length_of :continent, is: 2
end
