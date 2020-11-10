class FavoritesController < ApplicationController
    def create
      @product = Product.find(params[:product_id])
      @favorite = current_user.favorites.new(product_id: @product.id)
      @favorite.save
      #通知の作成
      @product.create_notification_by(current_user)
      respond_to do |format|
        format.html {redirect_to request.referrer}
        format.js
      end
    end

    def destroy
      @product = Product.find(params[:product_id])
      @favorite = current_user.favorites.find_by(product_id: @product.id)
      @favorite.destroy
    end
end
