class Review < ApplicationRecord
  # Associations
  belongs_to :user
  # A review is associated with a specific user who writes the review.
  # This creates a `user_id` foreign key in the `reviews` table.

  belongs_to :book
  # A review is associated with a specific book being reviewed.
  # This creates a `book_id` foreign key in the `reviews` table.

  # Validations
  validates :user, presence: true
  # Ensures that the review is associated with a user.

  validates :book, presence: true
  # Ensures that the review is associated with a book.

  validates :comment, presence: true
  # Ensures that the review has a comment (text) and prevents empty reviews.

  validates :rating, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }
  # Ensures that the rating:
  # - Is an integer.
  # - Is within the valid range (1 to 5).
end
