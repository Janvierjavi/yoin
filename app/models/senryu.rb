class Senryu < ApplicationRecord
  with_options length: { is: 5 } do
    validates :first_line
    validates :third_line
  end
  validates :second_line, length: { is: 7 } 
  
end
