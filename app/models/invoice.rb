class Invoice < ApplicationRecord
  validates :status, presence: true

  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items
  has_many :transactions
  belongs_to :customer

  enum status: { "in_progress" => 0, "completed" => 1, "cancelled" => 2 }

  def invoice_total
    total = invoice_items
    .group(:invoice_id)
    .sum("invoice_items.unit_price * invoice_items.quantity")

    total[id]/100.0
  end

  def has_items_not_shipped
    invoice_items.where.not(status: 2).empty?
  end

  def self.oldest_first
    Invoice.order(:created_at)
  end
end
