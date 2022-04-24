require "rails_helper"

RSpec.describe Invoice do
  describe "relationships" do
    it { should have_many(:items) }
    it { should have_many(:transactions) }
    it { should belong_to(:customer) }
  end

  describe "validations" do
    it { should validate_presence_of(:status) }
  end

  describe "methods" do
    before :each do
      @merchant_1 = Merchant.create!(
        name: "Store Store",
        created_at: Date.current,
        updated_at: Date.current
      )
      @merchant_2 = Merchant.create!(
        name: "Erots",
        created_at: Date.current,
        updated_at: Date.current
      )

      @cup = @merchant_1.items.create!(
        name: "Cup",
        description: "What the **** is this thing?",
        unit_price: 10000,
        created_at: Date.current,
        updated_at: Date.current
      )
      @soccer = @merchant_1.items.create!(
        name: "Soccer Ball",
        description: "A ball of pure soccer.",
        unit_price: 32000,
        created_at: Date.current,
        updated_at: Date.current
      )

      @beer = @merchant_2.items.create!(
        name: "Beer",
        description: "Happiness <3",
        unit_price: 100,
        created_at: Date.current,
        updated_at: Date.current
      )

      @customer_1 = Customer.create!(
        first_name: "Malcolm",
        last_name: "Jordan",
        created_at: Date.current,
        updated_at: Date.current
      )
      @customer_2 = Customer.create!(
        first_name: "Jimmy",
        last_name: "Felony",
        created_at: Date.current,
        updated_at: Date.current
      )

      @invoice_1 = @customer_1.invoices.create!(
        status: 1,
        created_at: Date.new(2020, 12, 12),
        updated_at: Date.current
      )
      @invoice_2 = @customer_1.invoices.create!(
        status: 2,
        created_at: Date.new(2021, 12, 12),
        updated_at: Date.current
      )
      @invoice_3 = @customer_2.invoices.create!(
        status: 0,
        created_at: Date.new(1999, 12, 12),
        updated_at: Date.current
      )

      @invoice_item_1 = InvoiceItem.create!(
        item_id: @soccer.id,
        invoice_id: @invoice_1.id,
        quantity: 1,
        unit_price: @soccer.unit_price,
        status: 1,
        created_at: Date.current,
        updated_at: Date.current
      )
      @invoice_item_2 = InvoiceItem.create!(
        item_id: @cup.id,
        invoice_id: @invoice_1.id,
        quantity: 50,
        unit_price: @cup.unit_price,
        status: 1,
        created_at: Date.current,
        updated_at: Date.current
      )
      @invoice_item_3 = InvoiceItem.create!(
        item_id: @soccer.id,
        invoice_id: @invoice_2.id,
        quantity: 500,
        unit_price: @soccer.unit_price,
        status: 0,
        created_at: Date.current,
        updated_at: Date.current
      )

      @invoice_item_4 = InvoiceItem.create!(
        item_id: @beer.id,
        invoice_id: @invoice_3.id,
        quantity: 2,
        unit_price: @beer.unit_price,
        status: 2,
        created_at: Date.current,
        updated_at: Date.current
      )

      @transaction_1 = @invoice_1.transactions.create!(
        credit_card_number: "4654405418249632",
        result: "success"
      )
      @transaction_2 = @invoice_2.transactions.create!(
        credit_card_number: "4654405418249632",
        result: "failed"
      )
    end

    describe "-instance" do
      it "calculates the total value for an invoice" do
        expect(@invoice_1.invoice_total).to eq(5320.0)
      end

      it "determines if there are any unshipped invoice items" do
        expect(@invoice_3.has_items_not_shipped).to eq(true)
        expect(@invoice_1.has_items_not_shipped).to eq(false)
      end
    end

    describe "-class" do
      it "orders invoices by oldest to newest" do
        expect(Invoice.oldest_first).to eq([@invoice_3, @invoice_1, @invoice_2])
      end
    end

    describe 'bulk discounts' do
      describe 'instance methods' do
        it "claculates total discounted revenue" do
          m1_disc1 = @merchant_1.bulk_discounts.create!(quantity_threshold: 10, percentage: 20)
          m1_disc2 = @merchant_1.bulk_discounts.create!(quantity_threshold: 5, percentage: 50)
          m2_disc1 = @merchant_2.bulk_discounts.create!(quantity_threshold: 7, percentage: 90)
          m2_invoice_item = InvoiceItem.create!(item_id: @beer.id, invoice_id: @invoice_1.id, quantity: 30, unit_price: @beer.unit_price, status: 2)
          
          expect(@invoice_1.invoice_total).to eq(5350.0)
          expect(@invoice_1.discounted_total).to eq(2823.0)
        end
      end
    end
  end
end
