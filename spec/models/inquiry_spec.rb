require 'rails_helper'

RSpec.describe Inquiry, type: :model do

    before do
      @inquiry = build(:inquiry)
    end
  
    describe 'バリデーション' do
      it "全て入力してあるので保存される" do
        expect(@inquiry.valid?).to eq(true)
      end

      it "名前が入力されていないので保存されない" do
        @inquiry.name = ''
        expect(@inquiry.valid?).to eq(false)
      end

      it "メールアドレスが入力されていないので保存されない" do
        @inquiry.email = ''
        expect(@inquiry.valid?).to eq(false)
      end

      it "お問い合わせ内容が入力されていないので保存されない" do
        @inquiry.message = ''
        expect(@inquiry.valid?).to eq(false)
      end
    end

end