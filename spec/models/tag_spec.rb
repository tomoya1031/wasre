require 'rails_helper'

RSpec.describe Tag, type: :model do

    before do
      @tag = build(:tag)
    end
  
    describe 'バリデーション' do
      
      it "全て入力してあるので保存される" do
        expect(@tag.valid?).to eq(true)
      end

      it "タグ名が入力されていないので保存されない" do
        @tag.tag_name = ''
        expect(@tag.valid?).to eq(false)
      end

      it "タグ名が15文字を超えているので保存されない" do
        @tag.tag_name = '1' * 16
        expect(@tag.valid?).to eq(false)
      end
    end

    describe 'アソシエーションのテスト' do
      let(:association) do
        described_class.reflect_on_association(target)
      end
  
      context '商品モデルとの関係' do
        let(:target) { :tag_maps }
        it '1:Nとなっている' do
          expect(association.macro).to eq :has_many
        end
      end
    end

end