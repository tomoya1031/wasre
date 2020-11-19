require 'rails_helper'
RSpec.describe "Users", type: :system do
    

  describe '会員認証のテスト' do
    describe '会員新規登録' do
      before do
        visit new_user_registration_path
      end
      context '新規登録画面に遷移' do
        it '新規登録に成功する' do
          fill_in 'user[name]', with: 'テスト'
          fill_in 'user[post_code]', with: '0000000'
          select '京都府', from: 'user[prefecture_name]'
          fill_in 'user[address_city]', with: 'テスト'
          fill_in 'user[address_street]', with: 'テスト'
          fill_in 'user[phone_number]', with: '0000000'
          fill_in 'user[email]', with: 'test@test'
          fill_in 'user[password]', with: 'password'
          fill_in 'user[password_confirmation]', with: 'password'
          click_button '登録'
          expect(current_path).to eq('/users/1')
        end

        it '新規登録に失敗する' do
          fill_in 'user[name]', with: 'aaaaa'
          fill_in 'user[post_code]', with: ''
          select '京都府', from: 'user[prefecture_name]'
          fill_in 'user[address_city]', with: ''
          fill_in 'user[address_street]', with: ''
          fill_in 'user[phone_number]', with: ''
          fill_in 'user[email]', with: ''
          fill_in 'user[password]', with: 'password'
          fill_in 'user[password_confirmation]', with: 'password'
          click_button '登録'
          expect(page).to have_content "メールアドレスが入力されていません。"
        end
      end
    end

    describe '会員ログイン' do
      let(:user) { FactoryBot.create(:user) }
      before do
        visit new_user_session_path
      end
      context 'ログイン画面に遷移' do
        let(:test_user) { user }
        it 'ログインに成功する' do
          fill_in 'user[email]', with: test_user.email
          fill_in 'user[password]', with: test_user.password
          click_button 'ログイン'
          expect(current_path).to eq('/users/' + user.id.to_s)
        end

        it 'ログインに失敗する' do
          fill_in 'user[email]', with: ''
          fill_in 'user[password]', with: ''
          click_button 'ログイン'
          expect(current_path).to eq(new_user_session_path)
        end
      end
    end

    describe '会員ログイン' do
      let(:user) { FactoryBot.create(:user) }
      before do
        visit new_user_session_path
      end
      context 'ログイン画面に遷移' do
        let(:test_user) { user }
        it 'ログインに成功する' do
          fill_in 'user[email]', with: test_user.email
          fill_in 'user[password]', with: test_user.password
          click_button 'ログイン'
          expect(current_path).to eq('/users/' + user.id.to_s)
        end
  
        it 'ログインに失敗する' do
          fill_in 'user[email]', with: ''
          fill_in 'user[password]', with: ''
          click_button 'ログイン'
          expect(current_path).to eq(new_user_session_path)
        end
      end
    end
  end
  
  describe '会員のテスト' do
    let(:user) { create(:user) }
    let(:test_user2) { create(:user) }
    
    before do
      visit new_user_session_path
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
      click_button 'ログイン'
    end
    describe '編集のテスト' do
      context '自分の編集画面への遷移' do
        it '遷移できる' do
          visit edit_user_path(user)
          expect(current_path).to eq('/users/' + user.id.to_s + '/edit')
        end
      end

      context '他人の編集画面への遷移' do
        it '遷移できない' do
          visit edit_user_path(test_user2)
          expect(current_path).to eq('/users/' + user.id.to_s)
        end
      end

      context '表示の確認' do
        before do
          visit edit_user_path(user)
        end
        it '編集に成功する' do
          click_button '編集内容を保存する'
          expect(current_path).to eq('/users/' + user.id.to_s)
        end

        it '編集に失敗する' do
          fill_in 'user[name]', with: ''
          click_button '編集内容を保存する'
          expect(page).to have_content '名前を入力してください'
        end
      end
    end
  end
end