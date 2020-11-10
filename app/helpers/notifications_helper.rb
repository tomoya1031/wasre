module NotificationsHelper
    def notification_form(notification)
        @visiter = notification.visiter
        @comment = nil
        your_product = link_to 'あなたの投稿', product_path(notification), style:"font-weight: bold;"
        @visiter_comment = notification.comment_id
        #notification.actionがfollowかlikeかcommentか
        case notification.action
          when "like" then
            tag.a(notification.visiter.name, href:user_path(@visiter), style:"font-weight: bold;")+"が"+tag.a('あなたの投稿', href:product_path(notification.product_id), style:"font-weight: bold;")+"にいいねしました"
          when "comment" then
              @comment = Comment.find_by(id: @visiter_comment)&.content
              tag.a(@visiter.name, href:user_path(@visiter), style:"font-weight: bold;")+"が"+tag.a('あなたの投稿', href:product_path(notification.product_id), style:"font-weight: bold;")+"にコメントしました"
        end
    end

    def unchecked_notifications
        @notifications = current_user.passive_notifications.where(checked: false)
    end
end
