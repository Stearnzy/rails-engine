class Api::V1::Merchants::SearchController < ApplicationController
  def show
    render json: MerchantSerializer.new(Merchant.find_one(search_key, search_value))
  end

  private

  def search_params
    params.permit(:name, :created_at, :updated_at)
  end

  def search_key
    search_params.keys.first
  end

  def search_value
    search_params[search_key]
  end
end
