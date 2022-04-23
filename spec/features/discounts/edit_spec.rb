require "rails_helper"

describe "Discount Edit Page" do
  before do
    @merchant = Merchant.create!(name: "Store Store")
    @m_discount = @merchant.bulk_discounts.create!( percentage: 20, quantity_threshold: 10)
  end

  it "has a form to edit the current merchant" do
    visit "/merchants/#{@merchant.id}/discounts"
    expect(page).to have_content("Discount: buy 10 get 20% off")

    within "#discount-#{@m_discount.id}" do
      click_button("Edit this discount")
    end

    fill_in('Quantity threshold', with: '10')
    fill_in('Percentage', with: '50')
    click_button("Save")
    expect(current_path).to eq("/merchants/#{@merchant.id}/discounts")

    expect(page).not_to have_content("Discount: buy 10 get 20% off")
    expect(page).to have_content("Discount: buy 10 get 50% off")
  end


  it "displays error message if info is not input correctly" do
    visit "/discounts/#{@m_discount.id}/edit"

    fill_in('Quantity threshold', with: '10')
    fill_in('Percentage', with: '300')
    click_button("Save")

    expect(current_path).to eq("/discounts/#{@m_discount.id}/edit")
    expect(page).to have_content("Error: • quantity threshold and percentage must not be blank • percentage must be between 0 and 100")
  end

  it "displays error message if info is not input correctly" do
    visit "/discounts/#{@m_discount.id}/edit"

    fill_in('Quantity threshold', with: '')
    click_button("Save")

    expect(current_path).to eq("/discounts/#{@m_discount.id}/edit")
    expect(page).to have_content("Error: • quantity threshold and percentage must not be blank • percentage must be between 0 and 100")
  end
end
