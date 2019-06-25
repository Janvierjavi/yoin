class Senryu < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy

  validate :first_line_length
  validate :second_line_length
  validate :third_line_length
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
    params[:senryu] && params[:senryu][:search_content] ? all.includes(:user, :favorites).search(params[:senryu][:search_content]) : all.includes(:user, :favorites)
  end

  def self.timeline
    order(created_at: :desc)
  end

  def favorited(user_id)
    favorites.find_by(user_id: user_id)
  end

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
      errors.add(:first_line, ": 捨て仮名(ァィゥェォャュョ)は前の字と合わせて一音とします") if first_line.length != (5 + sutegana_length(first_line))
    else
      errors.add(:first_line, ': 5文字でお願いします') if first_line.length != 5
    end
  end

  def second_line_length
    if include_sutegana?(second_line)
      errors.add(:second_line, ": 捨て仮名(ァィゥェォャュョ)は前の字と合わせて一音とします") if second_line.length != (7 + sutegana_length(second_line))
    else
      errors.add(:second_line, ': 7文字でお願いします') if second_line.length != 7
    end
  end

  def third_line_length
    if include_sutegana?(third_line)
      errors.add(:third_line, ": 捨て仮名(ァィゥェォャュョ)は前の字と合わせて一音とします") if third_line.length != (5 + sutegana_length(third_line))
    else
      errors.add(:third_line, ': 5文字でお願いします') if third_line.length != 5
    end
  end

  # def first_line_length
  #   if include_sutegana?(first_line)
  #     errors.add(:first_line, "is the wrong length (should be #{5 + sutegana_length(first_line)} characters)") if first_line.length != (5 + sutegana_length(first_line))
  #   else
  #     errors.add(:first_line, 'is the wrong length (should be 5)') if first_line.length != 5
  #   end
  # end

  # def second_line_length
  #   if include_sutegana?(second_line)
  #     errors.add(:second_line, "is the wrong length (should be #{7 + sutegana_length(second_line)} characters)") if second_line.length != (7 + sutegana_length(second_line))
  #   else
  #     errors.add(:second_line, 'is the wrong length (should be 7)') if second_line.length != 7
  #   end
  # end

  # def third_line_length
  #   if include_sutegana?(third_line)
  #     errors.add(:third_line, "is the wrong length (should be #{5 + sutegana_length(third_line)} characters)") if third_line.length != (5 + sutegana_length(third_line))
  #   else
  #     errors.add(:third_line, 'is the wrong length (should be 5)') if third_line.length != 5
  #   end
  # end

  def other_than_hiragana
    unless hiragana?(first_line + second_line + third_line)
      errors[:base] << "ひらがなでお願いします"
    end
  end

end