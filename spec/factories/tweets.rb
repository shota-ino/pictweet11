FactoryBot.define do
  factory :tweet do
    text {Faker::Lorem.sentence}
    image {Faker::Lorem.sentence}
    association :user 
  end
end


# 5行目にassociation :userという記述があります。
# これはusers.rbのFactoryBotとアソシエーションがあることを意味しています。
# つまり、下図のようにTweetのインスタンスが生成したと同時に、関連するUserのインスタンスも生成されます。
# Tweetに対しては、必ずUserが紐付いている必要があるため、このように記述する必要があります。（UserはTweetを必ず持っているわけではないため、users.rbには記述しません。）