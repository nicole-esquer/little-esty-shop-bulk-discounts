class Merchants::DashboardController < ApplicationController
  include ApplicationHelper

  def show

    @merchant = Merchant.find(params[:merchant_id])
  end

  private
    def merchant_params
      params.permit(:name)
    end
    def invoice_item_params
      params.permit(:item_id, :invoice_id, :quantity, :unit_price)
    end
end