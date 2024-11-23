class Wishlist < ApplicationRecord
  # Associations
  belongs_to :user
  # Each wishlist entry is associated with a specific user who created it.
  # This establishes a foreign key `user_id` in the `wishlists` table.

  belongs_to :book
  # Each wishlist entry is tied to a specific book.
  # This establishes a foreign key `book_id` in the `wishlists` table.

  belongs_to :library
  # Each wishlist entry is linked to a specific library where the book is available.
  # This establishes a foreign key `library_id` in the `wishlists` table.

  # Validations
  validates :user_id, uniqueness: { scope: :book_id, message: "already added this book to wishlist" }
  # Ensures that a user cannot add the same book to their wishlist more than once.
  # The `scope: :book_id` specifies that the combination of `user_id` and `book_id` must be unique.
  # The custom error message provides clear feedback when this validation fails.
end
