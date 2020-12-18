class Api::V1::RevenueController < ApplicationController
  def show
    if DateTime.parse(params[:start]) <= DateTime.parse(params[:end])
      render json: RevenueSerializer.revenue(RevenueFacade.total_revenue_over_time(params[:start], params[:end]))
    else
      backwards_date_error
    end
  end

  private

  def backwards_date_error
    render json: JSON.generate(
      {
        error: 'end date occurs before start date'
      }
    )
  end
end
