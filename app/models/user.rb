class User < ApplicationRecord
  
  validates_uniqueness_of :email

  validates :first_name, presence: true, allow_blank: false
  validates :user_name, presence: true, allow_blank: false
  validates :email, presence: true, allow_blank: false
  validates :password, presence: true, allow_blank: false
  validates :password_confirmation, presence: true, allow_blank: false
    
  
  # Include default devise modules. Others available are :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :confirmable, :lockable, :timeoutable, :trackable 
  
  
  has_many :posts, dependent: :destroy

  has_many :comments, dependent: :destroy


  #makes rails admin able to adjust user profiles wihtout password
  rails_admin do
    configure :set_password

    edit do
      exclude_fields :password, :password_confirmation
      include_fields :set_password
    end
  end

  # Provided for Rails Admin to allow the password to be reset
  def set_password; nil; end

  def set_password=(value)
    return nil if value.blank?
    self.password = value
    self.password_confirmation = value
  end
  
end
