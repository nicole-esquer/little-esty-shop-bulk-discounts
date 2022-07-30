class Admin::MerchantsController < ApplicationController
   def index
      @merchants = Merchant.all
   end

   def show
     @merchant = Merchant.find(params[:id])
   end

   def new
     @merchant = Merchant.new
   end

   def create
   end

   def edit
     @merchant = Merchant.find(params[:id])
   end

   def update
     @merchant = Merchant.find(params[:id])
     if @merchant.update(admin_merchant_params)
       #format.html  redirect_to  admin_merchants, notice: "Merchant was successfully updated."
        flash[:notice] = "Your merchant has been updated."
        redirect_to "/admin/merchants/#{@merchant.id}"
    else
       redirect_to "/admin/merchants/#{@merchant.id}/edit"
      #flash[:alert] = "Error: #{error_message(@merchant.errors)}"
    end
   end

   private
     def admin_merchant_params
       params.permit(:name)
     end
 end
