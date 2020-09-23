class OrdersController < ApplicationController
    
    def index
        @user = User.find(current_user.id)
        @orders = @user.orders.page(params[:page]).reverse_order.per(5)
    end
end
