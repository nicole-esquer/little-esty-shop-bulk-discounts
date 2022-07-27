class MerchantItemsController < ApplicationController
    def index
        @merchant = Merchant.find(params[:merchant_id])
    end

    def show
        @merchant = Merchant.find(params[:merchant_id])
        @item = Item.find(params[:id])
    end

    def edit
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])
    @name = @item.name
    end

  def update
    item = Item.find(params[:id])
    if item.update(item_params)
      redirect_to "/merchants/#{@merchant.id}/items/#{@item.id}"
      flash[:alert] = "Information has been successfully updated!"
    else
      redirect_to "/merchants/#{@merchant.id}/items/#{@item.id}/edit"
    #   flash[:alert] = "Error: #{error_message(item.errors)}"
    end
  end
end