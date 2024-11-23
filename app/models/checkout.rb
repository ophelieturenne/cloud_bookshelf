class Checkout < ApplicationRecord
  # Associations
  belongs_to :user       # A checkout is linked to a specific user who checks out the book.
  belongs_to :book       # A checkout is for a specific book.
  belongs_to :library    # A checkout is associated with a specific library.

  # Validations
  validates :start_date, :due_date, presence: true
  # Ensures that both the `start_date` (when the book was checked out) and the `due_date` (when the book is due) are provided.

  # Enumerations
  enum status: { pending: 0, approved: 1, returned: 2, denied: 3 }
  # Defines the possible statuses for a checkout:
  # - `pending`: The checkout request is awaiting approval.
  # - `approved`: The checkout request has been approved, and the book is checked out.
  # - `returned`: The book has been returned to the library.
  # - `denied`: The checkout request was denied.

  # Scopes
  scope :current_reservations, -> { where(is_returned: false).order(created_at: :asc) }
  # Retrieves all checkouts where the book has not been returned (`is_returned: false`),
  # and orders them by their creation date in ascending order.

  scope :approved, -> { where(status: "approved") }
  # Retrieves all checkouts with the `approved` status.

  scope :pending, -> { where(status: "pending") }
  # Retrieves all checkouts with the `pending` status.

  # Business Logic
  # Handle automatic reservation expiration (4 days)
  def expire!
    return unless pending? && created_at < 4.days.ago
    # The `expire!` method is used to handle automatic expiration of checkout requests.
    # This logic applies only to:
    # - Pending checkouts.
    # - Checkouts created more than 4 days ago.

    update!(status: "returned")
    # If the conditions are met, the status of the checkout is updated to `returned`.

    book.mark_available!
    # The associated book's status is updated to "available" using its `mark_available!` method.
  end
end
