class User < ApplicationRecord
  validates_uniqueness_of :user_name, :email

  has_many :posts
  # Include default devise modules. Others available are:
  #and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, 
         :confirmable, :lockable, :timeoutable, :trackable 
end
