class Shipping < ActiveRecord::Base
  # Associations
  belongs_to :order

  # Validations
  validates :order_id, presence: true, numericality: { only_integer: true }
  validates :price, presence: true, numericality: true
  validates :carrier, :service_name, presence: true
end
