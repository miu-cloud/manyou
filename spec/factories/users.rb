FactoryBot.define do
  factory :user do
    name { "一般ユーザー" }
    sequence(:email) { "user@example.jp" }
    password { "111111" }
    admin { false }
  end
  factory :admin, class: User do
    name { "管理者" }
    sequence(:email) { "admin@example.jp" }
    password { "000000" }
    admin { true }
  end
end
