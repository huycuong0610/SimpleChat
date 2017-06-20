class User < ApplicationRecord
	validates :name, presence: true
	validates :email, presence: true, uniqueness: {case_insensitive: false}
	has_secure_password
	has_many :friendships
	has_many :friends, :through => :friendships
	has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
	has_many :inverse_friends, :through => :inverse_friendships, :source => :user


end
