class Merchants::ItemsController < ApplicationController
  include ApplicationHelper

  def index
    @merchant = Merchant.find(params[:id])
    @enabled_items = Item.enabled_items(params[:id])
    @disabled_items = Item.disabled_items(params[:id])
  end

  def show
    @merchant = Merchant.find(params[:id])
    @item = Item.find(params[:id])
  end

  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])
  end

  def change_status
    merchant = Merchant.find(params[:merchant_id])
    item = Item.find(params[:item_id])
    item.update_status(item)
    redirect_to merchants_items_path(merchant.id)
  end

  def update
    @item = Item.find(params[:id])

    if params[:update_status]
      if @item.update_status
        redirect_to merchants_items_path(@merchant.id), notice: "Item status has been successfully updated!"
      else
        render :edit, status: :unprocessable_entity
      end
    end

    if params[:merchant] 
      @merchant = Merchant.find(params[:merchant][:id])
    end
  end

  private
    def merchants_item_params
      params.permit(:merchant_id, :name, :description, :unit_price, :status)
    end
end