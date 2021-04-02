
User.create!(name:  "管理者",
    email: "admin@example.jp",
    password:  "000000",
    password_confirmation: "000000",
    admin: true)

10.times do |n|
    User.create!(
        email: "test#{n + 1}@test.com",
        name: "テスト太郎#{n + 1}",
        password: 000000,
        password_confirmation: 000000
    )
end

10.times do |n|
    Task.create!(
        title: "test#{n + 1}",
        content: "テスト太郎#{n + 1}",
        deadline: "002022-04-01#{n + 1}-15:00",
        user_id: User.first.id + n
    )
end

10.times do |n|
    Label.create!(
        title: "test#{n + 1}",
    )
end
