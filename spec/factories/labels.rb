FactoryBot.define do
  factory :label do
    title { "test1" }
    id { 1 }
  end

  factory :second_label, class: Label do
    title { "test2" }
    id { 2 }
  end
end
