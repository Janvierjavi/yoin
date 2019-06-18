require 'rails_helper'

RSpec.feature Favorite, type: :feature do
  background do
    @test_user_01 = FactoryBot.create(:user)
    @senryu = Senryu.create(first_line: "あああああ", second_line: "あああああああ", third_line: "あああああ", user_id: @test_user_01.id)

    visit new_session_path

    fill_in 'session[email]', with: @test_user_01.email
    fill_in 'session[password]', with: 'password'
    
    click_on 'Log in'

    visit senryus_path
  end

  scenario 'いいねボタンを押すとカウンターが正しく動く' do
    expect {
      page.find("#favorite_senryu_#{@senryu.id}").click
      sleep 0.5
    }.to change { Favorite.count }.by(1)
  end
end