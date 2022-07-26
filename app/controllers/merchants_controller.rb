class MerchantsController < ApplicationController
  def index
  end

  def show
    require 'pry'; binding.pry 
    @merchant = Merchant.find(params[:id])
  end

  def new
  end

  def create
  end

  def destroy
  end

  def edit
  end
end
