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
      # 新規投稿ページへのリンクがない
    end
  end
end


# <div class="content_post" style="background-image: url(画像のURL);">という要素を取得できれば、投稿した画像が表示されているか確認できそうです。
# この時に使用するものが、have_selectorマッチャ

# have_selector
# 指定したセレクタが存在するかどうかを判断するマッチャです。上記の例であればhave_selector ".content_post[style='background-image: url(#{@tweet_image});']"という形で記述できます。




# ユーザーはあらかじめ保存しておくこと
# @tweet_textや@tweet_imageという、ツイートに投稿した文字をあらかじめ生成してインスタンス変数に代入すること