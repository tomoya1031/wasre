class ProductsController < ApplicationController
  before_action :product_id, only: [:show, :edit, :update]

  def new
    @product = Product.new
    @product.product_images.build
  end

  def create
    @product = Product.new(product_params)
    @product.user_id = current_user.id
     if @product.save
      redirect_to product_path(@product.id)
     else
       render 'new'
     end
  end

  def index
    @products = Product.all
  end

  def show
    @comment = Comment.new
    @currentUserEntry=Entry.where(user_id: current_user.id)
    @userEntry=Entry.where(user_id: @product.user_id)
    unless @product.user_id == current_user.id
      @currentUserEntry.each do |cu|
        @userEntry.each do |u|
          if cu.room_id == u.room_id
            @isRoom = true
            @roomId = cu.room_id
          end
        end
      end
      if @isRoom
      else
        @room = Room.new
        @entry = Entry.new
      end
    end
  end

  def edit
  end

  def update
    if @product.update(product_params)
      redirect_to product_path(@product.id)
    else
      @product = Product.find(params[:id])
      render "edit"
    end
  end

  def destroy
    if @product.destroy
      redirect_to products_path
    else
      render action: :index
    end
  end

  private
  def product_params
    params.require(:product).permit(:name, :introduction, :status, :genre_id, product_images_images: [])
  end

  def product_id
    @product = Product.find(params[:id])
  end
end
