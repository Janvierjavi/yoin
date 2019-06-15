require 'rails_helper'

RSpec.feature User, type: :feature do
  background do
    @test_user_01 = FactoryBot.create(:user)
  end

  def login_as_test_user_01
    visit new_session_path

    fill_in 'session[email]', with: @test_user_01.email
    fill_in 'session[password]', with: 'password'
    
    click_on 'Log in'
  end

  scenario 'ログインしていないユーザーはサインアップ・ログインページ以外のいかなるページにもアクセスできない' do
    # 全575一覧
    visit senryus_path
    expect(page).to have_content 'ログインしてください'
    expect(current_path).to eq new_session_path

    # 575投稿画面
    visit new_senryu_path
    expect(page).to have_content 'ログインしてください'
    expect(current_path).to eq new_session_path

    # ユーザーページ
    visit user_path(@test_user_01.id)
    expect(page).to have_content 'ログインしてください'
    expect(current_path).to eq new_session_path

    # ユーザーのプロフィール編集画面
    visit edit_user_path(@test_user_01.id)
    expect(page).to have_content 'ログインしてください'
    expect(current_path).to eq new_session_path

    # サインアップページ（アクセス可）
    visit new_session_path
    expect(current_path).to eq new_session_path

    # ログインページ（アクセス可）
    visit new_user_path
    expect(current_path).to eq new_user_path
  end

  scenario 'ログイン中はサインアップページにアクセスできない(マイページに遷移させる)' do
    login_as_test_user_01

    visit new_user_path

    expect(current_path).to eq user_path(@test_user_01.id)
  end
end