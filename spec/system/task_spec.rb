require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do

  # before do
  #   FactoryBot.create(:task)
  #   FactoryBot.create(:second_task)
  # end
  
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in 'Title', with: 'test-title'
        fill_in 'Content', with: 'test-content'
        click_button 'Create Task'
        expect(page).to have_content 'test-title'
        expect(page).to have_content 'test-content'
      end
    end
  end

  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        task = FactoryBot.create(:task, title: 'task')
        visit tasks_path
        expect(page).to have_content 'task'
      end
    end
  end

  describe '詳細表示機能' do
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクの内容が表示される' do
        task = FactoryBot.create(:task, title: 'task')
        visit tasks_path
        click_link '詳細を確認する'
        expect(page).to have_content 'task'
      end
    end
 end

end