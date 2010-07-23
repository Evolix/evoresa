class CreateBookings < ActiveRecord::Migration
  def self.up
    create_table :bookings do |t|
      t.timestamp :start_at
      t.timestamp :end_at
      t.references :event

      t.timestamps
    end
  end

  def self.down
    drop_table :bookings
  end
end
