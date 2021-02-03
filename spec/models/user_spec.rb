require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'ユーザー新規登録' do
    it 'nicknameが空では登録できない' do
      # nicknameが空では登録できないテストコードを記述します
    end
    it 'emailが空では登録できない' do
      # emailが空では登録できないテストコードを記述します
    end 
  end
end


# itメソッドは、describeメソッド同様に、グループ分けを行うメソッドです。
# itの場合はより詳細に、「describeメソッドに記述した機能において、どのような状況のテストを行うか」を明記します。
# また、itメソッドで分けたグループを、exampleとも呼びます


# describeとは、テストコードのグループ分けを行うメソッドです。
# 「どの機能に対してのテストを行うか」をdescribeでグループ分けし、その中に各テストコードを記述します。
# describeにつづくdo~endの間に、さらにdescribeメソッドを記述することで、入れ子構造をとることもできます。
# describeメソッドを用いて、「ユーザー新規登録」についてのテストを行うことを記述

