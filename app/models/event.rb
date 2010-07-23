class Event < ActiveRecord::Base
  TAG_RE = /\[[^]]+\]/

  belongs_to :item
  has_many   :bookings

  validates_presence_of :title, :message => "Le titre ne peut pas être vide"
  validates_length_of   :title, :within => 4...140,
                        :message => "Le titre doit faire entre 4 et 140 caractères"

  def generate_color
    digest = Digest::MD5.hexdigest(title =~ TAG_RE ? $~.to_s : self.title)

    self.color = "##{digest[0...6]}"
  end

  def upcoming_bookings
    self.bookings.
      find(:all, :conditions => ['start_at >= ?', Date.today.at_midnight])
  end

  def anchor
    'event-%s' % id.to_s(16)
  end
end
