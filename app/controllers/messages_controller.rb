class MessagesController < ApplicationController

  def create
      # Entry.where(user_id: current_user.id, room_id: params[:message][:room_id]).present?
      @message = Message.new(message_params)
      if @message.save
        redirect_to "/rooms/#{@message.room_id}"
      else
        redirect_to "/rooms/#{@message.room_id}"
        flash[:alert] = "メッセージ送信に失敗しました。"
      end
  end

  private
  def message_params
    params.require(:message).permit(:user_id, :message, :room_id).merge(user_id: current_user.id)
  end
end
