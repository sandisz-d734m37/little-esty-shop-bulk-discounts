class DiscountsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @holidays = DateFacade.holiday
    # binding.pry
  end

  def show
    @discount = BulkDiscount.find(params[:id])
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    merchant = Merchant.find(params[:merchant_id])
    discount = merchant.bulk_discounts.create(discount_params)
    if discount.save
      redirect_to "/merchants/#{merchant.id}/discounts"
    else
      flash.alert = "Error:\n• quantity threshold and percentage must not be blank\n• percentage must be between 0 and 100"
      redirect_to "/merchants/#{merchant.id}/discounts/new"
    end
  end

  def destroy
    merchant = Merchant.find(params[:merchant_id])
    discount = BulkDiscount.find(params[:id])
    discount.destroy!

    redirect_to "/merchants/#{merchant.id}/discounts"
  end

  def edit
    @discount = BulkDiscount.find(params[:id])
    @merchant = @discount.merchant
  end

  def update
    merchant = Merchant.find(params[:merchant_id])
    discount = BulkDiscount.find(params[:id])

    discount.update(discount_params)

    if discount.save
      redirect_to "/discounts/#{discount.id}"
    else
      flash.alert = "Error:\n• quantity threshold and percentage must not be blank\n• percentage must be between 0 and 100"
      redirect_to "/discounts/#{discount.id}/edit"
    end
  end

  private

  def discount_params
    params.permit(:quantity_threshold, :percentage)
  end
end
