class CollectionsController < ApplicationController
  before_action :set_collection, only: [:show, :edit, :update, :destroy, :invoice]

  # GET /collections
  # GET /collections.json
  def index
    @collections = Collection.all
  end

  # GET /collections/1
  # GET /collections/1.json
  def show
  end

  # GET /collections/new
  def new
    @collection = Collection.new
    @collection.build_financial_transaction
  end

  # GET /collections/1/edit
  def edit
  end

  # POST /collections
  # POST /collections.json
  def create
    @collection = Collection.new(collection_params)
    @collection.build_financial_transaction(financial_transaction_params[:financial_transaction])

    unless validate_transaction_details @collection
      render :new
      return
    end

    respond_to do |format|
      if @collection.save
        finTrans = @collection.financial_transaction
        finTrans.type_of_transaction = :credit
        finTrans.save

        format.html { redirect_to @collection, notice: 'Collection was successfully created.' }
        format.json { render :show, status: :created, location: @collection }
      else
        format.html { render :new }
        format.json { render json: @collection.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /collections/1
  # PATCH/PUT /collections/1.json
  def update
    respond_to do |format|
      if @collection.update(collection_params)
        format.html { redirect_to @collection, notice: 'Collection was successfully updated.' }
        format.json { render :show, status: :ok, location: @collection }
      else
        format.html { render :edit }
        format.json { render json: @collection.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /collections/1
  # DELETE /collections/1.json
  def destroy
    @collection.destroy
    respond_to do |format|
      format.html { redirect_to collections_url, notice: 'Collection was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def invoice
    respond_to do |format|
      format.html
      format.pdf do
        render layout: "invoice", template: "collections/voucher", pdf: "voucher"   # Excluding ".pdf" extension.
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_collection
      @collection = Collection.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def collection_params
      params.require(:collection).permit(:third_party_id, :collection_date, :details, :bill_number)
    end

    def financial_transaction_params
      params.require(:collection).permit(:financial_transaction => [:amount, :payment_method])
    end

    def validate_transaction_details(collectionObj)
      noError = true
      if financial_transaction_params[:financial_transaction][:amount].blank?
        collectionObj.errors[:financial_transaction] << "Amount can not be empty"
        noError = false
      elsif financial_transaction_params[:financial_transaction][:payment_method] == "no_payment"
        collectionObj.errors[:financial_transaction] << "Method can not be no payment"
        noError = false
      end
      return noError
    end
end
