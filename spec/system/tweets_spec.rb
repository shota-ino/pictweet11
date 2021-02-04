require 'rails_helper'

RSpec.describe 'ツイート投稿', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @tweet_text = Faker::Lorem.sentence
    @tweet_image = Faker::Lorem.sentence
  end
  context 'ツイート投稿ができるとき'do
    it 'ログインしたユーザーは新規投稿できる' do
      # ログインする
      visit new_user_session_path
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # 新規投稿ページへのリンクがあることを確認する
      expect(page).to have_content('投稿する')
      # 投稿ページに移動する
      visit new_tweet_path
      # フォームに情報を入力する
      fill_in 'tweet_image', with: @tweet_image
      fill_in 'tweet_text', with: @tweet_text
      # 送信するとTweetモデルのカウントが1上がることを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Tweet.count }.by(1)
      # 投稿完了ページに遷移することを確認する
      expect(current_path).to eq(tweets_path)
      # 「投稿が完了しました」の文字があることを確認する
      expect(page).to have_content('投稿が完了しました。')
      # トップページに遷移する
      visit root_path
      # トップページには先ほど投稿した内容のツイートが存在することを確認する（画像）
      expect(page).to have_selector ".content_post[style='background-image: url(#{@tweet_image});']"
      # トップページには先ほど投稿した内容のツイートが存在することを確認する（テキスト）
      expect(page).to have_content(@tweet_text)
    end
  end
  context 'ツイート投稿ができないとき'do
    it 'ログインしていないと新規投稿ページに遷移できない' do
      # トップページに遷移する
      visit root_path
      # 新規投稿ページへのリンクがない
      expect(page).to have_no_content('投稿する')
    end
  end
end

RSpec.describe 'ツイート編集', type: :system do
  before do
    @tweet1 = FactoryBot.create(:tweet)
    @tweet2 = FactoryBot.create(:tweet)
  end
  context 'ツイート編集ができるとき' do
    it 'ログインしたユーザーは自分が投稿したツイートの編集ができる' do
      # ツイート1を投稿したユーザーでログインする
      # ツイート1に「編集」ボタンがあることを確認する
      # 編集ページへ遷移する
      # すでに投稿済みの内容がフォームに入っていることを確認する
      # 投稿内容を編集する
      # 編集してもTweetモデルのカウントは変わらないことを確認する
      # 編集完了画面に遷移したことを確認する
      # 「更新が完了しました」の文字があることを確認する
      # トップページに遷移する
      # トップページには先ほど変更した内容のツイートが存在することを確認する（画像）
      # トップページには先ほど変更した内容のツイートが存在することを確認する（テキスト）
    end
  end
  context 'ツイート編集ができないとき' do
    it 'ログインしたユーザーは自分以外が投稿したツイートの編集画面には遷移できない' do
      # ツイート1を投稿したユーザーでログインする
      # ツイート2に「編集」ボタンがないことを確認する
    end
    it 'ログインしていないとツイートの編集画面には遷移できない' do
      # トップページにいる
      # ツイート1に「編集」ボタンがないことを確認する
      # ツイート2に「編集」ボタンがないことを確認する
    end
  end
end


# ポイントは、「ログインしていたとしても他のユーザーのツイート編集ボタンはクリックできない」 という点です。それを確かめるために、それぞれ別のユーザーに紐づくツイート1とツイート2を作成し、その挙動を確かめます

# beforeに着目しましょう。@tweet1と@tweet2を生成しています。FactoryBotの記述でTweetを生成するときに紐づくUserも同時生成するようにしました。したがって、@tweet1と@tweet2をそれぞれ生成するときに、@tweet1を投稿したユーザーと@tweet2を投稿したユーザーを別々に作成できます。



# <div class="content_post" style="background-image: url(画像のURL);">という要素を取得できれば、投稿した画像が表示されているか確認できそうです。
# この時に使用するものが、have_selectorマッチャ

# have_selector
# 指定したセレクタが存在するかどうかを判断するマッチャです。上記の例であればhave_selector ".content_post[style='background-image: url(#{@tweet_image});']"という形で記述できます。




# ユーザーはあらかじめ保存しておくこと
# @tweet_textや@tweet_imageという、ツイートに投稿した文字をあらかじめ生成してインスタンス変数に代入すること