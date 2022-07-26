class MerchantInvoicesController < ApplicationController
  def index
    @merchant_invoices = MerchantInvoice.all
  end

  def show
  end

  def new
    @merchant_invoice = MerchantInvoice.new
  end

  def edit
  end

  def create
    @merchant_invoice = MerchantInvoice.new(merchant_invoice_params)

    respond_to do |format|
      if @merchant_invoice.save
        format.html { redirect_to merchant_invoice_url(@merchant_invoice), notice: "Merchant invoice was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @merchant_invoice.update(merchant_invoice_params)
        format.html { redirect_to merchant_invoice_url(@merchant_invoice), notice: "Merchant invoice was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @merchant_invoice.destroy

    respond_to do |format|
      format.html { redirect_to merchant_invoices_url, notice: "Merchant invoice was successfully destroyed." }
    end
  end

  private
    def merchant_invoice_params
      params.require(:merchant_invoice).permit(:merchants_id, :invoices_id)
    end
end
