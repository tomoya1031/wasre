require 'rails_helper'

RSpec.describe Product, type: :model do

  context "データが正しく保存される" do
    # before do
    #   @product = Product.new
    #   @product.product_images.build
    #   @product.genre_id = 1
    #   @product.name = "ケーキ"
    #   @product.introduction = "今日も晴れです。"
    #   @product.status = "新品・未使用"
    #   @product.product_images_images = "44b898f756b831b14ab869910e8aa1391594d362352c9735573cc324addf"
    #   @product.save
    # end
    it "全て入力してあるので保存される" do
      product = create(:product)
      product.valid?
      expect(product).to be_valid
    end
  end
  context "データが正しく保存されない" do
    # before do
    #     @product = Product.new
    #     @product.genre_id = 1
    #     @product.name = ""
    #     @product.introduction = "おはようごうざいます。"
    #     @product.status = "新品・未使用"
    #     @product.save
    # end
    it "名前が入力されていないので保存されない" do
      product = build(:product, name: "")
      product.valid?
      # expect(product).to be_invalid
      expect(product.errors[:name]).to include("が入力されてません")
    end
    it "商品説明が入力されていないので保存されない" do
      product = build(:product, introduction: "")
      product.valid?
      expect(product.errors[:introduction]).to include("が入力されてません")
    end
  end

end