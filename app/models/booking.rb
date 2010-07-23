class Booking < ActiveRecord::Base
  UNIT = 100 / 24.0 / 4
  belongs_to :event

  def margin_for(date, offset)
    quarter = [0, 15, 30, 45].index(((start_at.min/15.0).round * 15) % 60)
    (start_at.hour * 4*UNIT) + (quarter * UNIT) - offset
  end

  def width_for(date)
    (length/3600.0 * 4*UNIT) + ((length/60.0%60) * UNIT)
  end

  def length
    end_at - start_at
  end

end
