class HiraganaOnlyValidator < ActiveModel::EachValidator
  def hiragana?(string)
    nil != (string =~ /\A[\u3041-\u3096|ー]+\z/)
  end

  def validate_each(record, attribute, value)
    record.errors[attribute] << (options[:message] || I18n.t('errors.messages.hiragana_only')) unless hiragana?(value)
  end
end