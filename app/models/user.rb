class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :masqueradable, :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: %i[facebook Github]

  has_person_name

  has_many :notifications, foreign_key: :recipient_id
  has_many :services

  has_one_attached :avatar

  has_many :friendships
  has_many :friends, :through => :friendships 
  has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
  has_many :inverse_friends, :through => :inverse_friendships, :source => :user

  has_many :groups, dependent: :destroy
  has_many :posts
  
end
