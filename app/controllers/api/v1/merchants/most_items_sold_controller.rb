class Api::V1::Merchants::MostItemsSoldController < ApplicationController
  def index
    render json: MerchantSerializer.new(Merchant.most_items_sold(params[:quantity].to_i))
  end
end