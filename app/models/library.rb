class Library < ApplicationRecord
  # Associations
  has_many :books, dependent: :destroy
  # A library can have multiple books. If the library is deleted, all associated books are also deleted.

  has_many :library_users, dependent: :destroy
  # A library can have many `LibraryUser` records, representing its memberships.
  # If the library is deleted, all associated membership records are also deleted.

  has_many :users, through: :library_users
  # A library has many users through the `LibraryUser` join table.
  # This establishes a many-to-many relationship between libraries and users.

  has_many :checkouts, dependent: :destroy
  # A library can have multiple checkouts.
  # If the library is deleted, all associated checkouts are also deleted.

  has_many :notifications, dependent: :destroy
  # A library can have many notifications.
  # If the library is deleted, all associated notifications are also deleted.

  # Validations
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  # Ensures that the `name` is present and unique (case-insensitive).
  # For example, "Central Library" and "central library" would not be allowed to coexist.

  validates :unique_id, presence: true, uniqueness: true
  # Ensures that the `unique_id` is present and unique.
  # Each library must have a globally unique identifier.

  # Callbacks
  before_validation :generate_unique_id, on: :create
  # A `before_validation` callback ensures that a `unique_id` is generated before the library is validated.
  # This runs only when a new library is created.

  # Private Methods
  private

  def generate_unique_id
    self.unique_id ||= SecureRandom.uuid
    # Assigns a universally unique identifier (UUID) to the `unique_id` field if it is not already set.
    # `SecureRandom.uuid` generates a random UUID.
  end
end
