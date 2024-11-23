class Libraries::UserDashboardsController < ApplicationController
  # Ensures that only authenticated users can access the actions in this controller.
  before_action :authenticate_user!

  # Fetches the library specified in the request parameters.
  # Handles cases where the library is not found.
  before_action :set_library

  # Displays the user dashboard for a specific library.
  # - Authorizes the action using the `user_dashboard?` policy to ensure the user has access.
  # - Loads all books available in the library.
  # - Fetches all approved reservations for the current user, including associated books.
  # - Fetches all wishlist books for the current user in the library.
  # - Fetches all notifications for the current user, ordered by the most recent.
  def show
    authorize @library, :user_dashboard?
  end

  private

  # Fetches the library specified in the request parameters.
  # - Handles cases where the library is not found by redirecting the user to the libraries list with an alert.
  def set_library
  end
end
