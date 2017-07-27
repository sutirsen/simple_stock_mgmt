class PurchasesController < ApplicationController
  def index
  end

  def new
    @purchase = Purchase.new
    @purchase.build_monitory
  end

  def create
  end
end
