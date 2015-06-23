class Moo < ActiveRecord::Base
  def self.timeline(user)
    fallowed_ids = user.follows.pluck(:followable_id)
    all_ids = fallowed_ids << user.id
    Moo.where(user_id: all_ids).order("created_at DESC")
  end

  belongs_to :user

  validates :description, length: { maximum: 140 }
end