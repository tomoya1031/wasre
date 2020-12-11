class RoomsController < ApplicationController
  before_action :authenticate_user!

  def create
    @product = Product.find(params[:room][:product_id])
    @product.update(is_active: true)
    @order = current_user.orders.new(product_id: @product.id)
    @order.save
    @room = Room.create(product_id: @product.id)
    @entry1 = Entry.create(room_id: @room.id, user_id: current_user.id)
    @entry2 = Entry.create(entry_params)
    redirect_to "/rooms/#{@room.id}"
  end
    
  def show
    if user_signed_in?
      @room = Room.find(params[:id])
      if Entry.where(user_id: current_user.id, room_id: @room.id).present?
        @messages = @room.messages.includes(:user)
        @message = Message.new
        @entries = @room.entries
      end
    else
      redirect_to new_user_session_path
    end
  end

  private
  def entry_params
    params.require(:entry).permit(:user_id, :room_id).merge(room_id: @room.id)
  end
end
