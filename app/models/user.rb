class User < ApplicationRecord
  
  validates_uniqueness_of :email
  #validates :first_name, :user_name, :email, :password, :password_confirmation, presence: true
  
  # Include default devise modules. Others available are :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, 
  :rememberable, :validatable, :confirmable, :lockable, :timeoutable, :trackable 
  
  
  has_many :posts




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
