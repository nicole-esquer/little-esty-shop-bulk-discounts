module ApplicationHelper
  def format_date(date)
    date.strftime("%A, %B %d, %Y")
  end

  def format_price(price)
    "$#{price.to_f/100.00}"
  end
end
