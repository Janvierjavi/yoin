class Relationship < ApplicationRecord
  belongs_to :followed, class_name: 'User'
  belongs_to :follower, class_name: 'User'

  validate :follow_myself

  private

  def follow_myself
    errors[:base] << I18n.t('errors.messages.narcissism') if follower_id == followed_id
  end
end
