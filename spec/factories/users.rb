FactoryBot.define do
  factory :user do
    email  { Faker::Internet.email }
    first_name { Faker::Dog.name }
    last_name { Faker::Artist.name }
    password { Faker::Color.color_name }
    role { :default }
    status { true }
    token { ENV['Github_Token'] }
    activation_digest {'238972938dvwd'}
  end

  factory :admin, parent: :user do
    role { :admin }
  end
end
