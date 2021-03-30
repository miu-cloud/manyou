class User < ApplicationRecord
  before_destroy :destroy_admin
  has_many :tasks, dependent: :destroy
  validates :name,  presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 },
                      format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  before_validation { email.downcase! }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  private
  def destroy_admin
    return unless self.admin?
    
    if User.where(admin: true).count <= 1
      throw(:abort)
    end
  end
end
