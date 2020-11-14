require 'rails_helper'

RSpec.describe Tag, type: :model do

    before do
      @tag = build(:tag)
    end
  
    describe 'バリデーション' do
      
      it "全て入力してあるので保存される" do
        expect(@tag.valid?).to eq(true)
      end

      it "コメントが入力されていないので保存されない" do
        @tag.tag_name = ''
        expect(@tag.valid?).to eq(false)
      end

      it "コメントが15文字を超えているので保存されない" do
        @tag.tag_name = '1' * 16
        expect(@tag.valid?).to eq(false)
      end

    end

end