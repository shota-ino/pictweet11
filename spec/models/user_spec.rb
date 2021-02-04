require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できるとき' do
      it 'nicknameとemail、passwordとpassword_confirmationが存在すれば登録できる' do
        expect(@user).to be_valid
      end
      it 'nicknameが6文字以下であれば登録できる' do
        @user.nickname = 'aaaaaa'
        expect(@user).to be_valid
      end
      it 'passwordとpassword_confirmationが6文字以上であれば登録できる' do
        @user.password = '000000'
        @user.password_confirmation = '000000'
        expect(@user).to be_valid
      end
    end
    context '新規登録できないとき' do
      it 'nicknameが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'passwordが存在してもpassword_confirmationが空では登録できない' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'nicknameが7文字以上では登録できない' do
        @user.nickname = 'aaaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('Nickname is too long (maximum is 6 characters)')
      end
      it '重複したemailが存在する場合登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end
      it 'passwordが5文字以下では登録できない' do
        @user.password = '00000'
        @user.password_confirmation = '00000'
        @user.valid?
        # binding.pry
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end
    end
  end
end



# contextは、特定の条件を指定してグループを分けます。
# 使用方法はdescribeと同じですが、describeには何についてのテストなのかを指定するのに対し、contextには特定の条件を指定します。


# 生成した@userをテーブルに保存した後に、再度別のユーザーanother_userを生成します。
# そして、another_userのemailに、すでに保存済みの@userのemailを上書きしています。
# その上でanother_userが保存されるかどうかを判別しています。
# エラーメッセージはEmail has already been takenです。


# :validatableという記述　　ｄeviseによるバリデーションも自動的
# emailバリデーション	・
# 存在すること　一意であること　@を含むこと	・
# passwordバリデーション
# 存在すること　6文字以上128文字以下であること


# 変数を受け渡す際は、beforeに定義する変数はインスタンス変数にする必要があります。
# beforeを利用して、テストコードをさらにまとめましょう。
# 変数userが、@userに置き換わっていることに注意



# 1. 検証のためのインスタンスを生成する
# nicknameではなくemailを空にしてインスタンスを生成します。nicknameには空以外の値を入力しておきましょう。
# 2. 生成したインスタンスに対してバリデーションを行う
# 2は前述の実装と同様です。valid?メソッドを用いてバリデーションを行ってください。
# 3. バリデーションを行ったあとに生成されるエラーメッセージが、どのような状態であればよいのかを指定する
# 適切なメソッドやマッチャを用いて、エクスペクテーションを完成させ


# 異常系のモデル単体テストの実装は、以下の流れで進みます。

# 1保存するデータ（インスタンス）を作成する
# 2作成したデータ（インスタンス）が、保存されるかどうかを確認する
# 3保存されない場合、生成されるエラーメッセージが想定されるものかどうかを確認する

# presence: tureが正常に機能するか検証するため、バリデーションを実行
# Userモデルのバリデーションにはpresence: trueが指定されているため、nicknameが空ではDBに保存できないと判断され、valid?メソッドはfalseを返すはず


# itメソッドは、describeメソッド同様に、グループ分けを行うメソッドです。
# itの場合はより詳細に、「describeメソッドに記述した機能において、どのような状況のテストを行うか」を明記します。
# また、itメソッドで分けたグループを、exampleとも呼びます


# describeとは、テストコードのグループ分けを行うメソッドです。
# 「どの機能に対してのテストを行うか」をdescribeでグループ分けし、その中に各テストコードを記述します。
# describeにつづくdo~endの間に、さらにdescribeメソッドを記述することで、入れ子構造をとることもできます。
# describeメソッドを用いて、「ユーザー新規登録」についてのテストを行うことを記述

