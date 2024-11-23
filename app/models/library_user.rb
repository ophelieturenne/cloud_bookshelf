class LibraryUser < ApplicationRecord
  # Associations
  belongs_to :user     # Each LibraryUser record connects to a specific user.
  belongs_to :library  # Each LibraryUser record connects to a specific library.

  # Validation
  validates :user_id, uniqueness: { scope: :library_id, message: "is already a member of this library" }
  # Ensures that a user can only be associated with a library once.
  # The `scope: :library_id` means the combination of `user_id` and `library_id` must be unique.
  # The custom error message "is already a member of this library" will be displayed if the validation fails.
end
