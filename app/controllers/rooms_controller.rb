class RoomsController < ApplicationController
    def create 
        @product = Product.find(params[:room][:product_id])
        @product.update(is_active: true)
        @order = current_user.orders.new(product_id: @product.id)
        @order.save
        @room = Room.create(product_id: @product.id)
        @entry1 = Entry.create(room_id: @room.id, user_id: current_user.id)
        @entry2 = Entry.create(params.require(:entry).permit(:user_id, :room_id).merge(room_id: @room.id))
        redirect_to "/rooms/#{@room.id}"
    end
    
    def show
        @room = Room.find(params[:id])
        if Entry.where(user_id: current_user.id,room_id: @room.id).present?
          @messages = @room.messages
          @message = Message.new
          @entries = @room.entries
        else
          redirect_back(fallback_location: root_path)
        end
    end
end
