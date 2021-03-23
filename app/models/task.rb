class Task < ApplicationRecord
    validates :title, presence: true, length: { in: 1..75 }  
    enum priority: { low: 0, medium: 1, haigh: 2 }
    enum state: { not_started: 0, at_work: 1, done: 2 }

    scope :title, -> ( title ) {where('title LIKE ?', "%#{title}%")}
    scope :state, -> ( state ) {where(state: state)}
    # scope :priority, -> ( priority ) {where(priority: priority)}
end
