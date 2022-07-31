class Admin::MerchantsController < ApplicationController
   def index
      @merchants = Merchant.all
    #  @enabled_merchants = Merchant.enabled_merchants(params[:id])
    #  @disabled_merchants = Merchant.disabled_merchants(params[:id])
   end

   def show
     @merchant = Merchant.find(params[:id])
   end

   def new
     @merchant = Merchant.new
   end

   def create
        merchant = Merchant.create(name: params[:name], created_at: Time.now, updated_at: Time.now)
        redirect_to "/admin/merchants"
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


    def update_status(merchant)
      if merchant.status == 'enabled'
       merchant.status = 'disabled'
       merchant.save
     else
       merchant.status = 'enabled'
       merchant.save
     end
   end

   private
     def admin_merchant_params
       params.permit(:merchant_id, :name, :status)
     end
 end
end
