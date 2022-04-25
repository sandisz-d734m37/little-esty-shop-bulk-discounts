require "rails_helper"

RSpec.describe InvoiceItem do
  describe "relationships" do
    it { should belong_to(:item) }
    it { should belong_to(:invoice) }
    it { should have_one(:merchant)}
    it { should have_many(:bulk_discounts)}
  end

  describe "validations" do
    it { should validate_numericality_of(:quantity) }
    it { should validate_numericality_of(:unit_price) }
    it { should validate_presence_of(:status) }
  end

  describe 'instance methods' do
    before do
      @merchant_1 = Merchant.create!(name: "Store Store")
      @merchant_2 = Merchant.create!(name: "Erots")

      @cup = @merchant_1.items.create!(name: "Cup", description: "What the **** is this thing?", unit_price: 10000)
      @soccer = @merchant_1.items.create!(name: "Soccer Ball", description: "A ball of pure soccer.", unit_price: 32000)
      @beer = @merchant_2.items.create!(name: "Beer", description: "Happiness <3", unit_price: 100)

      @customer_1 = Customer.create!(first_name: "Malcolm", last_name: "Jordan")
      @customer_2 = Customer.create!(first_name: "Jimmy", last_name: "Felony")

      @invoice_1 = @customer_1.invoices.create!(status: 1)
      @invoice_2 = @customer_1.invoices.create!(status: 2)
      @invoice_3 = @customer_2.invoices.create!(status: 0)

      @invoice_item_1 = InvoiceItem.create!(item_id: @soccer.id, invoice_id: @invoice_1.id, quantity: 1, unit_price: @soccer.unit_price, status: 1)
      @invoice_item_2 = InvoiceItem.create!(item_id: @cup.id, invoice_id: @invoice_1.id, quantity: 50, unit_price: @cup.unit_price, status: 1)

      @m1_disc1 = @merchant_1.bulk_discounts.create!(quantity_threshold: 10, percentage: 20)
      @m1_disc2 = @merchant_1.bulk_discounts.create!(quantity_threshold: 5, percentage: 50)
      @m2_disc1 = @merchant_2.bulk_discounts.create!(quantity_threshold: 7, percentage: 90)

      @m2_invoice_item = InvoiceItem.create!(item_id: @beer.id, invoice_id: @invoice_1.id, quantity: 50, unit_price: @beer.unit_price, status: 1)
    end

    it '#disc_used' do
      expect(@invoice_item_1.disc_used).to be(nil)
      expect(@invoice_item_2.disc_used).to eq(@m1_disc2)
      expect(@m2_invoice_item.disc_used).to eq(@m2_disc1)
    end
  end
end
