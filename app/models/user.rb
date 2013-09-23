class User < ActiveRecord::Base
	attr_accessible :name, :email, :password, :password_confirmation, :remember_me
  has_many :posts

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable

end
