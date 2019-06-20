require 'rails_helper'

RSpec.feature Senryu, type: :feature do
  background do
    @user1 = FactoryBot.create(:user)
    @user2 = FactoryBot.create(:user_second)
    @user3 = FactoryBot.create(:user_third)

    @senryu1 = FactoryBot.create(:senryu, user_id: @user1.id)
    @senryu2 = FactoryBot.create(:senryu_second, user_id: @user2.id)
    @senryu3 = FactoryBot.create(:senryu_third, user_id: @user3.id)

    Relationship.create(follower_id: @user1.id, followed_id: @user2.id)
    Relationship.create(follower_id: @user1.id, followed_id: @user3.id)
    
    Favorite.create(user_id: @user1.id, senryu_id: @senryu1.id)
    Favorite.create(user_id: @user1.id, senryu_id: @senryu2.id)
    Favorite.create(user_id: @user1.id, senryu_id: @senryu3.id)

    visit new_session_path
    fill_in 'session[email]', with: @user1.email
    fill_in 'session[password]', with: 'password'
  
    click_on 'Log in'
  end

  scenario 'Discoverで検索機能が正しく機能する', js: true do
    visit discover_senryus_path

    fill_in 'senryu[search_content]', with: 'あ'
    find('#senryu_search_content').native.send_key(:Enter)

    expect(page).to have_text /.+あああああ.+/
    expect(page).not_to have_text /.+いいいいい.+/
    expect(page).not_to have_text /.+ううううう.+/
  end

  scenario 'Homeで検索機能が正しく機能する', js: true do
    visit home_senryus_path

    fill_in 'senryu[search_content]', with: 'う'
    find('#senryu_search_content').native.send_key(:Enter)

    expect(page).to have_text /.+ううううう.+/
    expect(page).not_to have_text /.+いいいいい.+/
  end

  scenario 'Collectionで検索機能が正しく機能する', js: true do
    visit collection_user_path(@user1.id)

    fill_in 'senryu[search_content]', with: 'あ'
    find('#senryu_search_content').native.send_key(:Enter)

    expect(page).to have_text /.+あああああ.+/
    expect(page).not_to have_text /.+いいいいい.+/
    expect(page).not_to have_text /.+ううううう.+/
  end
end