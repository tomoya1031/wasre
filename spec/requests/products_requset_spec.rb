require 'rails_helper'

RSpec.describe "Products", type: :request do

  describe '商品一覧ページ' do
    context "商品一覧ページが正しく表示される" do
      before do
        get products_path
      end
      it 'リクエストは200 OKとなること' do
        expect(response.status).to eq 200
      end
    end
  end
end