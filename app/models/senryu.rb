class Senryu < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy

  [:first_line, :second_line, :third_line].each do |attribute|
    if attribute == :second_line
      validates attribute, seven_char_length: true
      validates attribute, ng_word: true
      validates attribute, hiragana_only: true
    else
      validates attribute, five_char_length: true
      validates attribute, ng_word: true
      validates attribute, hiragana_only: true
    end
  end
  
  include SearchCop
  search_scope :search do
    attributes :first_line, :second_line, :third_line
  end

  scope :subscribed_and_mine, -> (following, me) { where(user_id: following).or(Senryu.where(user_id: me)) }
  scope :discover_senryus, -> (params) { search(params.dig(:senryu, :search_content)) if params.dig(:senryu, :search_content)}
  scope :timeline, -> { order(created_at: :desc) }
  
  def favorited(user_id)
    favorites.find_by(user_id: user_id)
  end
end