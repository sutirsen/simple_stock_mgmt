class CouponsController < ApplicationController
  before_action :set_coupon, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user
  # GET /coupons
  # GET /coupons.json
  def index
    @coupons = Coupon.all
  end

  # GET /coupons/1
  # GET /coupons/1.json
  def show
  end

  # GET /coupons/new
  def new
    @coupon = Coupon.new
  end

  # GET /coupons/1/edit
  def edit
  end

  # POST /coupons
  # POST /coupons.json
  def create
    @coupon = Coupon.new(coupon_params)

    respond_to do |format|
      if @coupon.save
        format.html { redirect_to @coupon, notice: 'Coupon was successfully created.' }
        format.json { render :show, status: :created, location: @coupon }
      else
        format.html { render :new }
        format.json { render json: @coupon.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /coupons/1
  # PATCH/PUT /coupons/1.json
  def update
    respond_to do |format|
      if @coupon.update(coupon_params)
        format.html { redirect_to @coupon, notice: 'Coupon was successfully updated.' }
        format.json { render :show, status: :ok, location: @coupon }
      else
        format.html { render :edit }
        format.json { render json: @coupon.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /coupons/1
  # DELETE /coupons/1.json
  def destroy
    @coupon.destroy
    respond_to do |format|
      format.html { redirect_to coupons_url, notice: 'Coupon was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  def apply_coupon
    couponId = params.permit(:coupon_id)['coupon_id']
    coupon = Coupon.find(couponId)
    if coupon.is_active?
      if coupon.valid_from < Time.now and coupon.valid_till > Time.now
        cookies['coupon_applied'] = { :value => couponId, :expires => 1.year.from_now}
        render json: { status: 'ok', msg: 'Coupon was successfully applied!' }.to_json
      else
        render json: { status: 'error', msg: 'Coupon is no longer active, date expired' }.to_json
      end
    else
      render json: { status: 'error', msg: 'Coupon is no longer active' }.to_json
    end
  end

  def remove_coupon
    cookies.delete('coupon_applied')
    render json: { status: 'ok' }.to_json
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_coupon
      @coupon = Coupon.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def coupon_params
      params.require(:coupon).permit(:name, :type_of_discount, :amount, :valid_from, :valid_till, :is_active)
    end
end
