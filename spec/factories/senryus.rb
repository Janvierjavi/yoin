FactoryBot.define do
  factory :senryu do
    first_line { "あああああ" }
    second_line { "あああああああ" }
    third_line { "あああああ" }
  end

  factory :senryu_second, class: Senryu do
    first_line { "いいいいい" }
    second_line { "いいいいいいい" }
    third_line { "いいいいい" }
  end

  factory :senryu_third, class: Senryu do
    first_line { "ううううう" }
    second_line { "ううううううう" }
    third_line { "ううううう" }
  end
end