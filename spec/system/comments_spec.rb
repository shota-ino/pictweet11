require 'rails_helper'

RSpec.describe 'コメント投稿', type: :system do
  before do
    @tweet = FactoryBot.create(:tweet)
    @comment = Faker::Lorem.sentence
  end
  it 'ログインしたユーザーはツイート詳細ページでコメント投稿できる' do
    # ログインする
    sign_in(@tweet.user)
    # ツイート詳細ページに遷移する
    visit tweet_path(@tweet)
    # フォームに情報を入力する
    fill_in 'comment_text', with: @comment
    # コメントを送信すると、Commentモデルのカウントが1上がることを確認する
    expect{
      find('input[name="commit"]').click
    }.to change { Comment.count }.by(1)
    # 詳細ページにリダイレクトされることを確認する
    expect(current_path).to eq(tweet_path(@tweet))
    # 詳細ページ上に先ほどのコメント内容が含まれていることを確認する
    expect(page).to have_content @comment
  end
end



# 10~14行目で、ログインの処理を行っています。ログインに使うユーザーの情報は、@tweetに紐づくユーザーを用いるため、@tweet.user.emailのような形で情報を取得しています。
# そして16行目で、自身が投稿済みのツイートの詳細ページへ遷移しています。
# 20~22行目でコメントの投稿処理を行うと、commentsテーブルのレコードが1増えることを確認しています。コメントを投稿すると、コメントを投稿した詳細ページにリダイレクトされるため、24行目で確かにリダイレクトされたかどうかを確認しています。
# 最後に、26行目で先ほど投稿したコメントが表示されているかどうかを確認しています。




# コメント機能に関するexampleおよびその中での挙動を洗い出すと、以下のようになります。ログインしていればコメントできる仕様のため、以下のようなexampleとなります。
# ちなみに、ログインしていないときのツイート詳細ページにコメント投稿欄が無いことは、すでにツイートの結合テストコードで確認済みです。