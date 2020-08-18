class AddDetailsToProperties < ActiveRecord::Migration[6.0]
  def change
    add_column :properties, :price, :decimal
    add_column :properties, :maintenance, :decimal
  end
end
