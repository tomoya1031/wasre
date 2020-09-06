class OrdersController < ApplicationController
    @product = Product.find(params[:id])
    @product.update(is_active: true)
    @order = current_user.orders.new(product_id: @product.id)
    @order.save
end
