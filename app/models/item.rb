class Item < ActiveRecord::Base
  has_many :events
  has_many :bookings, :through => :events

  validates_presence_of :name, :email

  before_create :regenerate_key

  def self.find_by_key(*args)
    super(*args) or raise NotFound
  end
  class NotFound < StandardError; end

  # Create a random string (128 ^ 32 possibilities)
  def regenerate_key
    string = Array.new(32) { rand(128).chr }.join

    self.key = Digest::MD5.hexdigest(string)
  end

  def upcoming_events
    self.events.map(&:upcoming_bookings).flatten.map(&:event)
  end

  def bookings_for(date)
    bookings_between(date, date)
  end

  def bookings_between(lower, upper)
    bookings_range(lower.at_midnight, 1.day.since(upper).at_midnight - 1)
  end

  private
    def bookings_range(lower, upper)
      self.bookings.find :all,
        :conditions => ['start_at >= ? AND end_at <= ?', lower, upper]
    end

end
