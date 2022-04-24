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
    click_button("Save")

    expect(current_path).to eq("/merchants/#{@merchant.id}/discounts")
    expect(page).to have_content("Discount: buy 10 get 50% off")
  end


  it "displays error message if info is not input correctly" do
    visit "/merchants/#{@merchant.id}/discounts/new"

    fill_in('Quantity threshold', with: '10')
    fill_in('Percentage', with: '300')
    click_button("Save")

    expect(current_path).to eq("/merchants/#{@merchant.id}/discounts/new")
    expect(page).to have_content("Error: • quantity threshold and percentage must not be blank • percentage must be between 0 and 100")
  end

  it "displays error message if info is not input correctly" do
    visit "/merchants/#{@merchant.id}/discounts/new"

    fill_in('Quantity threshold', with: '10')
    click_button("Save")

    expect(current_path).to eq("/merchants/#{@merchant.id}/discounts/new")
    expect(page).to have_content("Error: • quantity threshold and percentage must not be blank • percentage must be between 0 and 100")
  end
end
