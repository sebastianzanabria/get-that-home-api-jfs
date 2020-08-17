class RemoveOperationTypeFromProperties < ActiveRecord::Migration[6.0]
  def change
    remove_column :properties, :operation_type, :string
  end
end
