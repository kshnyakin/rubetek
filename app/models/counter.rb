class Counter < ApplicationRecord
  belongs_to :flat

  enum water_type: {
      hot:  100,
      cold: 200,
  }

  validate :compare_old_value

  def compare_old_value
    if (Counter.where(water_type: self.water_type).size > 0) && 
      (Counter.where(water_type: self.water_type)&.last&.value > self.value)
      errors.add(:user_id, "введено показание меньше, чем в предыдущем месяце")
    end
  end

end
