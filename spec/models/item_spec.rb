require "rails_helper"

RSpec.describe Item do
  describe "relationships" do
    it { should have_many(:invoices) }
    it { should belong_to(:merchant) }
    it { should have_many(:bulk_discounts)}

  end

  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
    it { should validate_numericality_of(:unit_price) }
  end

  before do
    @merchant_1 = Merchant.create!(
      name: "Store Store",
      created_at: Date.current,
      updated_at: Date.current
    )

    @cup = @merchant_1.items.create!(
      name: "Cup",
      description: "What the **** is this thing?",
      unit_price: 10065,
      created_at: Date.current,
      updated_at: Date.current
    )
    @soccer = @merchant_1.items.create!(
      name: "Soccer Ball",
      description: "A ball of pure soccer.",
      unit_price: 32098,
      created_at: Date.current,
      updated_at: Date.current
    )
    @beer = @merchant_1.items.create!(
      name: "Beer",
      description: "Happiness <3",
      unit_price: 199,
      created_at: Date.current,
      updated_at: Date.current
    )
  end

  describe 'instance methods' do
    it '#to_dollars tranlates unit price to a float' do
      expect(@cup.to_dollars).to eq(100.65)
      expect(@soccer.to_dollars).to eq(320.98)
      expect(@beer.to_dollars).to eq(1.99)
    end

    it "can find the best date for sales" do
    merch_1 = Merchant.create!(name: "Two-Legs Fashion")

    item_1 = merch_1.items.create!(name: "Two-Leg Pantaloons", description: "pants built for people with two legs", unit_price: 5000)
    item_2 = merch_1.items.create!(name: "Two-Leg Shorts", description: "shorts built for people with two legs", unit_price: 3000)
    item_3 = merch_1.items.create!(name: "Hat", description: "hat built for people with two legs and one head", unit_price: 6000)
    item_4 = merch_1.items.create!(name: "Double Legged Pant", description: "pants built for people with two legs", unit_price: 50000)
    item_5 = merch_1.items.create!(name: "Stainless Steel, 5-Pocket Jean", description: "Shorts of Steel", unit_price: 3000000)
    item_6 = merch_1.items.create!(name: "String of Numbers", description: "54921752964273", unit_price: 100)

    cust_1 = Customer.create!(first_name: "Debbie", last_name: "Twolegs")
    cust_2 = Customer.create!(first_name: "Tommy", last_name: "Doubleleg")
    cust_3 = Customer.create!(first_name: "Brian", last_name: "Twinlegs")
    cust_4 = Customer.create!(first_name: "Jared", last_name: "Goffleg")
    cust_5 = Customer.create!(first_name: "Pistol", last_name: "Pete")
    cust_6 = Customer.create!(first_name: "Bronson", last_name: "Shmonson")
    cust_7 = Customer.create!(first_name: "Anten", last_name: "Branden")

    invoice_1 = cust_1.invoices.create!(status: 1, created_at: "12/30/2011")
    invoice_2 = cust_1.invoices.create!(status: 1, created_at: "06/15/2016")
    invoice_3 = cust_1.invoices.create!(status: 1, created_at: "03/14/2009")
    invoice_4 = cust_2.invoices.create!(status: 1, created_at: "04/04/2019")
    invoice_5 = cust_2.invoices.create!(status: 1, created_at: "07/13/2008")
    invoice_6 = cust_2.invoices.create!(status: 1, created_at: "10/11/2020")
    invoice_7 = cust_3.invoices.create!(status: 1, created_at: "03/14/2011")
    invoice_8 = cust_3.invoices.create!(status: 1, created_at: "03/14/2009")
    invoice_9 = cust_4.invoices.create!(status: 1, created_at: "03/14/2009")
    invoice_10 = cust_4.invoices.create!(status: 1, created_at: "03/14/2009")
    invoice_11 = cust_5.invoices.create!(status: 1, created_at: "03/14/2009")
    invoice_12 = cust_5.invoices.create!(status: 1, created_at: "03/14/2009")
    invoice_13 = cust_6.invoices.create!(status: 1, created_at: "03/14/2009")
    invoice_14 = cust_7.invoices.create!(status: 1, created_at: "03/14/2009")
    invoice_15 = cust_7.invoices.create!(status: 2, created_at: "03/14/2009")

    ii_1 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_1.id, quantity: 1, unit_price: item_1.unit_price, status: 2)
    ii_2 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_2.id, quantity: 1, unit_price: item_1.unit_price, status: 2)
    ii_3 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_3.id, quantity: 1, unit_price: item_1.unit_price, status: 2)
    ii_4 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_4.id, quantity: 1, unit_price: item_1.unit_price, status: 2)
    ii_5 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_5.id, quantity: 1, unit_price: item_1.unit_price, status: 2)
    ii_6 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_6.id, quantity: 1, unit_price: item_1.unit_price, status: 2)
    ii_7 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_7.id, quantity: 1, unit_price: item_1.unit_price, status: 2)
    ii_8 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_8.id, quantity: 1, unit_price: item_1.unit_price, status: 2)
    ii_9 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_9.id, quantity: 1, unit_price: item_1.unit_price, status: 2)
    ii_10 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_10.id, quantity: 1, unit_price: item_1.unit_price, status: 2)

    ii_11 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_11.id, quantity: 1, unit_price: item_1.unit_price, status: 2)
    ii_12 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_12.id, quantity: 1, unit_price: item_1.unit_price, status: 2)
    ii_13 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_13.id, quantity: 1, unit_price: item_1.unit_price, status: 2)
    ii_14 = InvoiceItem.create!(item_id: item_4.id, invoice_id: invoice_14.id, quantity: 500, unit_price: item_4.unit_price, status: 2)
    ii_15 = InvoiceItem.create!(item_id: item_6.id, invoice_id: invoice_14.id, quantity: 1, unit_price: item_4.unit_price, status: 2)
    ii_16 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_14.id, quantity: 30, unit_price: item_1.unit_price, status: 2)
    ii_17 = InvoiceItem.create!(item_id: item_2.id, invoice_id: invoice_14.id, quantity: 30, unit_price: item_2.unit_price, status: 2)
    ii_18 = InvoiceItem.create!(item_id: item_3.id, invoice_id: invoice_14.id, quantity: 30, unit_price: item_3.unit_price, status: 2)
    ii_19 = InvoiceItem.create!(item_id: item_5.id, invoice_id: invoice_15.id, quantity: 700, unit_price: item_4.unit_price, status: 0)

    transaction_1 = invoice_1.transactions.create!(credit_card_number: 4039485738495837, result: "success")
    transaction_2 = invoice_2.transactions.create!(credit_card_number: 4039485738495837, result: "success")
    transaction_3 = invoice_3.transactions.create!(credit_card_number: 4039485738495837, result: "success")
    transaction_4 = invoice_4.transactions.create!(credit_card_number: 4847583748374837, result: "success")
    transaction_5 = invoice_5.transactions.create!(credit_card_number: 4847583748374837, result: "success")
    transaction_6 = invoice_6.transactions.create!(credit_card_number: 4847583748374837, result: "success")
    transaction_7 = invoice_7.transactions.create!(credit_card_number: 4364756374652636, result: "success")
    transaction_8 = invoice_8.transactions.create!(credit_card_number: 4364756374652636, result: "success")
    transaction_9 = invoice_9.transactions.create!(credit_card_number: 4928294837461125, result: "success")
    transaction_10 = invoice_10.transactions.create!(credit_card_number: 4928294837461125, result: "success")
    transaction_11 = invoice_11.transactions.create!(credit_card_number: 4738473664751832, result: "success")
    transaction_12 = invoice_12.transactions.create!(credit_card_number: 4738473664751832, result: "success")
    transaction_13 = invoice_13.transactions.create!(credit_card_number: 4023948573948293, result: "success")
    transaction_14 = invoice_14.transactions.create!(credit_card_number: 4023948573948293, result: "success")
    transaction_15 = invoice_15.transactions.create!(credit_card_number: 4023948573948293, result: "success")

    expect(item_1.top_date_sales).to eq('2019-04-04')
    end
  end
end
