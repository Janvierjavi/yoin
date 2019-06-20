require 'rails_helper'

RSpec.describe Favorite, type: :model do
  before do
    @user1 = FactoryBot.create(:user)
    @senryu1 = FactoryBot.create(:senryu, user_id: @user1.id)
    Favorite.create(user_id: @user1.id, senryu_id: @senryu1.id)
  end

  it "同じ投稿をいいねできない(Uniqueインデックスが正しく機能する)" do
    expect do
      Favorite.create(user_id: @user1.id, senryu_id: @senryu1.id)
    end.to raise_error( ActiveRecord::RecordNotUnique )
  end
  
end
