class InvoiceItemsController < ApplicationController
  def index
    @invoice_items = InvoiceItem.all
  end

  def show
    @invoice = Invoice.find(params[:id])
    @options = InvoiceItem.statuses.keys
  end

  def new
    @invoice_item = InvoiceItem.new
  end

  def edit
    @invoice = Invoice.find(params[:id])
    @options = InvoiceItem.statuses.keys
  end

  def create
    @invoice_item = InvoiceItem.new(invoice_item_params)

    respond_to do |format|
      if @invoice_item.save
        format.html { redirect_to invoice_item_url(@invoice_item), notice: "Invoice item was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @invoice_item.update(invoice_item_params)
        format.html { redirect_to invoice_item_url(@invoice_item), notice: "Invoice item was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @invoice_item.destroy

    respond_to do |format|
      format.html { redirect_to invoice_items_url, notice: "Invoice item was successfully destroyed." }
    end
  end

  private
    def invoice_item_params
      params.require(:invoice_item).permit(:items_id, :invoices_id, :quantity, :unit_price, :status)
    end
end
