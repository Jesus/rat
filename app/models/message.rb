class Message < ApplicationRecord
  belongs_to :user
  belongs_to :chat_room

  validates :body,
    presence: true,
    length: { minimum: 2, maximum: 1000 }

  after_create_commit do
    MessageBroadcastJob.perform_later(self)
  end
end
