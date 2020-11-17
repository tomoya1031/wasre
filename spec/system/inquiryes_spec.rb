require 'rails_helper'
RSpec.describe "Inquiryes", type: :system do

  describe 'お問い合わせのテスト' do
    before do
      visit inquiry_path
    end
    describe '投稿のテスト' do
      context 'お問い合わせ内容入力画面への遷移' do
        it '遷移できる' do
          visit inquiry_path
          expect(current_path).to eq('/inquiry')
        end
      end
  
      context 'お問い合わせ内容確認画面への遷移' do
        it '遷移に成功する' do
            visit inquiry_path
            fill_in 'inquiry[name]', with: 'テスト'
            fill_in 'inquiry[email]', with: 'a@aa'
            fill_in 'inquiry[message]', with: 'テスト'
            click_button '確認'
            expect(current_path).to eq('/inquiry/confirm')
        end

        it '遷移に失敗する' do
            visit inquiry_path
            fill_in 'inquiry[name]', with: ''
            fill_in 'inquiry[email]', with: ''
            fill_in 'inquiry[message]', with: ''
            click_button '確認'
            expect(page).to have_content 'お問合せ内容を入力してください'
        end

        it '直接リンク入力による遷移に失敗する' do
            visit inquiry_confirm_path
            expect(page).to have_content '（必須）'
        end
      end

      context 'お問い合わせありがとう画面への遷移' do
        it '遷移に成功する' do
            visit inquiry_path
            fill_in 'inquiry[name]', with: 'テスト'
            fill_in 'inquiry[email]', with: 'a@aa'
            fill_in 'inquiry[message]', with: 'テスト'
            click_button '確認'
            click_button '送信'
            expect(current_path).to eq('/inquiry/thanks')
        end

        it '直接リンク入力による遷移に失敗する' do
            visit inquiry_thanks_path
            expect(page).to have_content '（必須）'
        end
      end
    end
  end
end