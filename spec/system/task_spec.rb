require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  let!(:task) { FactoryBot.create(:task, title: 'task') }
  let!(:second_task) { FactoryBot.create(:second_task) }
  let!(:third_task) { FactoryBot.create(:third_task) }
  # before do
  #   visit tasks_path
  # end
  
  # describe '新規作成機能' do
  #   context 'タスクを新規作成した場合' do
  #     it '作成したタスクが表示される' do
  #       visit new_task_path
  #       fill_in 'タイトル', with: 'test_title'
  #       fill_in '内容', with: 'test_content'
  #       fill_in :task_deadline, with: '002022-03-18-15:00'
  #       select '未着手', from: :task_state
  #       select '低', from: :task_priority
  #       click_button '登録する'
  #       expect(page).to have_content 'test_title'
  #       expect(page).to have_content 'test_content'
  #       expect(page).to have_content '2022-03-18 15:00'
  #       expect(page).to have_content '未着手'
  #       expect(page).to have_content '低'
  #     end
  #   end
  # end

  #describe '一覧表示機能' do
    # context '一覧画面に遷移した場合' do
    #   it '作成済みのタスク一覧が表示される' do
    #     # task = FactoryBot.create(:task, title: 'task')
    #     visit tasks_path
    #     expect(page).to have_content 'task'
    #   end
    # end

    # context 'タスクが作成日時の降順に並んでいる場合' do
    #   it '新しいタスクが一番上に表示される' do
    #     # task = FactoryBot.create(:task, title: 'task')
    #     task = FactoryBot.create(:second_task, title: 'task')
    #     visit tasks_path
    #     task_list = all('.task_row') 
    #     expect(task_list[0]).to have_content 'test_content2'
    #     expect(task_list[1]).to have_content 'test_content'
    #   end
    # end

    # context 'タスクが終了期限の降順に並んでいる場合' do
    #   it '新しいタスクが一番上に表示される' do
    #     # task = FactoryBot.create(:task, title: 'task')
    #     # task = FactoryBot.create(:second_task, title: 'task')
    #     # visit new_task_path
    #     # fill_in 'タイトル', with: 'test_title'
    #     # fill_in '内容', with: 'test_content'
    #     # fill_in :task_deadline, with: '002021-03-19-15:00'
    #     # click_button '登録する'
    #     visit tasks_path
    #     click_link '終了期限でソートする'
    #     sort_expired = all('.sort_expired_row')
    #     expect(sort_expired[0]).to have_content '2022-03-18 15:00'
    #     expect(sort_expired[1]).to have_content '2022-03-19 15:00'
    #     expect(sort_expired[2]).to have_content '2022-03-20 15:00'
    #   end
    # end
  #end

#   describe '詳細表示機能' do
#     context '任意のタスク詳細画面に遷移した場合' do
#       it '該当タスクの内容が表示される' do
#         # task = FactoryBot.create(:task, title: 'task')
#         visit tasks_path
#         click_link '詳細を確認する'
#         expect(page).to have_content 'task'
#       end
#     end
#  end

  describe '検索機能' do
    context 'タイトルであいまい検索をした場合' do
      it '検索キーワードを含むタスクで絞り込まれる' do
        visit tasks_path
        fill_in 'title', with: 'title2'
        click_button 'Search'
        expect(page).to have_content 'title2'
      end
    end
    context 'ステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        visit tasks_path
        select '未着手', from: :state
        click_button 'Search'
        expect(page).to have_content '未着手'
      end
    end
    context 'タイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        visit tasks_path
        fill_in 'title', with: 'title2'
        select '着手中', from: :state
        click_button 'Search'
        expect(page).to have_content 'title2'
        expect(page).to have_content '着手中'
      end
    end
  end
end