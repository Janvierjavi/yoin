module SenryusHelper
  def three_random_initials
    hiragana = ("あ".."ん").to_a
    not_want = ["ぁ", "ぃ", "ぅ", "ぇ", "ぉ", "っ", "ゃ", "ゅ", "ょ", "ゎ", "ゐ", "ゑ", "を", "ん"]
    initial_array = hiragana - not_want
    initial_array.sample(3)
  end
end