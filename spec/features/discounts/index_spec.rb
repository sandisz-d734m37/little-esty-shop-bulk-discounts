require "rails_helper"

describe "merchant discount index page" do
  before do
    @merchant_1 = Merchant.create!(name: "Store Store")
    @merchant_2 = Merchant.create!(name: "Erots")

    @m1_item1 = @merchant_1.items.create!( name: "Cup", description: "What the **** is this thing?", unit_price: 10000)
    @m1_item2 = @merchant_1.items.create!( name: "Soccer Ball", description: "A ball of pure soccer.", unit_price: 32000)

    @m2_item1 = @merchant_2.items.create!( name: "Beer", description: "Happiness <3", unit_price: 100)

    @m1_discount1 = @merchant_1.bulk_discounts.create!( percentage: 20, quantity_threshold: 10)
    @m1_discount2 = @merchant_1.bulk_discounts.create!( percentage: 30, quantity_threshold: 20)

    @m2_discount1 = @merchant_2.bulk_discounts.create!( percentage: 50, quantity_threshold: 2)

    VCR.insert_cassette("displays_discounts_only_for_the_specified_merchant")

    visit "/merchants/#{@merchant_1.id}/discounts"
  end

  after do
    VCR.eject_cassette
  end

  it 'displays discounts only for the specified merchant', :vcr do
    expect(page).to have_content("Discount: buy 10 get 20% off")
    expect(page).to have_content("Discount: buy 20 get 30% off")

    expect(page).not_to have_content("Discount: buy 2 get 50% off")
  end

  it 'links to discount show page' do
    within("#discount-#{@m1_discount1.id}") do
      click_link("buy 10 get 20% off")

      expect(current_path).to eq("/discounts/#{@m1_discount1.id}")
    end
  end

  it 'includes a button to create a new discount' do
    click_link("New discount")

    expect(current_path).to eq("/merchants/#{@merchant_1.id}/discounts/new")
  end

  describe 'new castte' do
    before do
      VCR.eject_cassette
    end
    after do
      VCR.insert_cassette("displays_discounts_only_for_the_specified_merchant")
    end

    it 'lets you delete discounts with the click of a button', :vcr do
      expect(page).to have_content("Discount: buy 20 get 30% off")

      within("#discount-#{@m1_discount2.id}") do
        click_button "Delete this discount"
      end

      expect(page).not_to have_content("Discount: buy 20 get 30% off")
    end
  end

end
