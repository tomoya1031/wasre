class UsersController < ApplicationController
  before_action :user_set, only: [:show,:edit,:update]

  def show
    @products = @user.products.page(params[:page]).reverse_order.per(5).all.includes(:user)
  end

  def edit
    if @user == current_user
      render "edit"
    end
  end

  def update
    if @user.update(user_params)
      flash[:alert] = "You have updated user successfully."
      redirect_to user_path(@user.id)
    else
      render action: :edit
    end
  end
  private
  def user_set
    @user = User.find(params[:id])
  end
  
  def user_params
    params.require(:user).permit(:name, :post_code, :prefecture_name, :address_city, :address_street, :phone_number, :introduction, :profile_image )
  end
end
