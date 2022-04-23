require "rails_helper"

describe "Discount New Page" do
  before do
    @merchant = Merchant.create!(name: "Store Store")
  end

  it "has a form to create a new merchant" do
    visit "/merchants/#{@merchant.id}/discounts"
    expect(page).to_not have_content("Discount: buy 10 get 50% off")

    click_link("New discount")

    fill_in('Quantity threshold', with: '10')
    fill_in('Percentage', with: '50')
    click_button("Create discount")

    expect(current_path).to eq("/merchant/#{@merchant.id}/discounts")
    expect(page).to have_content("Discount: buy 10 get 50% off")
  end
end
