class Restructuretables < ActiveRecord::Migration[6.1]
  def change
    change_table :reservations do |r|
      r.remove :guest_first_name
      r.remove :guest_last_name
      r.remove :guest_email
      r.remove :guest_phone
    end

    change_table(:guests) do |g|
      g.column :first_name, :string
      g.column :last_name, :string
      g.column :phone, :string, default: [], null: true, array: true
    end


  end
end
