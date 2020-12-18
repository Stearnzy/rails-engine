class Api::V1::RevenueController < ApplicationController
  def show
    render json: RevenueSerializer.revenue(RevenueFacade.total_revenue_over_time(params[:start], params[:end]))
  end
end
