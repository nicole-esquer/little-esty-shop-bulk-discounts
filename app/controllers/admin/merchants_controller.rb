class Admin::MerchantsController < ApplicationController
   def index
      @merchants = Merchant.all
   end

   def show
     @merchants = Merchant.find(params[:id])
   end

   def edit
     @merchants = Merchant.find(params[:id])
   end

   def update
     @merchant = Merchant.find(params[:id])
     if merchant.update(merchant_params)
      redirect_to "/merchants/#{merchant.id}"
    else
      redirect_to "/merchants/#{merchant.id}/edit"
      flash[:alert] = "Error: #{error_message(merchant.errors)}"
    end
   end
end
