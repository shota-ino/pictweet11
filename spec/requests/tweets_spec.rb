require 'rails_helper'
describe TweetsController, type: :request do

  before do
    @tweet = FactoryBot.create(:tweet)
  end

  describe 'GET #index' do
    it 'indexアクションにリクエストすると正常にレスポンスが返ってくる' do 
      get root_path
      expect(response.status).to eq 200
    end
    it 'indexアクションにリクエストするとレスポンスに投稿済みのツイートのテキストが存在する' do 
    end
    it 'indexアクションにリクエストするとレスポンスに投稿済みのツイートの画像URLが存在する' do 
    end
    it 'indexアクションにリクエストするとレスポンスに投稿検索フォームが存在する' do 
    end
  end
end



# 今回は、tweetsコントローラーのindexアクションにリクエストを送ったときのレスポンスについて確認するコードを記述

# あらかじめデータベースにツイートが保存されている必要があります。
# FactoryBotを用いたインスタンスに関しては、FactoryBot.create(:tweet)というように「create」で保存をあらかじめしておきます。