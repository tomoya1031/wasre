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

    it "商品名が30文字を超えているので保存されない" do
      @product.name = "a" * 31
      expect(@product.valid?).to eq(false)
    end

    it "商品詳細が入力されていないので保存されない" do
      @product.introduction = ''
      expect(@product.valid?).to eq(false)
    end

    it "商品詳細が300文字を超えているので保存されない" do
      @product.introduction = "a" * 301
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

  describe 'アソシエーションのテスト' do
    let(:association) do
      described_class.reflect_on_association(target)
    end

    context '会員モデルとの関係' do
      let(:target) { :user }
      it 'N:1となっている' do
        expect(association.macro).to eq :belongs_to
      end
    end

    context 'ジャンルモデルとの関係' do
      let(:target) { :genre }
      it 'N:1となっている' do
        expect(association.macro).to eq :belongs_to
      end
    end

    context '商品写真モデルとの関係' do
      let(:target) { :product_images }
      it 'N:1となっている' do
        expect(association.macro).to eq :has_many
      end
    end

    context 'タグマップモデルとの関係' do
      let(:target) { :tag_maps }
      it 'N:1となっている' do
        expect(association.macro).to eq :has_many
      end
    end

    context '商品コメントモデルとの関係' do
      let(:target) { :comments }
      it '1:Nとなっている' do
        expect(association.macro).to eq :has_many
      end
    end

    context '商品いいねモデルとの関係' do
      let(:target) { :favorites}
      it '1:Nとなっている' do
        expect(association.macro).to eq :has_many
      end
    end

    context '取引履歴モデルとの関係' do
      let(:target) { :orders }
      it '1:Nとなっている' do
        expect(association.macro).to eq :has_many
      end
    end

    context '取引履歴モデルとの関係' do
      let(:target) { :orders }
      it '1:Nとなっている' do
        expect(association.macro).to eq :has_many
      end
    end

    context '通知モデルとの関係' do
      let(:target) { :notifications }
      it '1:Nとなっている' do
        expect(association.macro).to eq :has_many
      end
    end

    context '通知モデルとの関係' do
      let(:target) { :room }
      it '1:Nとなっている' do
        expect(association.macro).to eq :has_one
      end
    end
  end
end