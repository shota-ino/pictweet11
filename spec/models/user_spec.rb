require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'ユーザー新規登録' do
    it 'nicknameが空では登録できない' do
      user = FactoryBot.build(:user)  # Userのインスタンス生成
      user.nickname = ''  # nicknameの値を空にする
      user.valid?
      expect(user.errors.full_messages).to include("Nickname can't be blank")
    end
    it 'emailが空では登録できない' do
      user = FactoryBot.build(:user)  # Userのインスタンス生成
      user.email = ''  # emailの値を空にする
      user.valid?
      # binding.pry で検証
      expect(user.errors.full_messages).to include("Email can't be blank")
    end 
  end
end




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

