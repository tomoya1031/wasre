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

      it "メッセージが300文字を超えているので保存されない" do
        @message.message = '1' * 301
        expect(@message.valid?).to eq(false)
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

      context '商品モデルとの関係' do
        let(:target) { :room }
        it '1:Nとなっている' do
          expect(association.macro).to eq :belongs_to
        end
      end
    end

end