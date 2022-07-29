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
     binding.pry
     if @merchant.update(admin_merchant_params)
       binding.pry
      redirect_to "/admin/merchants/#{@merchant.id}"
    else
      binding.pry
      redirect_to "/admin/merchants/#{@merchant.id}/edit"
      flash[:alert] = "Error: #{error_message(@merchant.errors)}"
    end
   end

   private
     def admin_merchant_params
       params.require(:merchant).permit(:name)
     end
 end
