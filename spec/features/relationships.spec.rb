require 'rails_helper'

RSpec.feature Relationship, type: :feature do
  background do
    @user1 = FactoryBot.create(:user)
    @user2 = FactoryBot.create(:user_second)

    visit new_session_path
    fill_in 'session[email]', with: @user1.email
    fill_in 'session[password]', with: 'password'
  
    click_button 'log-in'
  end

  scenario 'ユーザーをフォローできる' do
    visit user_path(@user2.id)

    click_on 'フォローする'

    visit following_user_path(@user1.id)
    expect(page).to have_content @user2.name
  end

  scenario 'フォローを解除することができる' do
    Relationship.create(follower_id: @user1.id, followed_id: @user2.id)

    visit user_path(@user2.id)

    click_on 'フォローをやめる'

    visit following_user_path(@user1.id)
    expect(page).not_to have_content @user2.name
  end

end