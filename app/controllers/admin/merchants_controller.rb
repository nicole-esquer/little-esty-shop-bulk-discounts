class Admin::MerchantsController < ApplicationController
   def index
      @merchants = Merchant.all
   end

   def show
     @merchants = Merchant.all

   end
end
