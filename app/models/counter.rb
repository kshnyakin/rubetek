class Counter < ApplicationRecord
  belongs_to :flat

  enum water_type: {
      hot:  100,
      cold: 200,
  }
end
