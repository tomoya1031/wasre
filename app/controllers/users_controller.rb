class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @products = @user.products.page(params[:page]).reverse_order.per(5)
  end

  def edit
    @user = User.find(params[:id])
    if @user == current_user
      render "edit"
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:alert] = "You have updated user successfully."
      redirect_to user_path(@user.id)
    else
      render action: :edit
    end
  end

  def user_params
    params.require(:user).permit(:name, :post_code, :prefecture_name, :address_city, :address_street, :phone_number, :introductio, :profile_image_id, )
  end
end
