class Season

  def self.get_current(time = nil)
    if !time.present?
      time = Time.now.utc
    end
    return {
      :start => time.beginning_of_quarter,
      :finish => time.end_of_quarter
    }
  end

end
