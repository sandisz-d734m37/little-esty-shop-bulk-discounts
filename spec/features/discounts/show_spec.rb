require "rails_helper"

describe "merchant discount index page" do
  before do
    @merchant_1 = Merchant.create!(name: "Store Store")
    @merchant_2 = Merchant.create!(name: "Erots")

    @m1_discount1 = @merchant_1.bulk_discounts.create!( percentage: 20, quantity_threshold: 10)
    @m1_discount2 = @merchant_1.bulk_discounts.create!( percentage: 30, quantity_threshold: 20)

    @m2_discount1 = @merchant_2.bulk_discounts.create!( percentage: 50, quantity_threshold: 2)

    visit "/merchants/#{@merchant_1.id}/discounts/#{@m1_discount2.id}"
  end

end
