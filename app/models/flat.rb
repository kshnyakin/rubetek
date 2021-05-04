class Flat < ApplicationRecord
  has_many :counters
  belongs_to :user
end
