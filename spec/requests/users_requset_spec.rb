require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe '会員新規登録ページ' do
    context "会員新規登録ページが正しく表示される" do
      before do
        get new_user_registration_path
      end
      it 'リクエストは200 OKとなること' do
        expect(response.status).to eq 200
      end
    end

    context "会員ログインページが正しく表示される" do
      before do
        get new_user_session_path
      end
      it 'リクエストは200 OKとなること' do
        expect(response.status).to eq 200
      end
    end
  end
end