class NgWordValidator < ActiveModel::EachValidator
  NG_WORDS = ["あいえき", "あいぶ", "あおかん", "あくめ", "あなきょうだい", "あなる", "あぬす", "いちもつ", "いまらちお", "いらまちお", "いんけい", "いんこう", "いんしん", "いんのう", "いんもう", "いんらん", "うらすじ", "えんこう", "えんじょこうさい", "おなにー", "おなぺっと", "おまんこ", "おめこ", "おりもの", "おーがずむ", "かいめんたい", "かうぱー", "かせいほうけい", "かわかぶり", "がんしゃ", "がんめんしゃせい", "きじょうい", "きっこうしばり", "きとう", "きょにゅう", "きんたま", "くりとりす", "くんに", "くんにりんぐす", "こうないしゃせい", "こんどうむ", "こんどーむ", "ごうかん", "さおしまい", "さんぴー", "しおふき", "しっくすないん", "しゅいん", "しょじょ", "じぃすぽっと", "じいすぽっと", "じゅうかん", "じーすぽっと", "すかとろ", "すぺるま", "すまた", "すわっぴんぐ", "せいえき", "せいじょうい", "せっくす", "せんずり", "ぜんりつせん", "たちばっく", "たまきん", "ちじょ", "ちんかす", "ちんこ", "ちんぽ", "つるまん", "どうてい", "なかだし", "にくぼう", "ばぎな", "ぱいずり", "ぱいぱん", "ひんにゅう", "びにゅう", "ふぇら", "ふぇらちお", "ふたなり", "ふでおろし", "ぺにす", "ほうけい", "ぼっき", "ますかき", "ますかく", "ますをかき", "ますをかく", "まんかす", "まんこ", "まんじる", "やりちん", "やりまん", "らんこう", "れいぷ"]
  NG_WORDS.freeze

  private
  def include_ng_word?(string)
    NG_WORDS.any? {|i| string.include?(i)}
  end

  def validate_each(record, attribute, value)
    record.errors[attribute] << (options[:message] || I18n.t('errors.messages.ng_word')) if include_ng_word?(value)
  end
end
