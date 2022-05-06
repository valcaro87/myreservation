class AddGuestRefToReservations < ActiveRecord::Migration[6.1]
  def change
    add_reference :reservations, :guest, null: false, foreign_key: true
  end
end
