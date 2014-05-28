class User < ActiveRecord::Base
  validates :email, presence: true
  validates :email, uniqueness: true

  has_many :attended_concerts
  has_many :concerts, through: :attended_concerts

  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed

  has_many :reverse_relationships, foreign_key: "followed_id",
                                   class_name:  "Relationship",
                                   dependent:   :destroy
  has_many :followers, through: :reverse_relationships, source: :follower

  has_many :concert_photos

  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.email = auth.info.email
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end

  #being used in the user_controller.rb
  def followers(user_id)

    relationships = Relationship.where(followed_id: user_id)
    followers = relationships.map { |relationship| User.find(relationship.follower_id) }
    return followers

  end

  #being used in the user_controller.rb
  def following(user_id)

    relationships = Relationship.where(follower_id: user_id)
    followed_users = relationships.map { |relationship|  User.find(relationship.followed_id) }
    return followed_users

  end

  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    relationships.find_by_followed_id(other_user.id).destroy
  end
end
