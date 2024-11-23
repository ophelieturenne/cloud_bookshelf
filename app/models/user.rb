class User < ApplicationRecord
  # Devise modules for authentication
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # Devise adds functionality to handle:
  # - `database_authenticatable`: Handles user login with encrypted passwords.
  # - `registerable`: Allows users to sign up and manage their accounts.
  # - `recoverable`: Provides password recovery via email.
  # - `rememberable`: Enables "remember me" functionality for persistent sessions.
  # - `validatable`: Ensures email and password are valid (e.g., password length, email format).

  # Associations
  has_many :library_users
  # A user can belong to multiple libraries through the `LibraryUser` join table.

  has_many :books
  # A user can create multiple books, for example, if they act as a librarian managing book records.

  has_many :checkouts
  # A user can borrow books via checkouts.

  has_many :notifications
  # A user can have multiple notifications, e.g., overdue reminders or library announcements.

  has_many :wishlists
  # A user can create wishlists to save books they want to borrow or keep track of.

  has_many :reviews
  # A user can write multiple reviews for books.

  has_many :libraries, through: :library_users
  # A user is associated with multiple libraries through the `LibraryUser` join table.

  # Validations
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  # Ensures that:
  # - The `email` field is present.
  # - The email is unique, ignoring case differences (e.g., "User@example.com" and "user@example.com" are treated as the same).

  # Instance Methods
  def library_admin?(library)
    library_users.exists?(library: library, is_admin: true)
    # Checks if the user is an admin for the given library.
    # The method:
    # - Finds a `LibraryUser` record where:
    #   - The `library` matches the argument.
    #   - `is_admin` is set to true.
    # - Returns `true` if such a record exists, otherwise `false`.
  end
end
