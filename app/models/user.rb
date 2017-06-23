class User < ApplicationRecord
	validates :name, presence: true
	validates :email, presence: true, uniqueness: {case_insensitive: false}
	has_secure_password
	has_many :friendships
	has_many :friends, :through => :friendships
	has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
	has_many :inverse_friends, :through => :inverse_friendships, :source => :user
	has_many :block_relations, -> { where block: 1, active: true }, class_name: Friendship

	def received_messages
		Message.where(recipient_id: self)
	end

	def sent_messages
		Message.where(sender_id: self)
	end

	def lastest_received_messages(limit)
		received_messages.where('sender_id NOT IN (?)', block_relations.select(:target_id)).order(created_at: :desc).limit(limit)
	end

	def unread_messages
		received_messages.unread
	end

	def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end
end
