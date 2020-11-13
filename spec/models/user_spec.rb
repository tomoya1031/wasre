require 'rails_helper'

RSpec.describe User, type: :model do

    before do
      @user = build(:user)
    end
  
    describe 'バリデーション' do
      
      it "全て入力してあるので保存される" do
        expect(@user.valid?).to eq(true)
      end
  
      it "名前が入力されていないので保存されない" do
        @user.name = ''
        expect(@user.valid?).to eq(false)
      end

      it "名前が1文字なので保存されない" do
        @user.name = "a"
        expect(@user.valid?).to eq(false)
      end

      it "名前が31文字以上なので保存されない" do
        @user.name = "a" * 31
        expect(@user.valid?).to eq(false)
      end

      it "郵便番号が入力されていないので保存されない" do
        @user.post_code = ''
        expect(@user.valid?).to eq(false)
      end

      it "郵便番号が8文字以上なので保存されない" do
        @user.post_code = "a" * 8
        expect(@user.valid?).to eq(false)
      end

      it "郵便番号が6文字なので保存されない" do
        @user.post_code = "a" * 6
        expect(@user.valid?).to eq(false)
      end

      it "都道府県が入力されていないので保存されない" do
        @user.prefecture_code = ''
        expect(@user.valid?).to eq(false)
      end

      it "区市町村が入力されていないので保存されない" do
        @user.address_city = ''
        expect(@user.valid?).to eq(false)
      end

      it "区市町村が1文字なので保存されない" do
        @user.address_city = 'a'
        expect(@user.valid?).to eq(false)
      end

      it "区市町村が51文字以上なので保存されない" do
        @user.address_city = 'a'
        expect(@user.valid?).to eq(false)
      end

      it "区市町村が入力されていないので保存されない" do
        @user.address_city = 'a' * 51
        expect(@user.valid?).to eq(false)
      end

      it "番地以下が入力されていないので保存されない" do
        @user.address_street = ''
        expect(@user.valid?).to eq(false)
      end

    end

end