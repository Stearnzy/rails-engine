class Api::V1::RevenueController < ApplicationController
  def show
    if params[:start].empty? || params[:end].empty?
      empty_date_error
    elsif DateTime.parse(params[:start]) > DateTime.parse(params[:end])
      backwards_date_error
    elsif DateTime.parse(params[:start]) <= DateTime.parse(params[:end])
      render json: RevenueSerializer.revenue(RevenueFacade.total_revenue_over_time(params[:start], params[:end]))
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

  def empty_date_error
    render json: JSON.generate(
      {
        error: 'dates cannot be empty'
      }
    )
  end
end
