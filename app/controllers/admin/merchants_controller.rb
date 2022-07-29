class Admin::MerchantsController < ApplicationController
   def index
      @merchants = Merchant.all
   end

   def show
     @merchants = Merchant.find(params[:merchant_id])
   end

   def edit
     @merchants = Merchant.find(params[:id])
   end

   def update
     @merchant = Merchant.find(params[:id])
     if merchant.update(admin_merchant_params)
      redirect_to "/admin/merchants/#{merchant.id}"
    else
      redirect_to "/admin/merchants/#{merchant.id}/edit"
      flash[:alert] = "Error: #{error_message(merchant.errors)}"
    end
   end

   private
     def admin_merchant_params
       params.require(:merchant).permit(:name)
     end
 end
