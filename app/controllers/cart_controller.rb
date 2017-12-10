class CartController < ApplicationController
  # protect_from_forgery except: :add_product_to_cart
  def add_product_to_cart
    productToAdd = cart_params
    cartContent = Hash.new
    cartContent = convertCartContentToHash cookies[:cart]
    cartContent[productToAdd[:product_id]] = productToAdd[:qty]
    cookies[:cart] = { :value => convertCartHashToStr(cartContent), :expires => 1.year.from_now}
    render json: { status: 'ok' }.to_json
  end

  def index
    cartHsh = convertCartContentToHash cookies[:cart]
    @cartDetails = Hash.new
    cartHsh.each do |productId, qty|
      @cartDetails[productId] = Hash.new
      @cartDetails[productId]['product'] = Product.find(productId)
      @cartDetails[productId]['addedQty'] = qty
    end
    @taxes = Tax.where(is_active: true)
    @appliedCoupon = nil
    if cookies['coupon_applied']
      couponFetched = Coupon.find(cookies['coupon_applied'])
      if couponFetched.is_active? and couponFetched.valid_from < Time.now and couponFetched.valid_till > Time.now
        @appliedCoupon = couponFetched
      end
    end
  end

  private
    def cart_params
      params.permit(:product_id, :qty)
    end

    def convertCartContentToHash(cartStr)
      tmpHsh = Hash.new
      if(cartStr and cartStr != "")
        allItems = cartStr.split('|')
        allItems.each do |itm|
          itm = itm.split(',')
          tmpHsh[itm[0]] = itm[1]
        end
      end
      return tmpHsh
    end

    def convertCartHashToStr(cartHsh)
      cartStr = ''
      cartHsh.each do |prodId, qty|
        cartStr += '|' if cartStr != ''
        cartStr += prodId + ',' + qty
      end
      return cartStr
    end
end