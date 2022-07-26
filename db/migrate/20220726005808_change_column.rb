class ChangeColumn < ActiveRecord::Migration[5.2]
  def change
    rename_column :invoices, :customers_id, :customer_id
  end
end
