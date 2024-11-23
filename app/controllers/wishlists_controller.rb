class WishlistsController < ApplicationController
  # Ensures that only authenticated users can access the actions in this controller.
  before_action :authenticate_user!

  # Fetches the library specified in the request parameters.
  # Ensures that the library exists and handles errors if it doesn't.
  before_action :set_library, only: %i[create index]

  # Ensures that all actions in this controller call `authorize` for Pundit authorization.
  after_action :verify_authorized

  # Adds a book to the user's wishlist for a specific library.
  # - Builds a new wishlist instance for the current user with the specified book and library.
  # - Authorizes the action to ensure the user is allowed to add books to the wishlist.
  # - Saves the wishlist and redirects to the library's books page with a success message.
  # - If saving fails, redirects back with an error message.
  def create
    authorize @wishlist
  end

  # Displays the user's wishlist for a specific library.
  # - Fetches all books on the user's wishlist for the specified library.
  # - Authorizes the action to ensure the user is allowed to view the wishlist.
  def index
    authorize :wishlist, :index?
  end

  private

  # Fetches the library specified in the request parameters.
  # - Redirects to the libraries list with an alert if the library is not found.
  def set_library
  end

  # Strong parameters to permit only allowed attributes for a wishlist.
  # - Includes `book_id` (the ID of the book to be added to the wishlist).
  def wishlist_params
  end
end
