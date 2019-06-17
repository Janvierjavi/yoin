class Senryu < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy

  def favorited(user_id)
    favorites.find_by(user_id: user_id)
  end

  validate :first_line_length
  validate :second_line_length
  validate :third_line_length
  validate :other_than_hiragana

  SUTEGANA = ["ぁ", "ぃ", "ぅ", "ぇ", "ぉ", "ゃ", "ゅ", "ょ"]
  SUTEGANA.freeze

  private

  def include_sutegana?(string)
    SUTEGANA.any? { |i| string.split("").include?(i) }
  end

  def sutegana_length(string)
    arr = []
    string.split("").each do |i|
      if SUTEGANA.include?(i)
        arr << i
      end
    end
    arr.length
  end

  def hiragana?(string)
    nil != (string =~ /\A[\u3041-\u3096|ー]+\z/)
  end

  def first_line_length
    if include_sutegana?(first_line)
      errors.add(:first_line, "is the wrong length (should be #{5 + sutegana_length(first_line)} characters)") if first_line.length != (5 + sutegana_length(first_line))
    else
      errors.add(:first_line, 'is the wrong length (should be 5)') if first_line.length != 5
    end
  end

  def second_line_length
    if include_sutegana?(second_line)
      errors.add(:second_line, "is the wrong length (should be #{7 + sutegana_length(second_line)} characters)") if second_line.length != (7 + sutegana_length(second_line))
    else
      errors.add(:second_line, 'is the wrong length (should be 7)') if second_line.length != 7
    end
  end

  def third_line_length
    if include_sutegana?(third_line)
      errors.add(:third_line, "is the wrong length (should be #{5 + sutegana_length(third_line)} characters)") if third_line.length != (5 + sutegana_length(third_line))
    else
      errors.add(:third_line, 'is the wrong length (should be 5)') if third_line.length != 5
    end
  end

  def other_than_hiragana
    unless hiragana?(first_line + second_line + third_line)
      errors[:base] << "ひらがな以外の文字があるため無効です"
    end
  end

end