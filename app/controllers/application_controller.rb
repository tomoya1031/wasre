class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_up_path_for(resource)
    user_path(current_user.id)
    flash[:notice] = "Welcome! You have signed up successfully."
  end

  def after_sign_in_path_for(resource)
    user_path(current_user.id) # ログイン後に遷移するpathを設定
    # flash[:notice] = "Signed in successfully."
  end

  def after_sign_out_path_for(resource)
    "/" # ログアウト後に遷移するpathを設定
    # flash[:notice] = "Signed out successfully."
  end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :post_code, :prefecture_name, :address_city, :address_street, :phone_number])
    # added_attrs = [:user_name, :email, :password, :password_confirmation, :remember_me]
    # devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    # devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end
end
