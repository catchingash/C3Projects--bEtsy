module OrdersHelper

  def item_total(order)
    items = OrderItem.where("order_id = ?", order.id).pluck(:quantity)
    @total_quantity = items.sum
  end
end
