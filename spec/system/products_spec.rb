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
      # let(:image_path) { Rails.root.join('spec/fixtures/picture.jpg') }
      # let(:image) { Rack::Test::UploadedFile.new(image_path) }
      let!(:product) { FactoryBot.create(:product, user: user) }
      let!(:product2) { FactoryBot.create(:product, user: user2) }
      # let!(:product_image) { FactoryBot.create(:product_image, product: product) }
      # let!(:product_image2) { FactoryBot.create(:product_image, product: product2) }
      
      context '自分の商品編集画面への遷移' do
        it '遷移できる' do
          visit edit_product_path(product)
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
      let(:user) { FactoryBot.create(:user) }
      let!(:genre) { FactoryBot.create(:genre) }
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

    describe 'その他画面のテスト' do
      let(:user) { FactoryBot.create(:user) }
      let!(:user2) { FactoryBot.create(:user) }
      let!(:genre) { FactoryBot.create(:genre) }
      let!(:product) { FactoryBot.create(:product, user: user2) }
      let!(:commtent) { FactoryBot.create(:comment, user:user, product: product)}
      
      context '商品取引確認' do
        before do
          visit product_path(product)
          click_button '取　引　開　始'
        end
        it '取引ルーム作成できる' do
          expect(current_path).to eq('/rooms/' + product.id.to_s)
        end

        it '取引ルームに遷移できる' do
          visit product_path(product)
          click_link '取引チャットへ'
          expect(current_path).to eq('/rooms/' + product.id.to_s)
        end

        it 'チャットを投稿に成功する' do
          fill_in 'message[message]', with: 'テストチャット'
          click_button '投稿'
          expect(page).to have_content 'テストチャット'
        end

        it 'チャットを投稿に失敗する' do
            fill_in 'message[message]', with: ''
            click_button '投稿'
            expect(page).to have_content 'メッセージ送信に失敗しました。'
          end

        it '取引履歴に商品が追加される' do
          visit orders_path
          expect(page).to have_content product.name
        end
      end

      context 'いいねをクリックした場合' do
        before do
          visit product_path(product)
          find('a', text: 'いいね：0件').click
        end
        it 'いいねできる' do
          expect(page).to have_content 'いいね：1件'
        end

        it 'いいねを取り消せる' do
          find('a', text: 'いいね：1件').click
          expect(page).to have_content 'いいね：0件'
        end
      end

      context 'コメントを投稿した場合' do
        before do
          visit product_path(product)
          fill_in 'comment[comment]', with: 'テストコメント２'
          click_button '送信'
        end
        it '投稿に成功する' do
          expect(page).to have_content 'テストコメント２'
        end

        it '投稿に失敗する' do
          find('a', text: '').click
          expect(page).to have_content ' コメント：1件'
        end
      end

      context '検索した場合' do
        before do
          visit product_path(product)
        end
        it '商品名検索に成功する' do
          fill_in 'search', with: 'テスト'
          click_button '商品検索'
          expect(page).to have_content '検索結果'
        end

        it 'ジャンル検索に成功する' do
          click_link genre.name
          expect(page).to have_content genre.name
        end
      end
    end
  end
end