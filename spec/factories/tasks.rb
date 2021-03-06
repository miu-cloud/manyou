FactoryBot.define do
    factory :task do
      title { 'test_title' }
      content { 'test_content' }
      deadline{'2022-03-18 15:00'}
      state{ '未着手'}
      priority{ '低'}
      # association :user
    end

    factory :second_task, class: Task do
      title { 'test_title2' }
      content { 'test_content2' }
      deadline{'2022-03-19 15:00'}
      state{ '着手中'}
      priority{ '中'}
      # association :user
    end

    factory :third_task, class: Task do
      title { 'test_title3' }
      content { 'test_content3' }
      deadline{'2022-03-20 15:00'}
      state{ '完了'}
      priority{ '高'}
      # association :user
    end
  end