require 'rails_helper'

RSpec.describe Relationship, type: :model do
  before do
    @user1 = FactoryBot.create(:user)
    @user2 = FactoryBot.create(:user_second)
    Relationship.create(follower_id: @user1.id, followed_id: @user2.id)
  end

  it "同じ人をフォローできない(Uniqueインデックスが正しく機能する)" do
    expect do
      Relationship.create(follower_id: @user1.id, followed_id: @user2.id)
    end.to raise_error( ActiveRecord::RecordNotUnique )
  end
end
