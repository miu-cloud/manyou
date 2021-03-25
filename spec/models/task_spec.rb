require 'rails_helper'
#describe 'タスクモデル機能', type: :model do
  # describe 'バリデーションのテスト' do
  #   context 'タスクのタイトルが空の場合' do
  #     it 'バリデーションにひっかる' do
  #       task = Task.new(title: '', content: '失敗テスト')
  #       expect(task).not_to be_valid
  #     end
  #   end

  #   context 'タスクの詳細が空の場合' do
  #     it 'バリデーションにひっかかる' do
  #       task = Task.new(title: '', content: '失敗テスト')
  #       expect(task).not_to be_valid
  #     end
  #   end
  #   context 'タスクのタイトルと詳細に内容が記載されている場合' do
  #     it 'バリデーションが通る' do
  #       task = Task.new(title: '成功テスト', content: '成功テスト')
  #       expect(task).to be_valid
  #     end
  #   end
  # end
#end
  describe '検索機能' do
    let!(:task) { FactoryBot.create(:task, title: 'task') }
    let!(:second_task) { FactoryBot.create(:second_task) }
    context 'scopeメソッドでタイトルのあいまい検索をした場合' do
      it "検索キーワードを含むタスクが絞り込まれる" do
        expect(Task.title_search('task')).to include(task)
        expect(Task.title_search('task')).not_to include(second_task)
        expect(Task.title_search('task').count).to eq 1
      end
    end
    context 'scopeメソッドでステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        expect(Task.state_search('未着手')).to include(task)
        expect(Task.state_search('未着手')).not_to include(second_task)
        expect(Task.state_search('未着手').count).to eq 1
      end
    end
    context 'scopeメソッドでタイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        expect(Task.title_search('task').state_search('未着手')).to include(task)
        expect(Task.title_search('task').state_search('未着手')).not_to include(second_task)
        expect(Task.title_search('task').state_search('未着手').count).to eq 1
      end
    end

  end




# RSpec.describe Task, type: :model do
#   pending "add some examples to (or delete) #{__FILE__}"
# end
