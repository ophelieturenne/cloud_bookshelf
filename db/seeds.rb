# Clear Previous Data
# This section removes all existing data from the database to ensure a clean slate.
# - Destroys all records for Reviews, Wishlists, Notifications, Checkouts, Books, LibraryUsers, Libraries, and Users.
# - Prints a confirmation message once the data is cleared.

# Create Users
# This section creates four users: one admin and three regular users (a librarian and two students).
# - The admin user (`cloudbookshelf_admin`) has admin privileges.
# - The librarian and students have standard user roles.
# - After creating the users, the count of users is displayed.

# Create Library
# This section creates the "Central Library" with a unique ID.
# - A UUID is generated for the library to uniquely identify it.
# - If the library creation is successful, its details are printed; otherwise, an error is raised.

# Assign Users to Library
# This section assigns the created users to the "Central Library."
# - The librarian is assigned as an admin of the library.
# - The students are assigned as regular members of the library.
# - The count of library users is displayed to confirm successful assignments.

# Create Books, Reviews, and Wishlists
# This section generates 5 books for the "Central Library" with random attributes.
# - Randomly assigns the book format as "ebook," "hardcover," or "researchpaper."
# - For hardcover books, assigns a random quantity.
# - Creates each book and prints a confirmation if successful.
# - Adds two reviews for each book: one from a random user and one specifically from `student`.
# - Adds the book to the `student`'s wishlist.

# Create Checkouts
# This section creates two checkout records for `student`.
# - Randomly selects a book from the library.
# - Creates a checkout with a pending status, a start date of today, and a due date of 7 days from now.
# - The total count of checkouts is printed.

# Create Notifications
# This section creates notifications for the library.
# - One notification informs `student` about new books being available.
# - Another notification informs `librarian` about a pending book reservation request.
# - The total count of notifications is printed.

# Create Additional Library
# This section creates a second library, the "Science Library," with a unique ID.
# - Assigns the `librarian` as an admin of the "Science Library."
# - Assigns `student_2` as a regular member of the "Science Library."
# - Prints the details of the created library and the count of its users.

# Final Message
# A confirmation message is printed to indicate that the seed data has been successfully loaded.

require 'faker'

# Clear previous data
puts "Clearing old data..."
Review.destroy_all
Wishlist.destroy_all
Notification.destroy_all
Checkout.destroy_all
Book.destroy_all
LibraryUser.destroy_all
Library.destroy_all
User.destroy_all
puts "All data cleared!"

# Create Users
puts "Creating users..."
cloudbookshelf_admin = User.create!(
  email: 'cloudbookshelf_admin@cloudbookshelf.com',
  password: 'password123',
  admin: true
)

librarian = User.create!(
  email: 'librarian@cloudbookshelf.com',
  password: 'password123',
  admin: false
)

student = User.create!(
  email: 'student@cloudbookshelf.com',
  password: 'password123',
  admin: false
)

student_2 = User.create!(
  email: 'student2@cloudbookshelf.com',
  password: 'password123',
  admin: false
)

puts "Users created: #{User.count}"

# Create Library
puts "Creating library..."
library = Library.create!(
  name: 'Central Library',
  unique_id: SecureRandom.uuid
)

if library.persisted?
  puts "Library successfully created: #{library.name} (ID: #{library.id})"
else
  raise "Library creation failed."
end

# Assign Users to Library
puts "Assigning users to library..."
LibraryUser.create!(user: librarian, library: library, is_admin: true)
LibraryUser.create!(user: student, library: library, is_admin: false)
LibraryUser.create!(user: student_2, library: library, is_admin: false)

puts "Library users assigned: #{LibraryUser.count}"

# Create Books, Reviews, and Wishlists
puts "Adding books to library and generating reviews..."
5.times do
  format = %w[ebook hardcover researchpaper].sample

  # Build the book attributes
  book_attributes = {
    title: Faker::Book.title,
    author: Faker::Book.author,
    genre: Faker::Book.genre,
    year: Faker::Number.between(from: 1900, to: Date.today.year),
    format: format,
    library: library,
    user: librarian, # Associated librarian as the creator
    qr_code: SecureRandom.uuid
  }

  # Add quantity only if the format is hardcover
  book_attributes[:quantity] = Faker::Number.between(from: 1, to: 5) if format == 'hardcover'

  book = Book.create!(book_attributes)

  if book.persisted?
    puts "Book created: #{book.title} (ID: #{book.id})"
  else
    puts "Failed to create book: #{book.errors.full_messages.join(', ')}"
  end

  # Add reviews for the book
  Review.create!(
    user: [librarian, student].sample, # Ensure it picks a valid user
    book: book,
    rating: Faker::Number.between(from: 1, to: 5),
    comment: Faker::Lorem.sentence
  )

  Review.create!(
    user: student,
    book: book,
    rating: Faker::Number.between(from: 1, to: 5),
    comment: "Great resource!"
  )

  # Add the book to a student's wishlist
  Wishlist.create!(
    user: student,
    book: book,
    library: library
  )
end

puts "Books added and reviewed: #{Book.count} books, #{Review.count} reviews"
puts "Wishlists created: #{Wishlist.count}"

# Create Checkouts
puts "Creating checkouts for students..."
2.times do
  book = library.books.sample
  Checkout.create!(
    user: student,
    book: book,
    library: library,
    start_date: Date.today,
    due_date: Date.today + 7.days,
    status: :pending
  )
end

puts "Checkouts created: #{Checkout.count}"

# Create Notifications
puts "Creating notifications..."
Notification.create!(
  user: student,
  library: library, # Associate notification with the library
  content: 'New books are now available in the library!'
)
Notification.create!(
  user: librarian,
  library: library, # Associate notification with the library
  content: 'A book reservation request is pending approval.'
)
puts "Notifications created: #{Notification.count}"

# Create Additional Library
puts "Creating additional library..."
library_2 = Library.create!(
  name: 'Science Library',
  unique_id: SecureRandom.uuid
)

LibraryUser.create!(user: librarian, library: library_2, is_admin: true)
LibraryUser.create!(user: student_2, library: library_2, is_admin: false)

puts "Additional library created: #{library_2.name} (ID: #{library_2.id})"
puts "Library users assigned to additional library: #{LibraryUser.where(library: library_2).count}"

puts "Seed data loaded successfully!"
