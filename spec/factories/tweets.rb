FactoryGirl.define do
  factory :tweet do
    text "hello Work"
    image "hoge.img"
    user_id 1
    created_at { Faker::Time.between(2.days.ago, Time.now, :all)}
  end
end
