class ReportsController < ApplicationController
  before_action :logged_in_user

  def index
    @startDate = params[:start_date]
    @endDate = params[:end_date]
    @transactions = Array.new
    unless @startDate.blank? and @endDate.blank?
      @purchases = Purchase.where('created_at BETWEEN ? AND ?', @startDate.to_date.beginning_of_day, @endDate.to_date.end_of_day)
      @totalDebit = 0.0
      @totalCredit = 0.0
      @purchases.each do |purchase|
        tmpHsh = Hash.new
        tmpHsh['party'] = purchase.third_party.name
        tmpHsh['event'] = "Purchase of #{RawMaterial.find(purchase.raw_material_id).name}"
        tmpHsh['date'] = purchase.created_at
        tmpHsh['debit'] = purchase.financial_transaction.amount
        tmpHsh['credit'] = 0.0
        @totalDebit += purchase.financial_transaction.amount
        @transactions << tmpHsh
      end

      @orders = Order.where('created_at BETWEEN ? AND ?', @startDate.to_date.beginning_of_day, @endDate.to_date.end_of_day)
      
      @orders.each do |order|
        tmpHsh = Hash.new
        tmpHsh['party'] = order.third_party.name
        tmpHsh['event'] = "Order"
        tmpHsh['date'] = order.bill_date ? order.bill_date : order.created_at
        tmpHsh['debit'] = 0.0
        tmpHsh['credit'] = order.financial_transaction.amount
        @totalCredit += order.financial_transaction.amount
        @transactions << tmpHsh
      end

      @operational_expenses = OperationalExpense.where('created_at BETWEEN ? AND ?', @startDate.to_date.beginning_of_day, @endDate.to_date.end_of_day)
      
      @operational_expenses.each do |operational_expense|
        tmpHsh = Hash.new
        tmpHsh['party'] = ""
        tmpHsh['event'] = operational_expense.name
        tmpHsh['date'] = operational_expense.paid_on ? operational_expense.paid_on : operational_expense.created_at
        tmpHsh['debit'] = operational_expense.financial_transaction.amount
        tmpHsh['credit'] = 0.0
        @totalDebit += operational_expense.financial_transaction.amount
        @transactions << tmpHsh
      end

      @collections = Collection.where('created_at BETWEEN ? AND ?', @startDate.to_date.beginning_of_day, @endDate.to_date.end_of_day)
      
      @collections.each do |collection|
        tmpHsh = Hash.new
        tmpHsh['party'] = collection.third_party.name
        tmpHsh['event'] = "Collection"
        tmpHsh['date'] = collection.collection_date ? collection.collection_date : collection.created_at
        tmpHsh['debit'] = 0.0
        tmpHsh['credit'] = collection.financial_transaction.amount
        @totalCredit += collection.financial_transaction.amount
        @transactions << tmpHsh
      end

      @transactions.sort_by { |transaction| transaction['date'] }

      tmpHsh = Hash.new
      tmpHsh['party'] = ""
      tmpHsh['event'] = "Total"
      tmpHsh['date'] = ""
      tmpHsh['debit'] = @totalDebit
      tmpHsh['credit'] = @totalCredit
      @transactions << tmpHsh
      
    end
    
  end
end
