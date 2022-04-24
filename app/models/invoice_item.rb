class InvoiceItem < ApplicationRecord
  validates :item_id, presence: true
  validates :invoice_id, presence: true
  validates :quantity, presence: true, numericality: true
  validates :unit_price, presence: true, numericality: true
  validates :status, presence: true, numericality: true

  belongs_to :item
  belongs_to :invoice

  has_one :merchant, through: :item
  has_many :bulk_discounts, through: :merchant

  enum status: {"pending" => 0, "packaged" => 1, "shipped" => 2}

  def discount_that_price
    disc_to_use = bulk_discounts
    .where("quantity_threshold <= ?", quantity)
    .maximum(:percentage)

    if disc_to_use.nil?
      return 0
    else
      (quantity * unit_price) * (disc_to_use / 10000.0).to_f
    end
  end
end
