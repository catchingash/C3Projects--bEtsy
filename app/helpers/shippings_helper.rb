module ShippingsHelper

  def convert_to_money(price)
  in_dollars = (price.to_f/100)
  number_to_currency(in_dollars)
  end

end
