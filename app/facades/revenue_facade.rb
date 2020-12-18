class RevenueFacade
  def self.total_revenue_over_time(start_date, end_date)
    starting = Date.parse(start_date).beginning_of_day
    ending = Date.parse(end_date).end_of_day

    Invoice.joins(:invoice_items, :transactions)
           .where(updated_at: starting..ending)
           .where(status: 'shipped')
           .where(transactions: { result: 'success' })
           .sum('invoice_items.unit_price * invoice_items.quantity')
  end
end
