require 'rails_helper'

RSpec.describe Senryu, type: :model do
  before do
    @user = User.create(name: "test", email: "test@me.com", password: "password", password_confirmation: "password")
    @user_id = @user.id
  end
  describe "5・7・5の文字数指定" do
    it "各ラインが正しい文字数であれば通る" do
      senryu1 = Senryu.create(first_line: "あいうえお", second_line: "あいうえおかき", third_line: "あいうえお", user_id: @user_id)
    end

    it "一の句が5文字を満たさない、または5文字以上の時は通らない" do
      senryu1 = Senryu.create(first_line: "あいうえ", second_line: "あいうえおかき", third_line: "あいうえお", user_id: @user_id)
      senryu2 = Senryu.create(first_line: "あいうえおか", second_line: "あいうえおかき", third_line: "あいうえお", user_id: @user_id)
      expect(senryu1).not_to be_valid
      expect(senryu2).not_to be_valid
    end

    it "二の句が7文字を満たさない、または7文字以上の時は通らない" do
      senryu1 = Senryu.create(first_line: "あいうえお", second_line: "あいうえおか", third_line: "あいうえお", user_id: @user_id)
      senryu2 = Senryu.create(first_line: "あいうえお", second_line: "あいうえおかきく", third_line: "あいうえお", user_id: @user_id)
      expect(senryu1).not_to be_valid
      expect(senryu2).not_to be_valid
    end

    it "三の句が5文字を満たさない、または5文字以上の時は通らない" do
      senryu1 = Senryu.create(first_line: "あいうえお", second_line: "あいうえおかき", third_line: "あいうえ", user_id: @user_id)
      senryu2 = Senryu.create(first_line: "あいうえお", second_line: "あいうえおかき", third_line: "あいうえおか", user_id: @user_id)
      expect(senryu1).not_to be_valid
      expect(senryu2).not_to be_valid
    end
  end
  
  describe '捨て仮名(ァィゥェォャュョ)は前の文字と合わせて一文字とする、という俳句のルールを適用する' do
    it "捨て仮名が含まれていれば、含まれている字数分もともとの5・7・5の文字数指定にプラスされ、正しく通る" do
      senryu = Senryu.create(first_line: "かふぇおれと", second_line: "りょうりしゅまぜる", third_line: "しゅういつだ", user_id: @user_id)
      expect(senryu).to be_valid
    end

    it "捨て仮名が含まれている状態で字数が合わない時は通らない" do
      senryu = Senryu.create(first_line: "かふぇおれ", second_line: "りょうりしゅまぜる", third_line: "しゅういつだ", user_id: @user_id)
      expect(senryu).not_to be_valid
    end
  end

  describe "ひらがな以外の文字の入力の不許可" do
    it "全てひらがなであれば正しく通る" do
      senryu = Senryu.create(first_line: "あいうえお", second_line: "あいうえおかき", third_line: "あいうえお", user_id: @user_id)
      expect(senryu).to be_valid
    end

    it "カタカナが含まれているときは通らない" do
      senryu1 = Senryu.create(first_line: "あいうえオ", second_line: "あいうえおかき", third_line: "あいうえお", user_id: @user_id)
      senryu2 = Senryu.create(first_line: "あいうえお", second_line: "あいうえおかキ", third_line: "あいうえお", user_id: @user_id)
      senryu3 = Senryu.create(first_line: "あいうえお", second_line: "あいうえおかき", third_line: "あいうえオ", user_id: @user_id)
      expect(senryu1).not_to be_valid
      expect(senryu2).not_to be_valid
      expect(senryu3).not_to be_valid
    end

    it "英語が含まれているときは通らない" do
      senryu1 = Senryu.create(first_line: "あいうえa", second_line: "あいうえおかき", third_line: "あいうえお", user_id: @user_id)
      senryu2 = Senryu.create(first_line: "あいうえお", second_line: "あいうえおかa", third_line: "あいうえお", user_id: @user_id)
      senryu3 = Senryu.create(first_line: "あいうえお", second_line: "あいうえおかき", third_line: "あいうえa", user_id: @user_id)
      expect(senryu1).not_to be_valid
      expect(senryu2).not_to be_valid
      expect(senryu3).not_to be_valid
    end

    it "数字が含まれているときは通らない" do
      senryu1 = Senryu.create(first_line: "あいうえ1", second_line: "あいうえおかき", third_line: "あいうえお", user_id: @user_id)
      senryu2 = Senryu.create(first_line: "あいうえお", second_line: "あいうえおか1", third_line: "あいうえお", user_id: @user_id)
      senryu3 = Senryu.create(first_line: "あいうえお", second_line: "あいうえおかき", third_line: "あいうえ1", user_id: @user_id)
      expect(senryu1).not_to be_valid
      expect(senryu2).not_to be_valid
      expect(senryu3).not_to be_valid
    end

    it "記号が含まれているときは通らない" do
      senryu1 = Senryu.create(first_line: "あいうえ!", second_line: "あいうえおかき", third_line: "あいうえお", user_id: @user_id)
      senryu2 = Senryu.create(first_line: "あいうえお", second_line: "あいうえおか!", third_line: "あいうえお", user_id: @user_id)
      senryu3 = Senryu.create(first_line: "あいうえお", second_line: "あいうえおかき", third_line: "あいうえ!", user_id: @user_id)
      expect(senryu1).not_to be_valid
      expect(senryu2).not_to be_valid
      expect(senryu3).not_to be_valid
    end
  end

  describe "禁止コンテンツの不許可" do
    it "禁止コンテンツが含まれているときは通らない" do
      senryu1 = Senryu.create(first_line: "あいちんこ", second_line: "あいうえおかき", third_line: "あいうえお", user_id: @user_id)
      senryu2 = Senryu.create(first_line: "あいうえお", second_line: "あいうえちんこ", third_line: "あいうえお", user_id: @user_id)
      senryu3 = Senryu.create(first_line: "あいうえお", second_line: "あいうえおかき", third_line: "あいちんこ", user_id: @user_id)
      expect(senryu1).not_to be_valid
      expect(senryu2).not_to be_valid
      expect(senryu3).not_to be_valid
    end
  end

end