require 'rails_helper'

RSpec.describe User, type: :model do

    before do
      @user = build(:user)
      @user2 = build(:user)
    end
  
    describe 'バリデーション' do
      
      it "全て入力してあるので保存される" do
        expect(@user.valid?).to eq(true)
      end
  
      it "名前が入力されていないので保存されない" do
        @user.name = ''
        expect(@user.valid?).to eq(false)
      end

      it "名前が1文字なので保存されない" do
        @user.name = "a"
        expect(@user.valid?).to eq(false)
      end

      it "名前が30文字を超えているので保存されない" do
        @user.name = "a" * 31
        expect(@user.valid?).to eq(false)
      end

      it "メールアドレスが入力されていないので保存されない" do
        @user.email = ""
        expect(@user.valid?).to eq(false)
      end

      it "同じメールアドレスが登録されていますので保存されない" do
        @user2.email = 'test1@test.co.jp'
        @user2.save
        @user.email = 'test1@test.co.jp'
        expect(@user.valid?).to eq(false)
      end

      it "郵便番号が入力されていないので保存されない" do
        @user.post_code = ''
        expect(@user.valid?).to eq(false)
      end

      it "郵便番号が7文字を超えているので保存されない" do
        @user.post_code = "a" * 8
        expect(@user.valid?).to eq(false)
      end

      it "郵便番号が6文字なので保存されない" do
        @user.post_code = "a" * 6
        expect(@user.valid?).to eq(false)
      end

      it "都道府県が入力されていないので保存されない" do
        @user.prefecture_code = ''
        expect(@user.valid?).to eq(false)
      end

      it "区市町村が入力されていないので保存されない" do
        @user.address_city = ''
        expect(@user.valid?).to eq(false)
      end

      it "区市町村が1文字なので保存されない" do
        @user.address_city = 'a'
        expect(@user.valid?).to eq(false)
      end

      it "区市町村が50文字を超えているので保存されない" do
        @user.address_city = 'a' * 51
        expect(@user.valid?).to eq(false)
      end

      it "番地以下が入力されていないので保存されない" do
        @user.address_street = ''
        expect(@user.valid?).to eq(false)
      end

      it "番地以下が50文字を超えているので保存されない" do
        @user.address_street = 'a' * 51
        expect(@user.valid?).to eq(false)
      end

      it "電話番号が入力されていないので保存されない" do
        @user.phone_number = ''
        expect(@user.valid?).to eq(false)
      end

      it "電話番号が1文字なので保存されない" do
        @user.phone_number = '1'
        expect(@user.valid?).to eq(false)
      end

      it "電話番号が15文字を超えているので保存されない" do
        @user.phone_number = '1' * 16
        expect(@user.valid?).to eq(false)
      end

      it "パスワードが入力されていないので保存されない" do
        @user.password = ''
        expect(@user.valid?).to eq(false)
      end

      it "パスワードが6文字未満なので保存されない" do
        @user.password = 'a' * 5
        expect(@user.valid?).to eq(false)
      end

      it 'パスワードが不一致のため保存されない' do
        @user.password = "password1"
        @user.password_confirmation = "password2"
        expect(@user.valid?).to eq(false)
      end
    end

    describe 'アソシエーションのテスト' do
      let(:association) do
        # context＞it内に下記を記述するのと同じ
        # expect(User.reflect_on_association(:restaurants).macro).to eq :has_many
        # expect(User.reflect_on_association(:followings).class_name).to eq 'User'
        described_class.reflect_on_association(target)
      end
  
      context '商品モデルとの関係' do
        let(:target) { :products }
  
        it '1:Nとなっている' do
          expect(association.macro).to eq :has_many
        end
      end
  
      context '商品コメントモデルとの関係' do
        let(:target) { :comments }
  
        it '1:Nとなっている' do
          expect(association.macro).to eq :has_many
        end
      end
  
      context '商品いいねモデルとの関係' do
        let(:target) { :favorites}
  
        it '1:Nとなっている' do
          expect(association.macro).to eq :has_many
        end
      end
  
      context '取引履歴モデルとの関係' do
        let(:target) { :orders }
  
        it '1:Nとなっている' do
          expect(association.macro).to eq :has_many
        end
      end
  
      context 'エントリーモデルとの関係' do
        let(:target) { :entries }
  
        it '1:Nとなっている' do
          expect(association.macro).to eq :has_many
        end
      end

      context 'メッセージモデルとの関係' do
        let(:target) { :messages }
  
        it '1:Nとなっている' do
          expect(association.macro).to eq :has_many
        end
      end
  
      context '通知モデルとの関連' do
        let(:target) { :active_notifications }
  
        it '1:Nとなっている' do
          expect(association.macro).to eq :has_many
        end
        it '結合するモデルのクラスはNotification' do
          expect(association.class_name).to eq 'Notification'
        end
      end

      describe 'データベースへの接続のテスト' do
        subject { described_class.connection_config[:database] }
    
        it '指定のDBに接続していること' do
          is_expected.to match(/test.sqlite3/)
        end
      end
    end
end