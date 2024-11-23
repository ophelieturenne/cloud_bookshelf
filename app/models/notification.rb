class Notification < ApplicationRecord
  # Associations
  belongs_to :user
  # A notification is associated with a specific user who receives the notification.
  # This creates a `user_id` foreign key in the `notifications` table.

  belongs_to :library
  # A notification is tied to a specific library.
  # This creates a `library_id` foreign key in the `notifications` table.

  # Validations
  validates :content, presence: true
  # Ensures that the `content` field (the message or text of the notification) is not empty.
end
