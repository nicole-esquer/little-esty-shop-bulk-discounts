class Merchants::InvoicesController < ApplicationController
  include ApplicationHelper

  def index
    @merchant = Merchant.find(params[:id])
    @invoices = @merchant.invoices
  end

  def show
    @invoice = Invoice.find(params[:id])
    @invoice_items = @invoice.invoice_items
    @options = InvoiceItem.statuses.keys
  end

  def edit
    @invoice_item = InvoiceItem.find(params[:id])
    @options = InvoiceItem.statuses.keys
  end

  def update
    merchant = Merchant.find(params[:id])
    @invoice_item = InvoiceItem.find(params[:id])
    respond_to do |format|
      if @invoice_item.update!(invoice_items_params)
        format.html { redirect_to merchants_invoice_url, notice: "Invoice item was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  private
  def invoice_items_params
    params.permit(:items_id, :invoices_id, :quantity, :unit_price, :status)
  end
end