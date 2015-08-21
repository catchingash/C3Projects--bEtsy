class Package < ActiveRecord::Base
  belongs_to :user
  belongs_to :buyer
  has_many :order_items

  validates :weight, :length, :width, :height, :user_id, :buyer_id, presence: true
end
