require 'rails_helper'
RSpec.describe 'ログイン機能', type: :system do
  let!(:user) {FactoryBot.create(:user)}

  describe 'ユーザー登録機能' do
    context 'ユーザーを新規登録した場合' do
      it 'ユーザーのプロフィールが表示される' do
        visit new_user_path
        fill_in 'Name', with: 'new_user'
        fill_in 'Email', with: 'new@example.com'
        fill_in 'Password', with: 'password'
        fill_in 'Password confirmation', with: 'password'
        click_on 'Create my account'
        expect(page).to have_content 'new_userのページ'
      end
    end

    context 'ログインせずにタスク一覧画面へアクセスした場合' do
        it 'ログイン画面に遷移する' do
          visit tasks_path
          expect(page).to have_content 'ログインして下さい！'
        end
    end
  end

  describe 'セッション機能' do
    context 'ユーザーが登録されている場合' do
        it 'ログインができる' do
          visit new_session_path
          fill_in 'Email', with: 'user@example.jp'
          fill_in 'Password', with: '111111'
          click_on 'Log in'
          expect(page).to have_content '一般ユーザーのページ'
        end
        
    end
  end

end