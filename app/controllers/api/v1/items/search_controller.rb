class Api::V1::Items::SearchController < ApplicationController
  def index
    render json: ItemSerializer.new(Item.find_all(search_key, search_value))
  end

  def show
    render json: ItemSerializer.new(Item.find_one(search_key, search_value))
  end

  private

  def search_params
    params.permit(:name, :description, :unit_price, :created_at, :updated_at)
  end

  def search_key
    search_params.keys.first
  end

  def search_value
    search_params[search_key]
  end
end