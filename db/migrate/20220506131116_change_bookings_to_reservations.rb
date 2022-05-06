class ChangeBookingsToReservations < ActiveRecord::Migration[6.1]
  def change
    rename_table :bookings, :reservations
  end
end
