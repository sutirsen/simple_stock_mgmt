class ThirdPartiesController < ApplicationController
  before_action :set_third_party, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user
  # GET /third_parties
  # GET /third_parties.json
  def index
    @third_parties = ThirdParty.all
  end

  # GET /third_parties/1
  # GET /third_parties/1.json
  def show
    @purchases = Purchase.where(third_party_id: @third_party.id)
    @orders = Order.where(third_party_id: @third_party.id)
    @collections = Collection.where(third_party_id: @third_party.id)

    @transactions = Array.new
    @purchases.each do |purchase|
      tmpHsh = Hash.new
      tmpHsh['event'] = "Purchase of #{RawMaterial.find(purchase.raw_material_id).name}"
      tmpHsh['date'] = purchase.created_at
      tmpHsh['debit'] = purchase.financial_transaction.amount
      tmpHsh['credit'] = 0
      @transactions << tmpHsh
    end

    @orders.each do |order|
      tmpHsh = Hash.new
      tmpHsh['event'] = "Order"
      tmpHsh['date'] = order.created_at
      tmpHsh['debit'] = 0
      tmpHsh['credit'] = order.financial_transaction.amount
      @transactions << tmpHsh
    end

    @collections.each do |collection|
      tmpHsh = Hash.new
      tmpHsh['event'] = "Paid as collection"
      tmpHsh['date'] = collection.created_at
      tmpHsh['debit'] = 0
      tmpHsh['credit'] = collection.financial_transaction.amount
      @transactions << tmpHsh
    end


    @transactions.sort_by { |transaction| transaction['date'] }
  end

  # GET /third_parties/new
  def new
    @third_party = ThirdParty.new
  end

  # GET /third_parties/1/edit
  def edit
  end

  # POST /third_parties
  # POST /third_parties.json
  def create
    @third_party = ThirdParty.new(third_party_params)
    if @third_party.due.blank?
      @third_party.due = 0
    end
    respond_to do |format|
      if @third_party.save
        format.html { redirect_to @third_party, notice: 'Party was successfully created.' }
        format.json { render :show, status: :created, location: @third_party }
      else
        format.html { render :new }
        format.json { render json: @third_party.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /third_parties/1
  # PATCH/PUT /third_parties/1.json
  def update
    respond_to do |format|
      if @third_party.update(third_party_params)
        format.html { redirect_to @third_party, notice: 'Party was successfully updated.' }
        format.json { render :show, status: :ok, location: @third_party }
      else
        format.html { render :edit }
        format.json { render json: @third_party.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /third_parties/1
  # DELETE /third_parties/1.json
  def destroy
    @third_party.destroy
    respond_to do |format|
      format.html { redirect_to third_parties_url, notice: 'Party was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_third_party
      @third_party = ThirdParty.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def third_party_params
      params.require(:third_party).permit(:name, :address, :phn_number, :gst_number, :due, :type_of_party)
    end
end
