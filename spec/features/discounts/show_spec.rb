require "rails_helper"

describe "merchant discount index page" do
  before do
    @merchant_1 = Merchant.create!(name: "Store Store")

    @m1_discount1 = @merchant_1.bulk_discounts.create!(quantity_threshold: 10, percentage: 20)
    @m1_discount2 = @merchant_1.bulk_discounts.create!(quantity_threshold: 20, percentage: 30)

    visit "/discounts/#{@m1_discount2.id}"
  end

  it 'displays pertinent information' do
    expect(page).to have_content("With purchase of 20, customer's recieve 30% off")
    expect(page).not_to have_content("With purchase of 10, customer's recieve 20% off")
  end
end
