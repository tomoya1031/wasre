require 'rails_helper'

RSpec.describe Notification, type: :model do

    describe 'アソシエーションのテスト' do
      let(:association) do
        described_class.reflect_on_association(target)
      end
  
      context '商品モデルとの関係' do
        let(:target) { :product }
        it '1:Nとなっている' do
          expect(association.macro).to eq :belongs_to
        end
      end

      context '商品モデルとの関係' do
        let(:target) { :comment }
        it '1:Nとなっている' do
          expect(association.macro).to eq :belongs_to
        end
      end

      context '会員モデルとの関連' do
        let(:target) { :visiter }
        it '1:Nとなっている' do
          expect(association.macro).to eq :belongs_to
        end
        it '結合するモデルのクラスはNotification' do
          expect(association.class_name).to eq 'User'
        end
      end
    end
end
