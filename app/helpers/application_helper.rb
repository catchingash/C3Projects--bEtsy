module ApplicationHelper

  def render_stars(rating)
    output = ''
    if (1..5).include?(rating)
      rating.times { output += image_tag('star.png') }
    end
    output.html_safe
  end

  def avg_rating(product_id)
    ratings = Review.where(product_id: product_id).pluck(:rating)
    # protects for divide by 0
    ratings.size == 0 ? 0 : ratings.sum / ratings.size
  end

  # used in user_controller private method
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def current_user?(user)
    user == current_user
  end

  # log-in a newly created user
  def log_in(user)
    session[:user_id] = user.id
  end

  def logged_in?
   current_user != nil
  end

  def transaction
    order = Order.find(session[:order_id])
    order.order_items.each do |item|
      product = item.product
      bought = item.quantity #how many were bought
      inventory = product.stock #inventory

      new_inventory = inventory - bought
      product.update(stock: new_inventory)
      item.update(status: 'paid')
    end

    order.update(status: 'paid')
  end

  def us_states
   [
     ['Alabama', 'AL'],
     ['Alaska', 'AK'],
     ['Arizona', 'AZ'],
     ['Arkansas', 'AR'],
     ['California', 'CA'],
     ['Colorado', 'CO'],
     ['Connecticut', 'CT'],
     ['Delaware', 'DE'],
     ['District of Columbia', 'DC'],
     ['Florida', 'FL'],
     ['Georgia', 'GA'],
     ['Hawaii', 'HI'],
     ['Idaho', 'ID'],
     ['Illinois', 'IL'],
     ['Indiana', 'IN'],
     ['Iowa', 'IA'],
     ['Kansas', 'KS'],
     ['Kentucky', 'KY'],
     ['Louisiana', 'LA'],
     ['Maine', 'ME'],
     ['Maryland', 'MD'],
     ['Massachusetts', 'MA'],
     ['Michigan', 'MI'],
     ['Minnesota', 'MN'],
     ['Mississippi', 'MS'],
     ['Missouri', 'MO'],
     ['Montana', 'MT'],
     ['Nebraska', 'NE'],
     ['Nevada', 'NV'],
     ['New Hampshire', 'NH'],
     ['New Jersey', 'NJ'],
     ['New Mexico', 'NM'],
     ['New York', 'NY'],
     ['North Carolina', 'NC'],
     ['North Dakota', 'ND'],
     ['Ohio', 'OH'],
     ['Oklahoma', 'OK'],
     ['Oregon', 'OR'],
     ['Pennsylvania', 'PA'],
     ['Puerto Rico', 'PR'],
     ['Rhode Island', 'RI'],
     ['South Carolina', 'SC'],
     ['South Dakota', 'SD'],
     ['Tennessee', 'TN'],
     ['Texas', 'TX'],
     ['Utah', 'UT'],
     ['Vermont', 'VT'],
     ['Virginia', 'VA'],
     ['Washington', 'WA'],
     ['West Virginia', 'WV'],
     ['Wisconsin', 'WI'],
     ['Wyoming', 'WY']
    ]
  end

end
