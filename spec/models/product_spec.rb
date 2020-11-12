require 'rails_helper'

RSpec.describe Product, type: :model do

    before do
      @product = build(:product)
    end
  
    describe 'バリデーション' do
      
      it "全て入力してあるので保存される" do
        expect(@product.valid?).to eq(true)
      end
  
      it "商品名が入力されていないので保存されない" do
        @product.name = ''
        expect(@product.valid?).to eq(false)
      end

      it "商品名が31文字以上なので保存されない" do
        @product.name = "a" * 31
        expect(@product.valid?).to eq(false)
      end

      it "商品詳細が入力されていないので保存されない" do
        @product.introduction = ''
        expect(@product.valid?).to eq(false)
      end

      it "ジャンルIDが入力されていないので保存されない" do
        @product.genre_id = ''
        expect(@product.valid?).to eq(false)
      end

      it "商品状態が入力されていないので保存されない" do
        @product.status = ''
        expect(@product.valid?).to eq(false)
      end

    end

end