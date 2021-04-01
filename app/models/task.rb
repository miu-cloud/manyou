class Task < ApplicationRecord
    belongs_to :user
    has_many :labellings, dependent: :destroy
    has_many :labels, through: :labellings
    
    validates :title, presence: true, length: { in: 1..75 }  
    enum priority: { 低: 0, 中: 1, 高: 2 }
    enum state: { 未着手: 0, 着手中: 1, 完了: 2 }

    scope :title_search, -> ( title ) {where('title LIKE ?', "%#{title}%")}
    scope :state_search, -> ( state ) {where(state: state)}
    # scope :priority, -> ( priority ) {where(priority: priority)}
end
