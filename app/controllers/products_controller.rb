class ProductsController < ApplicationController
  before_action :currect_user, only: [:edit, :update, :destroy]

  def new
    if user_signed_in?
      @product = Product.new
      @product.product_images.build
    else
      redirect_to root_path
    end
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
      @products = Product.where(genre_id: params[:genre_id],is_active: false).page(params[:page]).reverse_order.per(12)
      @genre = Genre.find(params[:genre_id])
    elsif params[:tag_id].present?
      #↓カミナリ使う時は使用する,今も一応カウントで使用(お試し＠tag)
      @tag = Tag.find(params[:tag_id])
      @products_all = @tag.products.joins(:genre).where(is_active: false, genres: { is_active: "true"})
      #----------------
      @products = Product.joins(:genre, :tag_maps).where(is_active: false, genres: { is_active: "true"}, tag_maps: { tag_id: params[:tag_id] }).page(params[:page]).reverse_order.per(12)
      @product = @tag.products.find_by(params[:tag_id])
    elsif params[:search].present?
      #↓カミナリ使う時は使用する,今も一応カウントで使用
      @products_all = Product.where(['products.name LIKE ?', "%#{params[:search]}%"]).joins(:genre).where(is_active: false, genres: { is_active: "true"})
      @products = Product.where(['products.name LIKE ?', "%#{params[:search]}%"]).joins(:genre).where(is_active: false, genres: { is_active: "true"}).page(params[:page]).reverse_order.per(12)
      @product = params[:search]
    else
      @products_all = Product.joins(:genre).where(is_active: false, genres: { is_active: "true"})
      @products = Product.joins(:genre).where(is_active: false, genres: { is_active: "true"}).page(params[:page]).reverse_order.per(12)
    end
  end
  
  def show
    @product = Product.find(params[:id])
    @product_tags = @product.tags
    @comment = Comment.new
    if user_signed_in?
      @favorite = current_user.favorites.find_by(product: params[:id])
      @currentUserEntry=Entry.where(user_id: current_user.id)
      @userEntry=Entry.where(user_id: @product.user_id)
      @room = Room.find_or_initialize_by(product_id: params[:id])
      @isRoom = @room.entries.where(user_id: current_user.id).exists?
      unless @product.user_id == current_user.id
        unless @isRoom
          @room = Room.new
          @entry = Entry.new
        end
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

  def currect_user
    @product = Product.find(params[:id])
      if @product.is_active || @product.user != current_user
        redirect_to product_path
      end
  end
end
