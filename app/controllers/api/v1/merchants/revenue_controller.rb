class Api::V1::Merchants::RevenueController < ApplicationController
  def index
    render json: MerchantSerializer.new(Merchant.most_revenue(params[:quantity].to_i))
  end

  def show
    render json: MerchantSerializer.new(Merchant.total_revenue(params[:id].to_i))
  end
end