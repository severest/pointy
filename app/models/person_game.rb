class PersonGame < ApplicationRecord
  belongs_to :person
  belongs_to :game

  validates :points, numericality: { only_integer: true, :greater_than_or_equal_to => 0 }
  validates :win, inclusion: { in: [ true, false ] }
end
