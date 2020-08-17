class CreateRentDetails < ActiveRecord::Migration[6.0]
  def change
    create_table :rent_details do |t|
      t.integer :monthly_rent
      t.integer :maintenance

      t.timestamps
    end
  end
end
