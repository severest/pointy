class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.get_random
    count = self.count()
    if count == 0
      nil
    else
      random_number = rand(count) - 1
      self.all()[random_number]
    end
  end
end
