class Senryu < ApplicationRecord
  validate :first_line_length
  validate :second_line_length
  validate :third_line_length

  SUTEGANA = ["ぁ", "ぃ", "ぅ", "ぇ", "ぉ", "ゃ", "ゅ", "ょ"]
  SUTEGANA.freeze

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

  def first_line_length
    if include_sutegana?(first_line)
      errors.add(:first_line, "is the wrong length (should be #{5 + sutegana_length(first_line)} characters)") if first_line.length != (5 + sutegana_length(first_line))
    else
      errors.add(:first_line, '5 + sutegana_length(first_line)') if first_line.length != 5
    end
  end

  def second_line_length
    if include_sutegana?(second_line)
      errors.add(:second_line, "is the wrong length (should be #{7 + sutegana_length(second_line)} characters)") if second_line.length != (7 + sutegana_length(second_line))
    else
      errors.add(:second_line, '5 + sutegana_length(second_line)') if second_line.length != 7
    end
  end

  def third_line_length
    if include_sutegana?(third_line)
      errors.add(:third_line, "is the wrong length (should be #{5 + sutegana_length(third_line)} characters)") if third_line.length != (5 + sutegana_length(third_line))
    else
      errors.add(:third_line, '5 + sutegana_length(third_line)') if third_line.length != 5
    end
  end

end