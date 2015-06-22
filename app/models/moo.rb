class Moo < ActiveRecord::Base
  def self.timeline(user)
    follows_ids = user.follows.map(&:id)
    all_ids = follows_ids << user.id
    Moo.where(user_id: all_ids).order("created_at DESC")
  end

  belongs_to :user

  validates :description, length: { maximum: 140 }
end
