class ItemsController < ApplicationController
  include ApplicationHelper

  def index
    @items = Item.all
    @merchant = Merchant.find(params[:merchant_id])
    @merchant_items = @merchant.items.enabled
    # @enabled_items = InvoiceItem.enabled
    # @disabled_items = InvoiceItem.disabled
  end

  def show
    @item = Item.find(params[:id])
    @merchant = Merchant.find(params[:merchant_id])
  end

  def new
    @item = Item.new
  end

  def edit
    if params[:merchant_id]
      @merchant = Merchant.find(params[:merchant_id])
      @item = @merchant.items.find(params[:item][:id])
    end
    @item = Item.find(params[:id])
    # @name = @item.name
  end

  def create
    # @item = Item.new(item_params)
    respond_to do |format|
      if @item.save
        format.html { redirect_to item_url(@item), notice: "Item was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    if params[:merchant_id] 
      @merchant = Merchant.find(params[:merchant_id])
    end
    @item = Item.find(params[:id])
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to merchant_items_url(@merchant), notice: "Information has been successfully updated!" }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def change_status
    require 'pry'; binding.pry 
    @item = Item.find(params[:id])
    @item.update_status
    redirect_to merchant_items_path(@merchant.id)
  end

  def destroy
    @item.destroy

    respond_to do |format|
      format.html { redirect_to items_url, notice: "Item was successfully destroyed." }
    end
  end

  private
    def item_params
      params.require(:item).permit(:merchant_id, :name, :description, :unit_price, :status)
    end
end
# <h4><p><%= link_to pet.name, "/pets/#{pet.id}" %><%= button_to "Add Pet '#{pet.name}'", "/applications/#{@application.id}", method: :post, params: {pet_id: pet.id} %></p></h4>