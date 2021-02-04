require 'rails_helper'

RSpec.describe 'ユーザー新規登録', type: :system do
  before do
    @user = FactoryBot.build(:user)
  end
  context 'ユーザー新規登録ができるとき' do 
    it '正しい情報を入力すればユーザー新規登録ができてトップページに移動する' do
      # トップページに移動する
      visit root_path
      # トップページにサインアップページへ遷移するボタンがあることを確認する
      expect(page).to have_content('新規登録')
      # 新規登録ページへ移動する
      visit new_user_registration_path
      # ユーザー情報を入力する
      fill_in 'Nickname', with: @user.nickname
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      fill_in 'Password confirmation', with: @user.password_confirmation
      # サインアップボタンを押すとユーザーモデルのカウントが1上がることを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { User.count }.by(1)
      # トップページへ遷移する
      expect(current_path).to eq(root_path)
      # カーソルを合わせるとログアウトボタンが表示されることを確認する
      expect(
        find('.user_nav').find('span').hover
      ).to have_content('ログアウト')
      # サインアップページへ遷移するボタンや、ログインページへ遷移するボタンが表示されていないことを確認する
      expect(page).to have_no_content('新規登録')
      expect(page).to have_no_content('ログイン')
    end
  end
  context 'ユーザー新規登録ができないとき' do
    it '誤った情報ではユーザー新規登録ができずに新規登録ページへ戻ってくる' do
      # トップページに移動する
      visit root_path
      # トップページにサインアップページへ遷移するボタンがあることを確認する
      expect(page).to have_content('新規登録')
      # 新規登録ページへ移動する
      visit new_user_registration_path
      # ユーザー情報を入力する
      fill_in 'Nickname', with: ''
      fill_in 'Email', with: ''
      fill_in 'Password', with: ''
      fill_in 'Password confirmation', with: ''
      # サインアップボタンを押してもユーザーモデルのカウントは上がらないことを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { User.count }.by(0)
      # 新規登録ページへ戻されることを確認する
      expect(current_path).to eq('/users')
    end
  end
end

RSpec.describe 'ログイン', type: :system do
  before do
    @user = FactoryBot.create(:user)
  end
  context 'ログインができるとき' do
    it '保存されているユーザーの情報と合致すればログインができる' do
      # トップページに移動する
      visit root_path
      # トップページにログインページへ遷移するボタンがあることを確認する
      expect(page).to have_content('ログイン')
      # ログインページへ遷移する
      visit new_user_session_path
      # 正しいユーザー情報を入力する
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      # ログインボタンを押す
      find('input[name="commit"]').click
      # トップページへ遷移することを確認する
      expect(current_path).to eq(root_path)
      # カーソルを合わせるとログアウトボタンが表示されることを確認する
      expect(
        find('.user_nav').find('span').hover
      ).to have_content('ログアウト')
      # サインアップページへ遷移するボタンやログインページへ遷移するボタンが表示されていないことを確認する
      expect(page).to have_no_content('新規登録')
      expect(page).to have_no_content('ログイン')
    end
  end
  context 'ログインができないとき' do
    it '保存されているユーザーの情報と合致しないとログインができない' do
      # トップページに移動する
      visit root_path
      # トップページにログインページへ遷移するボタンがあることを確認する
      expect(page).to have_content('ログイン')
      # ログインページへ遷移する
      visit new_user_session_path
      # ユーザー情報を入力する
      fill_in 'Email', with: ''
      fill_in 'Password', with: ''
      # ログインボタンを押す
      find('input[name="commit"]').click
      # ログインページへ戻されることを確認する
      expect(current_path).to eq(new_user_session_path)
    end
  end
end



# ポイントとしては、新規登録ではvisit先がnew_user_registration_pathであったのに対し、今回はログインであるためnew_user_session_pathとしている点です。また、フォームもログインの際はメールアドレスとパスワードのみでしたので、それに限定した記述としています。



# ポイントとしては、beforeの記述です。ユーザー新規登録の時はユーザー情報の生成のみを行うためFactoryBot.build(:user)としていました。
# 一方、今回はログイン、すなわちすでに登録されているユーザーに対しての挙動を確認するためFactoryBot.create(:user)としています。



# fill_inにおいて、空の文字列を入力しています。各フォームが空では正しく登録ができません。それを再現しています。
# 正しくフォームに値を入力できていないと、新規登録ボタンをクリックしても、テーブルに保存されません。したがって、{ User.count }.by(0)としてレコードの数が変わらないこと（変化が0であること）を確かめています。
# 新規登録がうまくいかなかった時はトップページには遷移せずに、新規登録ページに再度戻されます。新規登録ページのURLは/usersとなるので、正しく戻されているかどうかを確認しています。




# visit 〇〇_pathのように記述すると、〇〇のページへ遷移することを表現できます。RequestSpecで学んだgetと似ていますが、getはあくまでリクエストを送るだけのことを意味し、visitはそのページへ実際に遷移することを意味

# page
# visitで訪れた先のページの見える分だけの情報が格納されています。後述するとおり、「ログアウト」などのカーソルを合わせてはじめて見ることができる文字列はpageの中に含まれません。

# have_content
# expect(page).to have_content('X')と記述すると、visitで訪れたpageの中に、Xという文字列があるかどうかを判断するマッチャです。

# fill_in
# fill_in 'フォームの名前', with: '入力する文字列'のように記述することで、フォームへの入力を行うことができます。それでは、フォームの名前はどのように知ることができるのでしょうか。その時に使用するものが、『『検証ツール』』です。

# find().click
# find('クリックしたい要素').clickと記述することで、実際にクリックができます。検証ツールを開いて、クリックしたい要素を確認しましょう。
# input要素のname属性を指定します。その場合、find('input[name="commit"]').clickという記述

# change
# expect{ 何かしらの動作 }.to change { モデル名.count }.by(1)と記述することによって、モデルのレコードの数がいくつ変動するのかを確認できます。changeマッチャでモデルのカウントをする場合のみ、expect()ではなくexpect{}となります。
# 「何かしらの動作」の部分には、「送信ボタンをクリックした時」が入ります。すなわち、find('input[name="commit"]').clickが入ります。

# current_path
# 文字通り、現在いるページのパスを示します。expect(current_path).to eq(root_path)と記述すれば、今いるページがroot_pathであることを確認できます。

# hover
# find('ブラウザ上の要素').hoverとすることで、特定の要素にカーソルをあわせたときの動作を再現できます。
# ログアウトボタンはヘッダーの中のspan要素をhoverすることで現れます。しかし、span要素は他でも使われているため、その親要素のuser_navクラスもあわせて指定します。

# have_no_content
# have_contentの逆で、文字列が存在しないことを確かめるマッチャです。




# ユーザー新規登録ができるとき
# ユーザー新規登録ができないとき
# そして、それぞれどのようなケースがあるか考えましょう。この時のポイントは、「ユーザー目線で考える」ことです。あまり細かく考えずに、「ブラウザでどのような操作をすると、どうなるのか」を考えます。

# ユーザー新規登録ができるとき
# 正しい情報を入力すればユーザー新規登録ができてトップページに移動する
# ユーザー新規登録ができないとき
# 誤った情報ではユーザー新規登録ができずに新規登録ページへ戻ってくる