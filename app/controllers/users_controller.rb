class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    @products = @user.products.page(params[:page]).reverse_order.per(5).all.includes(:product_images)
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user.id)
    else
      render 'edit'
    end
  end
  private
  def user_params
    params.require(:user).permit(:name, :post_code, :prefecture_name, :address_city, :address_street, :phone_number, :introduction, :profile_image, :email )
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
end
