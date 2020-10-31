require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe 'ユーザー新規登録ページ' do
    context "ユーザー新規登録ページが正しく表示される" do
      before do
        get new_user_registration_path
      end
      it 'リクエストは200 OKとなること' do
        expect(response.status).to eq 200
      end
    end
  end
end