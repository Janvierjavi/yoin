class Senryu < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy

  validates :first_line, five_char_length: true
  validates :second_line, seven_char_length: true
  validates :third_line, five_char_length: true
  
  validate :other_than_hiragana

  include SearchCop
  search_scope :search do
    attributes :first_line, :second_line, :third_line
  end

  scope :subscribed_and_mine, -> (following, me) { where(user_id: following).or(Senryu.where(user_id: me)) }
  
  # home画面での検索フォームは設置しない仕様に変更となったが、ロジックは再利用する可能性もあるため残しておく
  # def self.in_home(params, me)
  #   if params[:senryu] && params[:senryu][:search_content]
  #     subscribed_and_mine(me.following, me).search(params[:senryu][:search_content])
  #   else
  #     subscribed_and_mine(me.following, me)
  #   end
  # end

  
  def self.in_discover(params)
    params.dig(:senryu, :search_content) ? 
    all.includes(:user, :favorites).search(params.dig(:senryu, :search_content)) : all.includes(:user, :favorites)
  end

  def self.timeline
    order(created_at: :desc)
  end

  def favorited(user_id)
    favorites.find_by(user_id: user_id)
  end

  private

  def hiragana?(string)
    nil != (string =~ /\A[\u3041-\u3096|ー]+\z/)
  end

  def other_than_hiragana
    unless hiragana?(first_line + second_line + third_line)
      errors[:base] << I18n.t('errors.messages.hiragana_only')
    end
  end

end