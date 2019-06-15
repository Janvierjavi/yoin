require 'rails_helper'

RSpec.describe Senryu, type: :model do
  describe "5・7・5の文字数指定" do
    it "各ラインが正しい文字数であれば通る" do
      senryu1 = Senryu.create(first_line: "あいうえお", second_line: "あいうえおかき", third_line: "あいうえお")
    end

    it "一の句が5文字を満たさない、または5文字以上の時は通らない" do
      senryu1 = Senryu.create(first_line: "あいうえ", second_line: "あいうえおかき", third_line: "あいうえお")
      senryu2 = Senryu.create(first_line: "あいうえおか", second_line: "あいうえおかき", third_line: "あいうえお")
      expect(senryu1).not_to be_valid
      expect(senryu2).not_to be_valid
    end

    it "二の句が7文字を満たさない、または7文字以上の時は通らない" do
      senryu1 = Senryu.create(first_line: "あいうえお", second_line: "あいうえおか", third_line: "あいうえお")
      senryu2 = Senryu.create(first_line: "あいうえお", second_line: "あいうえおかきく", third_line: "あいうえお")
      expect(senryu1).not_to be_valid
      expect(senryu2).not_to be_valid
    end

    it "三の句が5文字を満たさない、または5文字以上の時は通らない" do
      senryu1 = Senryu.create(first_line: "あいうえお", second_line: "あいうえおかき", third_line: "あいうえ")
      senryu2 = Senryu.create(first_line: "あいうえお", second_line: "あいうえおかき", third_line: "あいうえおか")
      expect(senryu1).not_to be_valid
      expect(senryu2).not_to be_valid
    end
  end
  
  describe '捨て仮名(ァィゥェォャュョ)は前の文字と合わせて一文字とする、という俳句のルールを適用する' do
    it "捨て仮名が含まれていれば、含まれている字数分もともとの5・7・5の文字数指定にプラスされ、正しく通る" do
      senryu = Senryu.create(first_line: "かふぇおれと", second_line: "りょうりしゅまぜる", third_line: "しゅういつだ")
      expect(senryu).to be_valid
    end

    it "捨て仮名が含まれている状態で字数が合わない時は通らない" do
      senryu = Senryu.create(first_line: "かふぇおれ", second_line: "りょうりしゅまぜる", third_line: "しゅういつだ")
      expect(senryu).not_to be_valid
    end
  end

  describe "ひらがな以外の文字の入力の不許可" do
    it "全てひらがなであれば正しく通る" do
      senryu = Senryu.create(first_line: "あいうえお", second_line: "あいうえおかき", third_line: "あいうえお")
      expect(senryu).to be_valid
    end

    it "カタカナが含まれているときは通らない" do
      senryu1 = Senryu.create(first_line: "あいうえオ", second_line: "あいうえおかき", third_line: "あいうえお")
      senryu2 = Senryu.create(first_line: "あいうえお", second_line: "あいうえおかキ", third_line: "あいうえお")
      senryu3 = Senryu.create(first_line: "あいうえお", second_line: "あいうえおかき", third_line: "あいうえオ")
      expect(senryu1).not_to be_valid
      expect(senryu2).not_to be_valid
      expect(senryu3).not_to be_valid
    end

    it "英語が含まれているときは通らない" do
      senryu1 = Senryu.create(first_line: "あいうえa", second_line: "あいうえおかき", third_line: "あいうえお")
      senryu2 = Senryu.create(first_line: "あいうえお", second_line: "あいうえおかa", third_line: "あいうえお")
      senryu3 = Senryu.create(first_line: "あいうえお", second_line: "あいうえおかき", third_line: "あいうえa")
      expect(senryu1).not_to be_valid
      expect(senryu2).not_to be_valid
      expect(senryu3).not_to be_valid
    end

    it "数字が含まれているときは通らない" do
      senryu1 = Senryu.create(first_line: "あいうえ1", second_line: "あいうえおかき", third_line: "あいうえお")
      senryu2 = Senryu.create(first_line: "あいうえお", second_line: "あいうえおか1", third_line: "あいうえお")
      senryu3 = Senryu.create(first_line: "あいうえお", second_line: "あいうえおかき", third_line: "あいうえ1")
      expect(senryu1).not_to be_valid
      expect(senryu2).not_to be_valid
      expect(senryu3).not_to be_valid
    end

    it "記号が含まれているときは通らない" do
      senryu1 = Senryu.create(first_line: "あいうえ!", second_line: "あいうえおかき", third_line: "あいうえお")
      senryu2 = Senryu.create(first_line: "あいうえお", second_line: "あいうえおか!", third_line: "あいうえお")
      senryu3 = Senryu.create(first_line: "あいうえお", second_line: "あいうえおかき", third_line: "あいうえ!")
      expect(senryu1).not_to be_valid
      expect(senryu2).not_to be_valid
      expect(senryu3).not_to be_valid
    end

  end

end