# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # You should configure your model like this:
  # devise :omniauthable, omniauth_providers: [:twitter]

  # You should also create an action method in this controller like this:
  # def twitter
  # end

  # More info at:
  # https://github.com/heartcombo/devise#omniauth

  # GET|POST /resource/auth/twitter
  # def passthru
  #   super
  # end

  def google_oauth2
    callback_for(:google)   # コールバック
  end

  # GET|POST /users/auth/twitter/callback
   def failure
    redirect_to root_path
  #   super
   end

  # protected

  # The path used when OmniAuth fails
  # def after_omniauth_failure_path_for(scope)
  #   super(scope)
  # end

  private
  def callback_for(provider)
    info = User.find_oauth(request.env["omniauth.auth"])
    # snsの情報からuserが登録されているか or snsから情報を取得できているかを確認
    @user = User.where(name: info[:user][:name]).or(User.where(email: info[:user][:email])).first || info[:user]

    # persisted?はデータがDBに保存されているかを確認する/配列に対しては使えないから@userを定義するときは気をつける
    if @user.persisted?
      #保存されていればログインしてroot_pathにリダイレクトされる
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: "#{provider}".capitalize) if is_navigational_format?
    else
      # 登録するアクションに取得した値を渡すために。sessionを利用してuserインスタンスを作成する
      session[:name] = info[:user][:name]
      session[:email] = info[:user][:email]

      #snsでのユーザ登録ではパスワードを入力させないので準備する。パスワードを作成するDeviseメソッドもある。
      #今回のバリデーションは英数字のみなのでこっちを採用
      session[:password_confirmation] = SecureRandom.alphanumeric(30)

      #SnsCredentialが登録されていないとき
      if SnsCredential.find_by(uid: info[:sns][:uid], provider: info[:sns][:provider]).nil?
        #ユーザ登録と同時にsns_credentialも登録するために
        session[:uid] = info[:sns][:uid]
        session[:provider] = info[:sns][:provider]
      end
      #登録フォームのviewにリダイレクトさせる
      redirect_to new_user_registration_path
    end
  end
end