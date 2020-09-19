User.create!(
    [
      {
      	id: 1,
      	email: 'admin@admin',
      	name: '管理人',
        post_code: '6240942',
        prefecture_name: '京都府',
        address_city: '舞鶴市',
        address_street: '青井',
        phone_number: '000',
        introduction: '管理人です',
        admin_flg: true,
      	password: '123456',
      	password_confirmation: '123456',
      },

      {
        id: 2,
        email: 'a@aa',
        name: 'aa',
        post_code: '6240942',
        prefecture_name: '京都府',
        address_city: '舞鶴市',
        address_street: '青井',
        phone_number: '000',
        introduction: '減農薬露地栽培で農業をやってます。
        夏場は京野菜の漫万願寺とうがらしをメインに出品していますので、ぜひご購入ください！
        
        また、マンガ本3000冊以上、小説500冊以上持っていますが、子供が産まれたのを機に一掃することにしました。
        手の空いた時にどんどん出品していきますので、気に入った商品があれば是非ご購入ください。',
        password: '123456',
        password_confirmation: '123456',
      },
      {
        id: 3,
        email: 'b@bb',
        name: 'bb',
        post_code: '6240942',
        prefecture_name: '京都府',
        address_city: '舞鶴市',
        address_street: '青井',
        phone_number: '000',
        introduction: 'こんにちは、ご覧いただきありがとうございます。色々なジャンルに出品しています。気持ちよくお取引が出来るように、心がけています。商品や発送方法などご質問がありましたらお気軽にどうぞ。',
        password: '123456',
        password_confirmation: '123456',
      },
    ])