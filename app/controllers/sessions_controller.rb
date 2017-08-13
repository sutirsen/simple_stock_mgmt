class SessionsController < ApplicationController
  def home
    unless logged_in?
      redirect_to '/login'
    end
    @purchase_count = Purchase.count
    @employee_count = Employee.count
    @third_party_count = ThirdParty.count
    @raw_material_count = RawMaterial.count
  end

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      redirect_to root_path
    else
      flash.now[:danger] = 'Invalid email/password combination' # Not quite right!
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to '/login'
  end
end
