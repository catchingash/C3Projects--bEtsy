class User < ActiveRecord::Base
  before_save { self.email = email.downcase }
  has_many :products
  has_many :packages
  has_many :order_items, :through => :products

  validates :name,    presence: true, uniqueness: { case_sensitive: false }
  validates :email,   presence: true, uniqueness: { case_sensitive: false }, format: /@/
  validates :address, presence: true
  validates :city,    presence: true
  validates :state,   presence: true,
                      length: { is: 2 }
  validates :zip,     presence: true,
                      numericality: { only_integer: true },
                      length: { in: 4..5}
  validates :country, presence: true

  has_secure_password
end
