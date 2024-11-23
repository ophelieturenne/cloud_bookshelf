class Book < ApplicationRecord
  # Associations
  belongs_to :library                 # Each book is associated with a specific library.
  belongs_to :user, optional: true    # A book can optionally belong to a user (e.g., the person who added it).
  has_many :checkouts, dependent: :destroy # A book can have multiple checkouts, which are deleted if the book is deleted.
  has_many :reviews, dependent: :destroy   # A book can have multiple reviews, which are deleted if the book is deleted.

  # Validations
  validates :title, :author, :genre, :year, :format, presence: true
  # The `title`, `author`, `genre`, `year`, and `format` fields must all be present.

  validates :status, inclusion: { in: %w[available reserve_pending reserved not_available] }
  # The `status` field must be one of the allowed values: "available", "reserve_pending", "reserved", or "not_available".

  validates :year, numericality: { only_integer: true, less_than_or_equal_to: Date.today.year }
  # The `year` field must be an integer and cannot be greater than the current year.

  validates :format, inclusion: { in: %w[ebook hardcover researchpaper] }
  # The `format` field must be one of the allowed values: "ebook", "hardcover", or "researchpaper".

  validates :quantity, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, if: -> { format == "hardcover" }
  # The `quantity` field is required and must be a non-negative integer, but only if the book is a "hardcover".

  # Callbacks
  after_initialize :set_defaults, unless: :persisted?
  # The `after_initialize` callback runs after the model is instantiated.
  # The `set_defaults` method is only called for new records (not persisted ones).

  # Default values
  def set_defaults
    self.status ||= "available"
    # If no `status` is set, default it to "available".
  end

  # Check if the book is reservable
  def reservable?
    format == 'hardcover' && quantity.to_i.positive? && status == "available"
    # A book is reservable if:
    # - It is a hardcover book.
    # - The quantity is greater than 0.
    # - The status is "available".
  end

  # Track availability
  def available_quantity
    quantity - checkouts.approved.count
    # Calculate the number of available copies by subtracting the number of approved checkouts
    # from the total quantity.
  end

  # Methods for status updates
  def mark_reserve_pending!
    update!(status: "reserve_pending")
    # Update the book's status to "reserve_pending".
  end

  def mark_reserved!
    update!(status: "reserved")
    # Update the book's status to "reserved".
  end

  def mark_available!
    update!(status: "available", quantity: checkouts.approved.count)
    # Update the book's status to "available" and set the quantity based on the number of approved checkouts.
  end

  def mark_not_available!
    update!(status: "not_available")
    # Update the book's status to "not_available".
  end

  def all_reserved?
    format == "hardcover" && checkouts.pending.count >= quantity
    # Check if all copies of the book are reserved.
    # This is true if:
    # - The book is a hardcover.
    # - The number of pending checkouts is greater than or equal to the quantity.
  end

  # Scopes
  scope :available, -> { where(status: "available") }
  # A scope to find all books with the status "available".
end
