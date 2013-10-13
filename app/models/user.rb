class User < ActiveRecord::Base
	attr_accessible :name, :email, :password, :password_confirmation, 
                  :remember_me, :avatar, :comments
                  
  has_many :posts

  before_create :set_member
  mount_uploader :avatar, AvatarUploader

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable

  ROLES = %w[member moderator admin]

  def role?(base_role)
  	role.nil? ? false : ROLES.index(base_role.to_s) <= ROLES.index(role)
  end

  private

  def set_member
  	self.role = 'member'	
  end
end
