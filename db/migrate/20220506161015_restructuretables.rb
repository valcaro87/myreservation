class Restructuretables < ActiveRecord::Migration[6.1]
  def change
    change_table(:guests) do |g|
      g.column :email, :string
      g.column :first_name, :string
      g.column :last_name, :string
      g.column :phone, :string, default: [], null: true, array: true
    end
  end
end
