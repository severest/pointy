class Season

  def self.get_current
    time = Time.now.utc
    return {
      :start => time.beginning_of_quarter,
      :finish => time.end_of_quarter
    }
  end

end
