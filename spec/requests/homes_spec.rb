require 'rails_helper'

RSpec.describe "Homes", type: :request do
  describe "ホーム画面" do
    context "ホーム画面が正しく表示される" do
      before do
        get get root_path
      end
      it 'リクエストは200 OKとなること' do
        expect(response.status).to eq 200
      end
    end

    context "アバウト画面が正しく表示される" do
      before do
        get get about_path
      end
      it 'リクエストは200 OKとなること' do
        expect(response.status).to eq 200
      end
    end
  end
end
