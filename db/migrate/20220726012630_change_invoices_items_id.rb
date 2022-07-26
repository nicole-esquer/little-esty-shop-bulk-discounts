class ChangeInvoicesItemsId < ActiveRecord::Migration[5.2]
  def change
    rename_column :invoice_items , :items_id, :item_id
    rename_column :invoice_items , :invoices_id, :invoice_id
  end
end
