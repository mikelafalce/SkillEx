class Message < ApplicationRecord
  belongs_to :to_user, class_name: 'User'
  belongs_to :from_user, class_name: 'User'

  scope :for_user, -> (user) { where(from_user_id: user).or(where(to_user_id: user)) }
  scope :latest, -> (n) { order(created_at: :desc).limit(n) }
end
