class ProductsController < ApplicationController
  before_action :product_id, only: [:show, :edit, :update]

  def new
    @product = Product.new
    @product.product_images.build
  end

  def create
    @product = Product.new(product_params)
    @product.user_id = current_user.id
    tag_list = params[:product][:tag_name].split(nil)
     if @product.save
      @product.save_tag(tag_list)
      redirect_to product_path(@product.id)
     else
       render 'new'
     end
  end

  def index
    @genres = Genre.where(is_active: true)
    @tag_list = Tag.all
    if params[:genre_id].present?
      #↓カミナリ使う時は使用する,今も一応カウントで使用
      @products_all = Product.where(genre_id: params[:genre_id],is_active: false)
      #----------------
      @products = Product.where(genre_id: params[:genre_id],is_active: false).page(params[:page]).reverse_order
      @product = Product.find_by(genre_id: params[:genre_id])
    elsif params[:tag_id].present?
      #↓カミナリ使う時は使用する,今も一応カウントで使用(お試し＠tag)
      @tag = Tag.find(params[:tag_id])
      @products_all = @tag.products.joins(:genre).where(is_active: false, genres: { is_active: "true"})
      #----------------
      @products = Product.joins(:genre, :tag_maps).where(is_active: false, genres: { is_active: "true"}, tag_maps: { tag_id: params[:tag_id] }).page(params[:page]).reverse_order
      @product = @tag.products.find_by(params[:tag_id])
    elsif params[:search].present?
      #↓カミナリ使う時は使用する,今も一応カウントで使用
      @products_all = Product.where(['products.name LIKE ?', "%#{params[:search]}%"]).joins(:genre).where(is_active: false, genres: { is_active: "true"})
      @products = Product.where(['products.name LIKE ?', "%#{params[:search]}%"]).joins(:genre).where(is_active: false, genres: { is_active: "true"}).page(params[:page]).reverse_order
      @product = params[:search]
    else
      @products_all = Product.joins(:genre).where(is_active: false, genres: { is_active: "true"})
      @products = Product.joins(:genre).where(is_active: false, genres: { is_active: "true"}).page(params[:page]).per(3).reverse_order
    end
  end
  
  def show
    @product_tags = @product.tags
    @comment = Comment.new
    @favorite = current_user.favorites.find_by(product: params[:id])
    @currentUserEntry=Entry.where(user_id: current_user.id)
    @userEntry=Entry.where(user_id: @product.user_id)
    @room = Room.find_or_initialize_by(product_id: params[:id])
    @isRoom = @room.entries.where(user_id: current_user.id).exists?
    unless @product.user_id == current_user.id
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
    tag_list = params[:product][:tag_name].split(nil)
    if @product.update(product_params)
      @product.save_tag(tag_list)
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
