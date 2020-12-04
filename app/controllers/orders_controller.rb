class OrdersController < ApplicationController
    before_action :authenticate_user!
    
    def index
        @user = User.find(current_user.id)
        @orders = @user.orders.page(params[:page]).reverse_order.per(5).includes(:product)
    end
end
