class User < ActiveRecord::Base
  has_many :moos

  acts_as_followable
  acts_as_follower

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Avatar uploader using carrierwave
  mount_uploader :avatar, AvatarUploader
end
