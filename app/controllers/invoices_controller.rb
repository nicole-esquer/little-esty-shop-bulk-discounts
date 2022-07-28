class InvoicesController < ApplicationController
  include ApplicationHelper

  def index
    @merchant = Merchant.find(params[:merchant_id])
    @invoices = @merchant.invoices
  end

  def show
    @invoice = Invoice.find(params[:id])
    @invoice_items = @invoice.invoice_items
  end
  
  def new
    @invoice = Invoice.new
  end
  
  def edit
  end

  def create
    @invoice = Invoice.new(invoice_params)

    respond_to do |format|
      if @invoice.save
        format.html { redirect_to invoice_url(@invoice), notice: "Invoice was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @invoice.update(invoice_params)
        format.html { redirect_to invoice_url(@invoice), notice: "Invoice was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @invoice.destroy

    respond_to do |format|
      format.html { redirect_to invoices_url, notice: "Invoice was successfully destroyed." }
    end
  end

  private
    def invoice_params
      params.require(:invoice).permit(:customer_id, :status)
    end
end
