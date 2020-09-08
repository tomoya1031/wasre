class OrdersController < ApplicationController
    
    def index
        @user = User.find(current_user.id)
        @orders = @user.orders.all
    end
end
