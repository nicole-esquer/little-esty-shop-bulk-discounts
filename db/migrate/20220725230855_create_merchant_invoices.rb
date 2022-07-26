class CreateMerchantInvoices < ActiveRecord::Migration[5.2]
  def change
    create_table :merchant_invoices do |t|
      t.references :merchants, foreign_key: true
      t.references :invoices, foreign_key: true

      t.timestamps
    end
  end
end
