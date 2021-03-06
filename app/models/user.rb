class User < ActiveRecord::Base
	attr_accessible :name, :email, :password, :password_confirmation, 
                  :remember_me, :avatar, :provider, :uid, :email_favorites

  has_many :votes, dependent: :destroy  
  has_many :posts
  has_many :comments
  has_many :favorites, dependent: :destroy

  before_create :set_member
  mount_uploader :avatar, AvatarUploader

  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    unless user
      pass = Devise.friendly_token[0,20]
      user = User.new(name: auth.extra.raw_info.name,
                      provider: auth.provider,
                      uid: auth.uid,
                      email: auth.info.email,
                      password: pass,
                      password_confirmation: pass
                      )
      user.skip_confirmation!
      user.save
    end
    user
  end

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :omniauthable, :omniauth_providers => [:facebook]

  ROLES = %w[member moderator admin]

  def role?(base_role)
  	role.nil? ? false : ROLES.index(base_role.to_s) <= ROLES.index(role)
  end

  def favorited(post)
    self.favorites.where(post_id: post.id).first
  end

  private

  def set_member
  	self.role = 'member'	
  end
end
