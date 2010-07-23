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

  def validate
    if self[:start_at] > self[:end_at]
      errors.add_to_base("Date de départ et de fin incohérentes.")
    end

    bs = self.event.item.bookings.count(:conditions =>
      ['(start_at > ? AND start_at < ?) OR'+
       '(end_at   > ? AND end_at   < ?)',
       self[:start_at], self[:end_at],
       self[:start_at], self[:end_at]])
    errors.add_to_base("Conflit de date.") unless bs.zero?
  end

end
