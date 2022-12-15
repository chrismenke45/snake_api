class Record < ApplicationRecord
  validates :name, presence: true, length: { in: 2..14 }
  validates :score, presence: true, numericality: { less_than_or_equal_to: 10000 }
end
