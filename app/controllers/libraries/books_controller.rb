class Libraries::BooksController < ApplicationController
  # Ensures that only authenticated users can access the actions in this controller.
  before_action :authenticate_user!

  # Fetches the library specified in the request parameters and authorizes it.
  # Ensures that the current user has access to the library.
  before_action :set_library

  # Fetches the book specified in the request parameters.
  # Ensures that the book belongs to the library and handles errors if it doesn't.
  before_action :set_book, only: [:show, :edit, :update, :destroy, :reserve, :approve_reservation, :cancel_reservation]

  # Displays the list of books for a specific library.
  # - Uses `policy_scope` to enforce authorization and filter accessible books.
  # - Ensures the user has access to view the library.
  def index
    authorize @library, :show?
  end

  # Displays the details of a specific book in the library.
  # - Authorizes the user to view the book.
  # - Loads reviews associated with the book.
  # - Prepares a new review instance for the user to add a review.
  # - Checks for any pending reservations for the book by the user.
  # - Displays an alert if the user's reservation was denied.
  def show
    authorize @book
  end

  # Prepares a new book for the library.
  # - Authorizes the user to add a new book to the library.
  def new
    authorize @book
  end

  # Creates a new book in the library.
  # - Authorizes the user to perform the action.
  # - Ensures quantity is set to `nil` for non-hardcover books.
  # - Saves the book and redirects to the books list or shows validation errors.
  def create
    authorize @book
  end

  # Prepares the form to edit an existing book in the library.
  # - Authorizes the user to edit the book.
  def edit
    authorize @book
  end

  # Updates the details of an existing book in the library.
  # - Authorizes the user to perform the update.
  # - Ensures quantity is set to `nil` for non-hardcover books.
  # - Saves changes and redirects to the book's details or shows validation errors.
  def update
    authorize @book
  end

  # Deletes a book from the library.
  # - Authorizes the user to delete the book.
  # - Removes the book and redirects to the books list with a success message.
  def destroy
    authorize @book
  end

  # Reserves a book for the current user.
  # - Authorizes the user to reserve the book.
  # - Creates a new pending checkout if the book is reservable.
  # - Updates the book's status and marks it as "not available" if all copies are reserved.
  # - Returns a success or failure response in JSON format.
  def reserve
    authorize @book
  end

  # Cancels a pending reservation for the current user.
  # - Authorizes the user to cancel the reservation.
  # - Finds and removes the reservation.
  # - Updates the book's status to "available" if no other reservations are pending.
  # - Redirects to the book's details with a success or error message.
  def cancel_reservation
    authorize @book
  end

  # Approves a reservation for a book.
  # - Authorizes the user to approve the reservation.
  # - Marks the book as reserved if it is in the "reserve_pending" status.
  # - Redirects back to the admin dashboard with a success or error message.
  def approve_reservation
    authorize @book
  end

  private

  # Fetches the library specified in the request parameters and authorizes it.
  # - Ensures the user has access to the library.
  # - Handles cases where the library is not found by redirecting to the homepage with an alert.
  def set_library
  end

  # Fetches the book specified in the request parameters.
  # - Ensures the book belongs to the library.
  # - Redirects to the books list with an alert if the book is not found.
  def set_book
    authorize @library, :show?
  end

  # Strong parameters to permit only allowed attributes for a book.
  # - Includes title, author, genre, year, format, and quantity.
  def book_params
  end
end
