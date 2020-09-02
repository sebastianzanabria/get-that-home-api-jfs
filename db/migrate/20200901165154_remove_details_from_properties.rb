class RemoveDetailsFromProperties < ActiveRecord::Migration[6.0]
  def change
    remove_column :properties, :district, :string
    remove_column :properties, :province, :string
  end
end
