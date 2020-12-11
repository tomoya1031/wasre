require 'rails_helper'

RSpec.describe Order, type: :model do
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