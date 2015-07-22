module ApplicationHelper

  def render_stars(rating)
    output = ''
    if (1..5).include?(rating.to_i)
      rating.to_i.times { output += image_tag('star.png') }
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

  # trying to see if I can use this to log-in a newly created user
  def log_in(user)
    session[:user_id] = user.id
  end

  def logged_in?
   current_user != nil
  end

end
