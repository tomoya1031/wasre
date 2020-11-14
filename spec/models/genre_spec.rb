require 'rails_helper'

RSpec.describe Genre, type: :model do
  before do
    @genre = build(:genre)
  end

  describe 'バリデーション' do
    it "全て入力してあるので保存される" do
      expect(@genre.valid?).to eq(true)
    end

    it "ジャンル名が入力されていないので保存されない" do
      @genre.name = ''
      expect(@genre.valid?).to eq(false)
    end

    it "商品名が30文字を超えているので保存されない" do
      @genre.name = "a" * 31
      expect(@genre.valid?).to eq(false)
    end
  end

end