require 'rails_helper'

RSpec.feature User, type: :feature do
  background do
    @test_user_01 = FactoryBot.create(:user)
    @test_user_02 = FactoryBot.create(:user_second)
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

  scenario 'プロフィール編集でプロフィール画像の設定、名前の変更、自己紹介文の追加ができる' do
    login_as_test_user_01

    expect(current_path).to eq user_path(@test_user_01.id)

    expect(page).not_to have_content 'Yohei'
    expect(page).not_to have_content 'Hello'

    visit edit_user_path(@test_user_01.id)

    attach_file "user[icon]", "spec/factories/profile_icon_sample.png"
    fill_in 'user[name]', with: 'Yohei'
    fill_in 'user[bio]', with: 'Hello'

    click_on 'Update User'

    expect(page).to have_css '.profile-img'
    expect(page).to have_content 'Yohei'
    expect(page).to have_content 'Hello'
  end

  scenario "他人のプロフィール編集画面にはアクセスできない" do
    login_as_test_user_01

    visit edit_user_path(@test_user_02.id)
    
    expect(current_path).to eq user_path(@test_user_01.id)
  end
end