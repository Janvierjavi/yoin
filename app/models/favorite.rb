class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :senryu, counter_cache: favorites_count
end
