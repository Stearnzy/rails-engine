class Api::V1::RevenueController < ApplicationController
  def show
    if DateTime.parsable?(params[:start]) && DateTime.parsable?(params[:end])
      if DateTime.parse(params[:start]) > DateTime.parse(params[:end])
        backwards_date_error
      elsif DateTime.parse(params[:start]) <= DateTime.parse(params[:end])
        render json: RevenueSerializer.revenue(RevenueFacade.total_revenue_over_time(params[:start], params[:end]))
      end
    else
      date_invalid_error
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

  def date_invalid_error
    render json: JSON.generate(
      {
        error: 'dates must be valid'
      }
    )
  end

  def DateTime.parsable?(string)
    parse(string)
    true
  rescue ArgumentError
    false
  end
end
