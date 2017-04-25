class Message < ApplicationRecord
  scope :for_user, -> (user) { where(from_user_id: user).or(where(to_user_id: user)) }
  scope :latest, -> (n) { order(created_at: :desc).limit(n) }
end
