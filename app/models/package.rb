class Package < ActiveRecord::Base
  belongs_to :user
  belongs_to :buyer
  has_many :order_items
end
