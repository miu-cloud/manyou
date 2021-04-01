require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  user = FactoryBot.create(:user)
  let!(:label) { FactoryBot.create(:label) }
  let!(:second_label) { FactoryBot.create(:second_label) }

  def login(user)
    visit new_session_path
    fill_in 'session[email]', with: user.email
    fill_in 'session[password]', with: user.password
    click_button 'Log in'
  end

  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
        it '複数ラベルが付けられる' do
          login(user)
          visit new_task_path
          fill_in 'タイトル', with: 'title1'
          fill_in '内容', with: 'content1'
          fill_in :task_deadline, with: '002022-04-01-15:00'
          check 'test1'
          check 'test2'
          click_on '登録する'
          expect(page).to have_content 'test1'
          expect(page).to have_content 'test2'
        end
    end

    context 'ラベル検索をした場合' do
      it "ラベル名に完全一致するタスクが絞り込まれる" do
        login(user)
        visit tasks_path
        find("#label_id").find("option[value='1']").select_option
        click_button 'Search'
        expect(page).to have_content 'test1'
      end
    end

  end
end