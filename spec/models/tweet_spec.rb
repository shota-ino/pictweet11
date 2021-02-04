require 'rails_helper'

RSpec.describe Tweet, type: :model do
  before do
    @tweet = FactoryBot.build(:tweet)
  end

  describe 'ツイートの保存' do
    context 'ツイートが投稿できる場合' do
      it '画像とテキストがあれば投稿できる' do
        expect(@tweet).to be_valid
      end
      it 'テキストがあれば投稿できる' do
        @tweet.image = ''
        expect(@tweet).to be_valid
      end
    end
    context 'ツイートが投稿できない場合' do
      it 'テキストが空では投稿できない' do
        @tweet.text = ''
        @tweet.valid?
        # binding.pry
        expect(@tweet.errors.full_messages).to include("Text can't be blank")
      end     
      it 'ユーザーが紐付いていなければ投稿できない' do
        @tweet.user = nil
        @tweet.valid?
        expect(@tweet.errors.full_messages).to include('User must exist')
      end
    end
  end
end




# 生成した@tweetに紐づくユーザーを、nilとして無いものとしています。その上で、バリデーションを確認しています。エラーメッセージはUser must existです。


# textにpresenceのバリデーションが設置されています。
# さらに、アソシエーションを示すbelongs_to :userには、「TweetはUserに属している必要がある」制約が含まれています。
# まとめると、以下のようなexampleを列挙できます。
# 1画像とテキストがあれば投稿できる
# 2テキストがあれば投稿できる
# 3テキストが空では投稿できない
# 4ユーザーが紐付いていなければ投稿できない