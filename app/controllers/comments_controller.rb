class CommentsController < ApplicationController

    def create
      product = Product.find(params[:product_id])
      comment = current_user.comments.new(comment_params)
      comment.product_id = product.id
      comment.save
      redirect_to product_path(product)
    end

    def destroy
      Comment.find_by(id: params[:id], product_id: params[:product_id]).destroy
      redirect_to product_path(params[:product_id])
    end

    private
    def comment_params
      params.require(:comment).permit(:comment)
    end
end
