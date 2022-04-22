class BulkDiscount < ApplicationRecord
  belongs_to :merchant


  validates :percentage, numericality: {greater_than: 0, less_than: 100}
  validates :quantity_threshold, numericality: {greater_than: 0}
end
