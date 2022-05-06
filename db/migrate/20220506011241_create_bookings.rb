class CreateReservations < ActiveRecord::Migration[6.1]
  def change
    create_table :reservations do |t|
      t.string :reservation_code
      t.date :start_date
      t.date :end_date
      t.integer :nights
      t.integer :guests
      t.integer :adults
      t.integer :children
      t.integer :infants
      t.string :localized_description
      t.string :status
      t.string :guest_first_name
      t.string :guest_last_name
      t.string :guest_phone, default: [], null: true, array: true
      t.string :guest_email
      t.string :currency
      t.decimal :payout_price, precision: 8, scale: 2
      t.decimal :security_price, precision: 8, scale: 2
      t.decimal :total_price, precision: 8, scale: 2
      t.timestamps
    end
  end
end
