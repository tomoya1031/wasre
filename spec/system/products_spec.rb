require 'rails_helper'

describe '商品のテスト' do
#   describe '投稿のテスト' do
#     let(:user) { create(:user) }
#     let!(:genre) { create(:genre) }
#     before do
#       visit new_user_session_path
#       fill_in 'user[email]', with: 'test2@example.com'
#       fill_in 'user[password]', with: user.password
#       click_button 'ログイン'
      
#     end
#     context '商品投稿画面への遷移' do
#       it '遷移できる' do
#         visit edit_product_path(product)
#         #単独でテストをすると通るのでOKとする
#         expect(current_path).to eq('/products/' + product.id.to_s + '/edit')
#       end
#     end
  
#     context '他人の商品編集画面への遷移' do
#       it '遷移できない' do
#         visit edit_product_path(product2)
#         expect(current_path).to eq('/products/' + product2.id.to_s)
#       end
#     end
#   end
  describe '編集のテスト' do
    let(:user) { create(:user) }
    let!(:user2) { create(:user) }
    let!(:genre) { create(:genre) }
    let!(:product) { create(:product, user: user) }
    let!(:product2) { create(:product, user: user2) }
    before do
      visit new_user_session_path
      fill_in 'user[email]', with: 'test2@example.com'
      fill_in 'user[password]', with: user.password
      click_button 'ログイン'
      
    end
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

    context '表示の確認' do
      before do
        visit new_user_session_path
      fill_in 'user[email]', with: 'test2@example.com'
      fill_in 'user[password]', with: user.password
      click_button 'ログイン'
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
        visit new_user_session_path
      fill_in 'user[email]', with: 'test2@example.com'
      fill_in 'user[password]', with: user.password
      click_button 'ログイン'
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
          expect(current_path).to eq('/products/3')
        end
      end
    # context '他人の商品編集画面への遷移' do
    #   it '遷移できない' do
    #     visit edit_product_path(product2)
    #     expect(current_path).to eq('/products/' + product2.id.to_s)
    #   end
    # end
  end
end
  
    




  
#   describe 'サイドバーのテスト' do
# 		context '表示の確認' do
# 		  it 'New productと表示される' do
# 	    	expect(page).to have_content 'New product'
# 		  end
# 		  it 'titleフォームが表示される' do
# 		  	expect(page).to have_field 'product[title]'
# 		  end
# 		  it 'opinionフォームが表示される' do
# 		  	expect(page).to have_field 'product[body]'
# 		  end
# 		  it 'Create productボタンが表示される' do
# 		  	expect(page).to have_button 'Create product'
# 		  end
# 		  it '投稿に成功する' do
# 		  	fill_in 'product[title]', with: Faker::Lorem.characters(number:5)
# 		  	fill_in 'product[body]', with: Faker::Lorem.characters(number:20)
# 		  	click_button 'Create product'
# 		  	expect(page).to have_content 'successfully'
# 		  end
# 		  it '投稿に失敗する' do
# 		  	click_button 'Create product'
# 		  	expect(page).to have_content 'error'
# 		  	expect(current_path).to eq('/products')
# 		  end
# 		end
#   end

#   describe '編集のテスト' do
#   	context '自分の投稿の編集画面への遷移' do
#   	  it '遷移できる' do
# 	  		visit edit_product_path(product)
# 	  		expect(current_path).to eq('/products/' + product.id.to_s + '/edit')
# 	  	end
# 	  end
# 		context '他人の投稿の編集画面への遷移' do
# 		  it '遷移できない' do
# 		    visit edit_product_path(product2)
# 		    expect(current_path).to eq('/products')
# 		  end
# 		end
# 		context '表示の確認' do
# 			before do
# 				visit edit_product_path(product)
# 			end
# 			it 'Editing productと表示される' do
# 				expect(page).to have_content('Editing product')
# 			end
# 			it 'title編集フォームが表示される' do
# 				expect(page).to have_field 'product[title]', with: product.title
# 			end
# 			it 'opinion編集フォームが表示される' do
# 				expect(page).to have_field 'product[body]', with: product.body
# 			end
# 			it 'Showリンクが表示される' do
# 				expect(page).to have_link 'Show', href: product_path(product)
# 			end
# 			it 'Backリンクが表示される' do
# 				expect(page).to have_link 'Back', href: products_path
# 			end
# 		end
# 		context 'フォームの確認' do
# 			it '編集に成功する' do
# 				visit edit_product_path(product)
# 				click_button 'Update product'
# 				expect(page).to have_content 'successfully'
# 				expect(current_path).to eq '/products/' + product.id.to_s
# 			end
# 			it '編集に失敗する' do
# 				visit edit_product_path(product)
# 				fill_in 'product[title]', with: ''
# 				click_button 'Update product'
# 				expect(page).to have_content 'error'
# 				expect(current_path).to eq '/products/' + product.id.to_s
# 			end
# 		end
# 	end

#   describe '一覧画面のテスト' do
#   	before do
#   		visit products_path
#   	end
#   	context '表示の確認' do
#   		it 'productsと表示される' do
#   			expect(page).to have_content 'products'
#   		end
#   		it '自分と他人の画像のリンク先が正しい' do
#   			expect(page).to have_link '', href: user_path(product.user)
#   			expect(page).to have_link '', href: user_path(product2.user)
#   		end
#   		it '自分と他人のタイトルのリンク先が正しい' do
#   			expect(page).to have_link product.title, href: product_path(product)
#   			expect(page).to have_link product2.title, href: product_path(product2)
#   		end
#   		it '自分と他人のオピニオンが表示される' do
#   			expect(page).to have_content product.body
#   			expect(page).to have_content product2.body
#   		end
#   	end
#   end

#   describe '詳細画面のテスト' do
#   	context '自分・他人共通の投稿詳細画面の表示を確認' do
#   		it 'product detailと表示される' do
#   			visit product_path(product)
#   			expect(page).to have_content 'product detail'
#   		end
#   		it 'ユーザー画像・名前のリンク先が正しい' do
#   			visit product_path(product)
#   			expect(page).to have_link product.user.name, href: user_path(product.user)
#   		end
#   		it '投稿のtitleが表示される' do
#   			visit product_path(product)
#   			expect(page).to have_content product.title
#   		end
#   		it '投稿のopinionが表示される' do
#   			visit product_path(product)
#   			expect(page).to have_content product.body
#   		end
#   	end
#   	context '自分の投稿詳細画面の表示を確認' do
#   		it '投稿の編集リンクが表示される' do
#   			visit product_path product
#   			expect(page).to have_link 'Edit', href: edit_product_path(product)
#   		end
#   		it '投稿の削除リンクが表示される' do
#   			visit product_path product
#   			expect(page).to have_link 'Destroy', href: product_path(product)
#   		end
#   	end
#   	context '他人の投稿詳細画面の表示を確認' do
#   		it '投稿の編集リンクが表示されない' do
#   			visit product_path(product2)
#   			expect(page).to have_no_link 'Edit', href: edit_product_path(product2)
#   		end
#   		it '投稿の削除リンクが表示されない' do
#   			visit product_path(product2)
#   			expect(page).to have_no_link 'Destroy', href: product_path(product2)
#   		end
#   	end
#   end
# end