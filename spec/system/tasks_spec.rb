require 'rails_helper'

describe 'タスク管理機能', type: :system do
  describe '一覧表示機能' do
    before do
      # ユーザーAを作成しておく
      user_a = FactoryBot.create(:user, name: 'ユーザーA', email: 'a@example.com')
      # 作成者がユーザーAであるタスクを作成しておく
      FactoryBot.create(:task, name: '最初のタスク', user: user_a) #[知見] 5-8-2 オブジェクトを再利用するつもりがないので代入していない
    end

    context 'ユーザーAがログインしているとき' do
      before do
        # ユーザーAでログインする
        visit login_path
        fillin 'メールアドレス', with: 'a@example.com'
        fillin 'パスワード', with: 'password'
        click_button 'ログインする'
      end

      it 'ユーザーAの作成したタスクが表示される' do
        # 作成済みのタスクの名称が画面上に表示されていることを確認
        except(page).to have_content '最初のタスク'
      end
    end
  end
end
