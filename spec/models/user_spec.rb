require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = User.create(name: "sample", email: "sample@me.com", password: "password", password_confirmation: "password")
  end
  
  describe "ユーザー新規登録" do
    it "ユーザー名が空欄の時バリデーションは通らない" do
      user = User.create(name: "", email: "test@me.com", password: "password", password_confirmation: "password")
      expect(user).not_to be_valid
    end

    it "ユーザー名が30文字より多い時バリデーションは通らない" do
      user = User.create(name: "#{'x' * 31}", email: "test@me.com", password: "password", password_confirmation: "password")
      expect(user).not_to be_valid
    end

    it "Eメールアドレスが空欄のときバリデーションは通らない" do
      user = User.create(name: "test", email: "", password: "password", password_confirmation: "password")
      expect(user).not_to be_valid
    end

    it "Eメールアドレスが完全なメールアドレスでなければバリデーションは通らない" do
      user = User.create(name: "test", email: "test@", password: "password", password_confirmation: "password")
      expect(user).not_to be_valid
    end

    it "既に使われているEメールアドレスは利用できない" do
      expect do
        user = User.create(name: "test", email: "sample@me.com", password: "password", password_confirmation: "password")
      end.to raise_error( ActiveRecord::RecordNotUnique )
    end

    it "パスワードが空欄のときバリデーションは通らない" do
      user = User.create(name: "test", email: "test@me.com", password: "", password_confirmation: "")
      expect(user).not_to be_valid
    end

    it "パスワードと確認用パスワードが一致しない場合は登録できない" do
      user = User.create(name: "test", email: "test@me.com", password: "password", password_confirmation: "passwor")
      expect(user).not_to be_valid
    end
  end

  describe "プロフィール編集" do
    it "編集時にパスワードの入力なしでも更新ができる" do
      @user.update(name: "updated_without_password")
      expect(@user).to be_valid
    end

    it "自己紹介文が150文字より多い場合はバリデーションが通らない" do
      @user.update(bio: "#{'x' * 151}")
      expect(@user).not_to be_valid
    end
  end

  it "登録するEメールアドレスはすべて小文字に変換される" do
    user = User.create(name: "test", email: "#{'test@me.com'.upcase}", password: "password", password_confirmation: "password")
    expect(user.email).to eq 'test@me.com'
  end

  it "パスワードはセキュアに管理されている" do
    expect(@user.password_digest).not_to eq "password"
  end
end
