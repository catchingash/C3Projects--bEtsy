class Buyer < ActiveRecord::Base
  belongs_to :order
  has_many :packages

  # CALLBACK
  after_validation :convert_to_last_four

  # VALIDATIONS ----------------------------------------------------------
  validates :name,        presence: true
  validates :email,       presence: true, format: /@/
  validates :address,     presence: true
  validates :city,        presence: true
  validates :state,       presence: true,
                          length: { is: 2 }
  validates :zip,         presence: true,
                          numericality: { only_integer: true },
                          length: { in: 4..5}
  validates :country,     presence: true
  validates :exp,         presence: true
  validates :credit_card, presence: true,
                          numericality: { only_integer: true },
                          length: { in: 14..16 }

  private

    def convert_to_last_four
      array = self.credit_card.to_s.split("")
      return self.credit_card unless array.length >= 4
      last_four = array[-4..-1].join.to_i
      self.credit_card = last_four
    end
end
