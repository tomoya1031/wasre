require 'rails_helper'

RSpec.describe Comment, type: :model do
    before do
      @comment = build(:comment)
    end
  
    describe 'バリデーション' do
      it "全て入力してあるので保存される" do
        expect(@comment.valid?).to eq(true)
      end

      it "コメントが入力されていないので保存されない" do
        @comment.comment = ''
        expect(@comment.valid?).to eq(false)
      end

      it "コメントが300文字を超えているので保存されない" do
        @comment.comment = '1' * 301
        expect(@comment.valid?).to eq(false)
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
        let(:target) { :product }
        it '1:Nとなっている' do
          expect(association.macro).to eq :belongs_to
        end
      end
    end
end