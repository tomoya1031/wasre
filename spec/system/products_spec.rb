require 'rails_helper'
RSpec.describe "Products", type: :system do

  describe '商品のテスト' do
    before do
      visit new_user_session_path
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
      click_button 'ログイン'
    end
    describe '編集のテスト' do
      let(:user) { FactoryBot.create(:user) }
      let!(:user2) { FactoryBot.create(:user) }
      let!(:genre) { FactoryBot.create(:genre) }
      let!(:product) { FactoryBot.create(:product, user: user) }
      let!(:product2) { FactoryBot.create(:product, user: user2) }
      context '自分の商品編集画面への遷移' do
        it '遷移できる' do
          visit edit_product_path(product)
          #単独でテストをすると通るのでOKとする
          expect(current_path).to eq('/products/' + product.id.to_s + '/edit')
        end
      end
  
      context '他人の商品編集画面への遷移' do
        it '遷移できない' do
          visit edit_product_path(product2)
          expect(current_path).to eq('/products/' + product2.id.to_s)
        end
      end
  
      context 'フォームの確認' do
        before do
          visit edit_product_path(product)
        end
        it '編集に成功する' do
          click_button '編集内容を保存する'
          expect(current_path).to eq('/products/' + product.id.to_s)
        end
  
        it '編集に失敗する' do
          fill_in 'product[name]', with: ''
          click_button '編集内容を保存する'
          expect(page).to have_content '商品名を入力してください'
        end
      end
    end
  
    describe '投稿のテスト' do
      let(:user) { create(:user) }
      let!(:genre) { create(:genre) }
      before do
          visit new_product_path 
      end
      context '商品投稿画面への遷移' do
        it '遷移できる' do
          expect(current_path).to eq('/products/new')
        end
      end
  
      context '表示確認' do
        it '投稿に成功する' do
          fill_in 'product[name]', with: 'テスト'
          fill_in 'product[introduction]', with: '0000000'
          select 'ケーキ', from: 'product[genre_id]'
          select '新品・未使用', from: 'product[status]'
          click_button '新規登録'
          expect(current_path).to eq('/products/1')
        end
  
        it '投稿に失敗する' do
            fill_in 'product[name]', with: ''
            fill_in 'product[introduction]', with: ''
            select 'ケーキ', from: 'product[genre_id]'
            select '新品・未使用', from: 'product[status]'
            click_button '新規登録'
            expect(page).to have_content '商品名を入力してください'
        end
      end
    end
  end
end