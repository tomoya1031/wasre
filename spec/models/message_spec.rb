require 'rails_helper'

RSpec.describe Message, type: :model do

    before do
      @message = build(:message)
    end
  
    describe 'バリデーション' do
      
      it "全て入力してあるので保存される" do
        expect(@message.valid?).to eq(true)
      end

      it "コメントが入力されていないので保存されない" do
        @message.message = ''
        expect(@message.valid?).to eq(false)
      end

      it "コメントが15文字を超えているので保存されない" do
        @message.message = '1' * 301
        expect(@message.valid?).to eq(false)
      end

    end

end