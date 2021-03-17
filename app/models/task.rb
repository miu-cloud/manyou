class Task < ApplicationRecord
    validates :title, presence: true, length: { in: 1..75 }  

end
