class ProductsController < ApplicationController
  before_action :product_id, only: [:show, :edit, :update]

  def new
    @product = Product.new
    @product.product_images.build
  end

  def create
    @product = Product.new(product_params)
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
