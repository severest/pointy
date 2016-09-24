class PersonGame < ApplicationRecord
  belongs_to :person

  validates :points, numericality: { only_integer: true }
end
