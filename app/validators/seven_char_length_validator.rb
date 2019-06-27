class SevenCharLengthValidator < ActiveModel::EachValidator
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
  
  def validate_each(record, attribute, value)
    if include_sutegana?(value)
      record.errors[attribute] << (options[:message] || I18n.t('errors.messages.sutegana_rule')) if value.length != (7 + sutegana_length(value))
    else
      record.errors[attribute] << (options[:message] || I18n.t('errors.messages.seven_char_limit')) if value.length != 7
    end
  end

end