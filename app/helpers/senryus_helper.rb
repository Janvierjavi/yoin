module SenryusHelper
  def three_random_initials
    hiragana = ("あ".."ん").to_a
    not_want = ["ぁ", "ぃ", "ぅ", "ぇ", "ぉ", "っ", "ゃ", "ゅ", "ょ", "ゎ", "ゐ", "ゑ", "を", "ん"]
    initial_array = hiragana - not_want
    initial_array.sample(3)
  end

  def first_initial
    three_random_initials[0]
  end

  def second_initial
    three_random_initials[1]
  end

  def third_initial
    three_random_initials[2]
  end
end