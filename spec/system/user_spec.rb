require 'rails_helper'
RSpec.describe 'ログイン機能', type: :system do
  let!(:user) {FactoryBot.create(:user)}
  let!(:admin) {FactoryBot.create(:admin)}

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
    context 'ログインしている場合' do
      before do
        visit new_session_path
        fill_in 'Email', with: 'user@example.jp'
        fill_in 'Password', with: '111111'
        click_on 'Log in'
      end
        it '自分のプロフィール画面に遷移' do
          visit user_path(user.id)
          expect(page).to have_content '一般ユーザーのページ'
        end
        it '他人の詳細画面にアクセスするとタスク一覧画面に遷移' do
          visit user_path(admin.id)
          expect(page).to have_content 'タスク一覧'
        end
        it 'ログアウトができる' do
          click_link 'Logout'
          expect(page).to have_content 'ログアウトしました'
        end
    end
  end

    describe '管理者画面の機能' do
      context '一般ユーザーの場合' do
        it '管理者画面へアクセスするとタスク一覧画面に遷移' do
          visit new_session_path
          fill_in 'Email', with: 'user@example.jp'
          fill_in 'Password', with: '111111'
          click_on 'Log in'
          click_link '管理者画面へ'
          expect(page).to have_content 'タスク一覧'
        end
      end

      context '管理ユーザーの場合' do
        before do
          visit new_session_path
          fill_in 'Email', with: 'admin@example.jp'
          fill_in 'Password', with: '000000'
          click_on 'Log in'
        end
          
        it '管理者画面にアクセスできる' do
          click_link '管理者画面へ'   
          expect(page).to have_content '管理者画面'
        end

        it 'ユーザーの新規登録ができる' do
          click_link '管理者画面へ' 
          click_link 'ユーザーの新規登録'
          fill_in 'Name', with: 'test'
          fill_in 'Email', with: 'test@example.com'
          fill_in 'Password', with: '123456'
          fill_in 'Password confirmation', with: '123456'
          click_on 'ユーザーの登録'
          expect(page).to have_content 'ユーザーを登録しました'     
        end

        it 'ユーザーの詳細画面へアクセスできる' do
          visit admin_user_path(user.id)
          expect(page).to have_content '一般ユーザーのページ'
        end

        it 'ユーザの編集画面でユーザを編集できる' do
          visit admin_users_path
          all('tbody tr')[0].click_on 'ユーザの編集'
          fill_in 'Name', with: 'edit_test'
          fill_in 'Email', with: 'edit_test@example.com'
          choose 'user_admin_true'
          click_on '変更する'
          expect(page).to have_content 'ユーザーを編集しました'
        end

        it 'ユーザーの削除ができる' do
          visit admin_users_path
          all('tbody tr')[0].click_on 'ユーザの削除'
          page.driver.browser.switch_to.alert.accept
          expect(page).to have_content 'ユーザーを削除しました'
        end
        
      end
    end
end